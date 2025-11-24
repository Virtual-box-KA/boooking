package com.bms.moviebooking.dao;

import com.bms.moviebooking.model.Show;
import java.math.BigDecimal; // at top

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ShowDAO {

    public List<Show> getShowsByMovieId(int movieId) throws SQLException {
        List<Show> shows = new ArrayList<>();
        String sql = "SELECT * FROM shows WHERE movie_id = ? ORDER BY show_date, show_time";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, movieId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Show s = new Show();
                    s.setId(rs.getInt("id"));
                    s.setMovieId(rs.getInt("movie_id"));
                    s.setShowDate(rs.getDate("show_date").toLocalDate());
                    s.setShowTime(rs.getTime("show_time").toLocalTime());
                    s.setScreen(rs.getInt("screen"));
                    shows.add(s);
                }
            }
        }
        return shows;
    }

    public Show getShowById(int id) throws SQLException {
        String sql = "SELECT * FROM shows WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Show s = new Show();
                    s.setId(rs.getInt("id"));
                    s.setMovieId(rs.getInt("movie_id"));
                    s.setShowDate(rs.getDate("show_date").toLocalDate());
                    s.setShowTime(rs.getTime("show_time").toLocalTime());
                    s.setScreen(rs.getInt("screen"));
                    s.setPrice(rs.getBigDecimal("price"));
                    return s;
                }
            }
        }
        return null;
    }

    // in com.bms.moviebooking.dao.ShowDAO



    public int addShow(Show show) throws SQLException {
        String sql = "INSERT INTO shows (movie_id, show_date, show_time, screen, price) " +
                "VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, show.getMovieId());
            ps.setDate(2, java.sql.Date.valueOf(show.getShowDate()));
            ps.setTime(3, java.sql.Time.valueOf(show.getShowTime()));
            ps.setInt(4, show.getScreen());
            ps.setBigDecimal(5, show.getPrice());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        int id = rs.getInt(1);
                        show.setId(id);
                        return id;
                    }
                }
            }
        }
        return -1;
    }

}
