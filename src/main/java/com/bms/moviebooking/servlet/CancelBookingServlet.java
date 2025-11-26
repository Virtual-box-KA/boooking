package com.bms.moviebooking.servlet;

import com.bms.moviebooking.dao.BookingDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/cancel-booking")
public class CancelBookingServlet extends HttpServlet {

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
        String bookingIdStr = req.getParameter("bookingId");

        if (bookingIdStr == null) {
            resp.sendRedirect("mybookings.jsp");
            return;
        }

        int bookingId = Integer.parseInt(bookingIdStr);

        try {
            boolean success = bookingDAO.cancelBooking(bookingId, userId);
            // you could set a message in session if you want
            resp.sendRedirect("mybookings.jsp");
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
