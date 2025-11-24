package com.bms.moviebooking.dao;

import com.bms.moviebooking.model.Seat;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SeatDAO {

    public List<Seat> getSeatsByShowId(int showId) throws SQLException {
        List<Seat> seats = new ArrayList<>();
        String sql = "SELECT * FROM seats WHERE show_id = ? ORDER BY seat_no";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, showId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Seat seat = new Seat();
                    seat.setId(rs.getInt("id"));
                    seat.setShowId(rs.getInt("show_id"));
                    seat.setSeatNo(rs.getString("seat_no"));
                    seat.setStatus(rs.getString("status"));
                    seats.add(seat);
                }
            }
        }
        return seats;
    }

    // in com.bms.moviebooking.dao.SeatDAO

    public void createSeatsForShow(int showId, int totalSeats) throws SQLException {
        String sql = "INSERT INTO seats (show_id, seat_no, status) VALUES (?, ?, 'AVAILABLE')";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            for (int i = 1; i <= totalSeats; i++) {
                String seatNo = "S" + i;  // seat numbers: S1, S2, S3, ...
                ps.setInt(1, showId);
                ps.setString(2, seatNo);
                ps.addBatch();
            }
            ps.executeBatch();
        }
    }

}
