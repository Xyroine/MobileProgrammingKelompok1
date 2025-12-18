import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/booking_model.dart';

class CustomerBookingHistoryScreen extends StatelessWidget {
  const CustomerBookingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookings = BookingService.getAllBookings();

    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: AppBar(
        backgroundColor: AppTheme.darkBackground,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text('My Bookings',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Serif',
                color: Colors.white)),
      ),
      body: bookings.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppTheme.cardBackground,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.event_busy,
                        size: 40, color: AppTheme.textGray),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No bookings yet',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Start booking your dream stay!',
                    style: TextStyle(color: AppTheme.textGray, fontSize: 14),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final booking = bookings[index];
                return _BookingCard(booking: booking);
              },
            ),
    );
  }
}

class _BookingCard extends StatelessWidget {
  final Booking booking;

  const _BookingCard({required this.booking});

  @override
  Widget build(BuildContext context) {
    final dateStr =
        '${_getMonthShort(booking.checkInDate.month)} ${booking.checkInDate.day} - ${_getMonthShort(booking.checkOutDate.month)} ${booking.checkOutDate.day}';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              booking.imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 80,
                height: 80,
                color: Colors.grey[800],
                child: const Icon(Icons.hotel, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(booking.roomName,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.calendar_today,
                        size: 14, color: AppTheme.textGray),
                    const SizedBox(width: 4),
                    Text(dateStr,
                        style: const TextStyle(
                            fontSize: 13, color: AppTheme.textGray)),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.people,
                        size: 14, color: AppTheme.textGray),
                    const SizedBox(width: 4),
                    Text('${booking.guests} guests',
                        style: const TextStyle(
                            fontSize: 13, color: AppTheme.textGray)),
                    const SizedBox(width: 12),
                    const Icon(Icons.nights_stay,
                        size: 14, color: AppTheme.textGray),
                    const SizedBox(width: 4),
                    Text('${booking.nights} nights',
                        style: const TextStyle(
                            fontSize: 13, color: AppTheme.textGray)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: booking.status == 'Confirmed'
                            ? AppTheme.emeraldGreen.withOpacity(0.2)
                            : Colors.grey[800],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(booking.status,
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: booking.status == 'Confirmed'
                                  ? AppTheme.emeraldGreen
                                  : Colors.grey)),
                    ),
                    const Spacer(),
                    Text('\$${booking.totalPrice}',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.goldAccent)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getMonthShort(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }
}