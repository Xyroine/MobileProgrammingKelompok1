import 'package:flutter/material.dart';
import '../../theme/app_theme.dart'; // Gunakan import ini

class Booking {
  final String name;
  final String initials;
  final String roomType;
  final int guests;
  final String dateRange;
  final String price;
  final String status;

  Booking({
    required this.name,
    required this.initials,
    required this.roomType,
    required this.guests,
    required this.dateRange,
    required this.price,
    required this.status,
  });
}

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Booking> bookings = [
      Booking(name: 'Syaikhah Azzahra', initials: 'SA', roomType: 'Royal Suite', guests: 2, dateRange: 'Dec 13 → Dec 16', price: '\$2550', status: 'Confirmed'),
      Booking(name: 'Rahmah Zulaikha', initials: 'RZ', roomType: 'Deluxe Room', guests: 1, dateRange: 'Dec 13 → Dec 15', price: '\$900', status: 'Pending'),
    ];

    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context), 
        ),
        title: const Text(
          'Booking Management',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22, fontFamily: 'serif'),
        ),
      ),
      body: Column(
        children: [
          // Search Bar & Filter
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search guest...',
                      hintStyle: const TextStyle(color: AppTheme.textGray),
                      prefixIcon: const Icon(Icons.search, color: AppTheme.textGray),
                      filled: true,
                      fillColor: AppTheme.cardBackground, // UBAH: Gunakan AppTheme
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // List Booking
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: bookings.length,
              itemBuilder: (context, index) => _buildBookingCard(bookings[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingCard(Booking booking) {
    // Gunakan warna dari AppTheme untuk status
    Color statusColor = AppTheme.goldAccent; 
    if (booking.status == 'Confirmed') statusColor = AppTheme.emeraldLight;
    if (booking.status == 'Cancelled') statusColor = Colors.redAccent;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground, 
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppTheme.emeraldGreen.withOpacity(0.2),
                child: Text(booking.initials, style: const TextStyle(color: AppTheme.emeraldLight)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(booking.name, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(booking.roomType, style: const TextStyle(color: AppTheme.textGray)),
                  ],
                ),
              ),
              Text(booking.status, style: TextStyle(color: statusColor, fontWeight: FontWeight.bold)),
            ],
          ),
          const Divider(color: AppTheme.borderColor),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(booking.dateRange, style: const TextStyle(color: AppTheme.textGray)),
              Text(booking.price, style: const TextStyle(color: AppTheme.goldAccent, fontWeight: FontWeight.bold, fontSize: 18)),
            ],
          )
        ],
      ),
    );
  }
}