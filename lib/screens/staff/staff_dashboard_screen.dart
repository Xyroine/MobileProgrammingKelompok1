import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'analytics_screen.dart';
import 'settings_screen.dart';

class StaffDashboardScreen extends StatelessWidget {
  final Function(int) onNavigate;
  const StaffDashboardScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: AppBar(title: const Text('Dashboard'), backgroundColor: Colors.transparent),
      body: GridView.count(
        padding: const EdgeInsets.all(20),
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        children: [
          _buildMenuCard(context, 'Analytics', Icons.analytics, () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const AnalyticsScreen()));
          }),
          _buildMenuCard(context, 'Settings', Icons.settings, () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
          }),
          _buildMenuCard(context, 'Room Management', Icons.meeting_room, () => onNavigate(1)),
          _buildMenuCard(context, 'Bookings', Icons.book_online, () => onNavigate(2)),
        ],
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return InkWell( // Efek Hover & Ripple
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Ink(
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppTheme.borderColor),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppTheme.goldAccent, size: 40),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}