package com.bms.moviebooking.servlet;

import com.bms.moviebooking.dao.BookingDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Arrays;

@WebServlet("/book")
public class BookingServlet extends HttpServlet {

    private BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");
        String showIdStr = req.getParameter("showId");
        String[] seats = req.getParameterValues("seats");

        if (showIdStr == null || seats == null || seats.length == 0) {
            resp.sendRedirect("seats?showId=" + showIdStr + "&error=1");
            return;
        }

        int showId = Integer.parseInt(showIdStr);

        try {
            boolean success = bookingDAO.bookSeats(userId, showId, Arrays.asList(seats));
            if (success) {
                resp.sendRedirect("mybookings.jsp");
            } else {
                resp.sendRedirect("seats?showId=" + showId + "&error=1");
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
