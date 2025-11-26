package com.bms.moviebooking.servlet;

import com.bms.moviebooking.dao.ShowDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/admin/cancel-show")
public class AdminCancelShowServlet extends HttpServlet {

    private ShowDAO showDAO = new ShowDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        String role = (session != null) ? (String) session.getAttribute("userRole") : null;

        // If you don't use roles and only rely on secret URL, you can remove this block.
        if (role == null || !"ADMIN".equalsIgnoreCase(role)) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return;
        }

        String showIdStr = req.getParameter("showId");
        String movieIdStr = req.getParameter("movieId");

        if (showIdStr == null) {
            resp.sendRedirect("movies");
            return;
        }

        int showId = Integer.parseInt(showIdStr);

        try {
            showDAO.deleteShow(showId);
            // redirect back to the show's movie page
            if (movieIdStr != null) {
                resp.sendRedirect("shows?movieId=" + movieIdStr);
            } else {
                resp.sendRedirect("movies");
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
