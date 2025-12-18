import 'package:flutter/material.dart';

class CustomerProfileScreen extends StatelessWidget {
  const CustomerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Agar menyatu dengan background induk
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false, // Hilangkan tombol back
        title: const Text(
          'Profile',
          style: TextStyle(
            fontFamily: 'Serif',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        // [UPDATE] Bagian actions (icon settings) sudah dihapus
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            // Header Profile Card
            _buildProfileHeader(),
            const SizedBox(height: 25),
            // Stats Row
            _buildStatsRow(),
            const SizedBox(height: 25),
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
            const SizedBox(height: 100), // Spasi bawah agar tidak tertutup navbar utama
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
              'A', // Inisial Alexander
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
                      style: TextStyle(
                          color: Colors.amber[200], fontSize: 12)),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatItem('0', 'Bookings'),
        _buildStatItem('0', 'Reviews'),
        _buildStatItem('0', 'Saved'),
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
                        fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
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
}