import 'package:flutter/material.dart';
import '../../models/booking_model.dart';
import '../../models/saved_room_service.dart';
import 'customer_booking_history_screen.dart';

class CustomerProfileScreen extends StatefulWidget {
  const CustomerProfileScreen({super.key});

  @override
  State<CustomerProfileScreen> createState() => _CustomerProfileScreenState();
}

class _CustomerProfileScreenState extends State<CustomerProfileScreen> {
  final SavedRoomService _savedService = SavedRoomService();

  @override
  void initState() {
    super.initState();
    // Listen untuk perubahan saved rooms
    _savedService.addListener(_onSavedRoomsChanged);
  }

  @override
  void dispose() {
    // Remove listener saat widget di-dispose
    _savedService.removeListener(_onSavedRoomsChanged);
    super.dispose();
  }

  void _onSavedRoomsChanged() {
    // Update UI saat saved rooms berubah
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final bookings = BookingService.getAllBookings();
    final totalBookings = bookings.length;
    final totalSaved = _savedService.getTotalSavedRooms();

    // Ambil hanya 2 booking teratas
    final recentBookings = bookings.take(2).toList();

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontFamily: 'Serif',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            // Header Profile Card
            _buildProfileHeader(),
            const SizedBox(height: 25),
            // Stats Row (Updated dengan data real)
            _buildStatsRow(totalBookings, totalSaved),
            const SizedBox(height: 25),

            // --- BOOKING HISTORY SECTION (Max 2) ---
            if (totalBookings > 0) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('My Bookings',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Serif',
                          color: Colors.white)),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CustomerBookingHistoryScreen(),
                        ),
                      );
                    },
                    child: const Text('View All',
                        style: TextStyle(color: Color(0xFFD4AF37))),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ...recentBookings.map((booking) => _buildBookingCard(booking)),
              const SizedBox(height: 25),
            ],

            // Menu Items
            _buildMenuItem(Icons.credit_card_outlined, 'Payment Methods',
                'Manage your cards'),
            _buildMenuItem(Icons.notifications_none_outlined, 'Notifications',
                'Customize alerts'),
            _buildMenuItem(Icons.shield_outlined, 'Privacy & Security',
                'Protect your account'),
            _buildMenuItem(
                Icons.help_outline, 'Help & Support', 'Get assistance'),
            const SizedBox(height: 30),
            // Sign Out Button
            _buildSignOutButton(),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 35,
            backgroundColor: Color(0xFF2D4F3E),
            child: Text(
              'A',
              style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Alexander',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Serif',
                    color: Colors.white),
              ),
              const Text('Gold Member', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 6,
                        width: 80,
                        decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      Container(
                        height: 6,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Colors.amber[700],
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Text('750 points',
                      style:
                          TextStyle(color: Colors.amber[200], fontSize: 12)),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildStatsRow(int totalBookings, int totalSaved) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatItem(totalBookings.toString(), 'Bookings'),
        _buildStatItem('0', 'Reviews'),
        _buildStatItem(totalSaved.toString(), 'Saved'),
      ],
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Container(
      width: 105,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text(value,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFD4AF37))),
          const SizedBox(height: 5),
          Text(label,
              style: const TextStyle(color: Colors.grey, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildBookingCard(Booking booking) {
    final dateStr =
        '${_getMonthShort(booking.checkInDate.month)} ${booking.checkInDate.day} - ${_getMonthShort(booking.checkOutDate.month)} ${booking.checkOutDate.day}';

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFF2A2A2A)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              booking.imageUrl,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 70,
                height: 70,
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
                const SizedBox(height: 4),
                Text(dateStr,
                    style: const TextStyle(fontSize: 13, color: Colors.grey)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: booking.status == 'Confirmed'
                            ? const Color(0xFF2D4F3E)
                            : Colors.grey[800],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(booking.status,
                          style: TextStyle(
                              fontSize: 11,
                              color: booking.status == 'Confirmed'
                                  ? const Color(0xFF5FB583)
                                  : Colors.grey)),
                    ),
                    const SizedBox(width: 8),
                    Text('\$${booking.totalPrice}',
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFD4AF37))),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: Colors.amber[200], size: 24),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white)),
                Text(subtitle,
                    style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
        ],
      ),
    );
  }

  Widget _buildSignOutButton() {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 55),
        side: const BorderSide(color: Color(0xFF421515)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.logout, color: Colors.redAccent, size: 20),
          SizedBox(width: 10),
          Text('Sign Out',
              style: TextStyle(color: Colors.redAccent, fontSize: 16)),
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