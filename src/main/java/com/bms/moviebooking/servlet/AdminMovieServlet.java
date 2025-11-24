package com.bms.moviebooking.servlet;

import com.bms.moviebooking.dao.MovieDAO;
import com.bms.moviebooking.dao.SeatDAO;
import com.bms.moviebooking.dao.ShowDAO;
import com.bms.moviebooking.model.Movie;
import com.bms.moviebooking.model.Show;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalTime;

@WebServlet("/admin/add-movie")
public class AdminMovieServlet extends HttpServlet {

    private MovieDAO movieDAO = new MovieDAO();
    private ShowDAO showDAO = new ShowDAO();
    private SeatDAO seatDAO = new SeatDAO();

    // show the form
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        String role = (session != null) ? (String) session.getAttribute("userRole") : null;

        if (role == null || !"ADMIN".equalsIgnoreCase(role)) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return;
        }

        req.getRequestDispatcher("admin_add_movie.jsp").forward(req, resp);
    }

    // handle form submit
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        String role = (session != null) ? (String) session.getAttribute("userRole") : null;

        if (role == null || !"ADMIN".equalsIgnoreCase(role)) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return;
        }

        req.setCharacterEncoding("UTF-8");

        String title = req.getParameter("title");
        String genre = req.getParameter("genre");
        String language = req.getParameter("language");
        String durationStr = req.getParameter("duration");
        String description = req.getParameter("description");
        String posterUrl = req.getParameter("posterUrl");

        String showDateStr = req.getParameter("showDate");
        String showTimeStr = req.getParameter("showTime");
        String screenStr   = req.getParameter("screen");
        String priceStr    = req.getParameter("price");
        String seatsStr    = req.getParameter("totalSeats");

        try {
            int duration = Integer.parseInt(durationStr);
            int screen   = Integer.parseInt(screenStr);
            int totalSeats = Integer.parseInt(seatsStr);
            BigDecimal price = new BigDecimal(priceStr);

            LocalDate showDate = LocalDate.parse(showDateStr);         // yyyy-MM-dd
            LocalTime showTime = LocalTime.parse(showTimeStr);         // HH:mm

            // 1) Insert movie
            Movie movie = new Movie();
            movie.setTitle(title);
            movie.setGenre(genre);
            movie.setLanguage(language);
            movie.setDuration(duration);
            movie.setDescription(description);
            movie.setPosterUrl(posterUrl);

            int movieId = movieDAO.addMovie(movie);
            if (movieId <= 0) {
                req.setAttribute("error", "Failed to insert movie.");
                req.getRequestDispatcher("admin_add_movie.jsp").forward(req, resp);
                return;
            }

            // 2) Insert show
            Show show = new Show();
            show.setMovieId(movieId);
            show.setShowDate(showDate);
            show.setShowTime(showTime);
            show.setScreen(screen);
            show.setPrice(price);

            int showId = showDAO.addShow(show);
            if (showId <= 0) {
                req.setAttribute("error", "Failed to insert show.");
                req.getRequestDispatcher("admin_add_movie.jsp").forward(req, resp);
                return;
            }

            // 3) Create seats for the show
            seatDAO.createSeatsForShow(showId, totalSeats);

            req.setAttribute("message", "Movie, show, and seats added successfully.");
            req.getRequestDispatcher("admin_add_movie.jsp").forward(req, resp);

        } catch (NumberFormatException e) {
            req.setAttribute("error", "Invalid numeric input (duration, screen, seats, or price).");
            req.getRequestDispatcher("admin_add_movie.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
