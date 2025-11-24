package com.bms.moviebooking.servlet;

import com.bms.moviebooking.dao.SeatDAO;
import com.bms.moviebooking.dao.ShowDAO;
import com.bms.moviebooking.model.Seat;
import com.bms.moviebooking.model.Show;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/seats")
public class SeatSelectionServlet extends HttpServlet {

    private SeatDAO seatDAO = new SeatDAO();
    private ShowDAO showDAO = new ShowDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String showIdStr = req.getParameter("showId");
        if (showIdStr == null) {
            resp.sendRedirect("movies");
            return;
        }

        int showId = Integer.parseInt(showIdStr);

        try {
            List<Seat> seats = seatDAO.getSeatsByShowId(showId);
            Show show = showDAO.getShowById(showId);

            req.setAttribute("showId", showId);
            req.setAttribute("seats", seats);
            req.setAttribute("show", show);

            String error = req.getParameter("error");
            if (error != null) {
                req.setAttribute("error", "Some seats were already booked. Please choose again.");
            }

            req.getRequestDispatcher("seats.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
