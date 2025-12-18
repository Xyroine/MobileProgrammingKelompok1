// ✅ PERBAIKAN: Import flutter/material.dart dihapus karena tidak dipakai
class Booking {
  final String id;
  final String roomName;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int guests;
  final int nights;
  final int totalPrice;
  final String imageUrl;
  final DateTime bookingDate;
  final String status; // 'Confirmed', 'Cancelled', etc.

  Booking({
    required this.id,
    required this.roomName,
    required this.checkInDate,
    required this.checkOutDate,
    required this.guests,
    required this.nights,
    required this.totalPrice,
    required this.imageUrl,
    required this.bookingDate,
    required this.status,
  });
}

class BookingService {
  // Simpan data di memory sementara (bisa diganti database nanti)
  static final List<Booking> _bookings = [];

  static void addBooking(Booking booking) {
    _bookings.add(booking);
  }

  static List<Booking> getAllBookings() {
    // Sort dari yang terbaru
    _bookings.sort((a, b) => b.bookingDate.compareTo(a.bookingDate));
    return _bookings;
  }
}