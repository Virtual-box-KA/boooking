package com.bms.moviebooking.dao;

import com.bms.moviebooking.model.Movie;
import java.sql.*;
        import java.util.ArrayList;
import java.util.List;

public class MovieDAO {

    public List<Movie> getAllMovies() throws SQLException {
        List<Movie> movies = new ArrayList<>();
        String sql = "SELECT * FROM movies";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Movie m = new Movie();
                m.setId(rs.getInt("id"));
                m.setTitle(rs.getString("title"));
                m.setGenre(rs.getString("genre"));
                m.setLanguage(rs.getString("language"));
                m.setDuration(rs.getInt("duration"));
                m.setDescription(rs.getString("description"));
                m.setPosterUrl(rs.getString("poster_url"));
                movies.add(m);
            }
        }
        return movies;
    }

    public Movie getMovieById(int id) throws SQLException {
        String sql = "SELECT * FROM movies WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Movie m = new Movie();
                    m.setId(rs.getInt("id"));
                    m.setTitle(rs.getString("title"));
                    m.setGenre(rs.getString("genre"));
                    m.setLanguage(rs.getString("language"));
                    m.setDuration(rs.getInt("duration"));
                    m.setDescription(rs.getString("description"));
                    m.setPosterUrl(rs.getString("poster_url"));
                    return m;
                }
            }
        }
        return null;
    }

    // in com.bms.moviebooking.dao.MovieDAO

    public int addMovie(Movie movie) throws SQLException {
        String sql = "INSERT INTO movies (title, genre, language, duration, description, poster_url) " +
                "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, movie.getTitle());
            ps.setString(2, movie.getGenre());
            ps.setString(3, movie.getLanguage());
            ps.setInt(4, movie.getDuration());
            ps.setString(5, movie.getDescription());
            ps.setString(6, movie.getPosterUrl());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        int id = rs.getInt(1);
                        movie.setId(id);
                        return id;
                    }
                }
            }
        }
        return -1;
    }

}
