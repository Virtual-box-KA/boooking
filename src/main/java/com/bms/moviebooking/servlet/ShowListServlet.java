package com.bms.moviebooking.servlet;

import com.bms.moviebooking.dao.MovieDAO;
import com.bms.moviebooking.dao.ShowDAO;
import com.bms.moviebooking.model.Movie;
import com.bms.moviebooking.model.Show;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/shows")
public class ShowListServlet extends HttpServlet {

    private ShowDAO showDAO = new ShowDAO();
    private MovieDAO movieDAO = new MovieDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String movieIdStr = req.getParameter("movieId");
        if (movieIdStr == null) {
            resp.sendRedirect("movies");
            return;
        }

        int movieId = Integer.parseInt(movieIdStr);

        try {
            List<Show> shows = showDAO.getShowsByMovieId(movieId);
            Movie movie = movieDAO.getMovieById(movieId);

            req.setAttribute("shows", shows);
            req.setAttribute("movie", movie);

            req.getRequestDispatcher("shows.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
