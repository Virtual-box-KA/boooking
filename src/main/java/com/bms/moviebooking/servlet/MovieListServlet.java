package com.bms.moviebooking.servlet;

import com.bms.moviebooking.dao.MovieDAO;
import com.bms.moviebooking.model.Movie;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/movies")
public class MovieListServlet extends HttpServlet {

    private MovieDAO movieDAO = new MovieDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            List<Movie> movies = movieDAO.getAllMovies();
            req.setAttribute("movies", movies);
            req.getRequestDispatcher("movies.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
