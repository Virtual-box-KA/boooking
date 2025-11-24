package com.bms.moviebooking.dao;

import com.bms.moviebooking.model.Booking;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    // existing bookSeats method
    public boolean bookSeats(int userId, int showId, List<String> seatNos) throws SQLException {
        String updateSeatSql = "UPDATE seats SET status = 'BOOKED' " +
                "WHERE show_id = ? AND seat_no = ? AND status = 'AVAILABLE'";

        String insertBookingSql = "INSERT INTO bookings (user_id, show_id, seat_no, payment_status) " +
                "VALUES (?, ?, ?, 'SUCCESS')";

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);
            try {
                int updatedCount = 0;

                try (PreparedStatement updatePs = conn.prepareStatement(updateSeatSql)) {
                    for (String seatNo : seatNos) {
                        updatePs.setInt(1, showId);
                        updatePs.setString(2, seatNo);
                        updatedCount += updatePs.executeUpdate();
                    }
                }

                if (updatedCount != seatNos.size()) {
                    conn.rollback();
                    return false;
                }

                try (PreparedStatement insertPs = conn.prepareStatement(insertBookingSql)) {
                    for (String seatNo : seatNos) {
                        insertPs.setInt(1, userId);
                        insertPs.setInt(2, showId);
                        insertPs.setString(3, seatNo);
                        insertPs.addBatch();
                    }
                    insertPs.executeBatch();
                }

                conn.commit();
                return true;
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            } finally {
                conn.setAutoCommit(true);
            }
        }
    }

    // 🔥 THIS is the method JSP is trying to call
    public List<Booking> getBookingsByUserId(int userId) throws SQLException {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT * FROM bookings WHERE user_id = ? ORDER BY booking_time DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Booking b = new Booking();
                    b.setId(rs.getInt("id"));
                    b.setUserId(rs.getInt("user_id"));
                    b.setShowId(rs.getInt("show_id"));
                    b.setSeatNo(rs.getString("seat_no"));
                    b.setBookingTime(rs.getTimestamp("booking_time"));
                    b.setPaymentStatus(rs.getString("payment_status"));
                    list.add(b);
                }
            }
        }
        return list;
    }
}
