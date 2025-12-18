import 'package:flutter/material.dart';
import '../../theme/app_theme.dart'; 

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground, 
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    style: IconButton.styleFrom(
                      backgroundColor: AppTheme.cardBackground,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Analytics',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'serif',
                    ),
                  ),
                ],
              ),
            ),
            
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRevenueCard(),
                    const SizedBox(height: 24),
                    
                    Row(
                      children: [
                        Expanded(child: _buildStatCard(Icons.people_outline, '1,248', 'Guests', '+12%', true)),
                        const SizedBox(width: 12),
                        Expanded(child: _buildStatCard(Icons.hotel_outlined, '87%', 'Occupancy', '+5%', true)),
                        const SizedBox(width: 12),
                        Expanded(child: _buildStatCard(Icons.star_outline, '4.9', 'Rating', '+0.2', true)),
                      ],
                    ),
                    
                    const SizedBox(height: 32),
                    const Text('Weekly Occupancy', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 16),
                    _buildWeeklyChart(),
                    
                    const SizedBox(height: 32),
                    const Text('Room Performance', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 16),
                    _buildRoomPerformanceCard('Royal Suite', '45 bookings', '\$38,250', '+8%', true),
                    _buildRoomPerformanceCard('Executive Suite', '62 bookings', '\$40,300', '+8%', true),
                    const SizedBox(height: 80), 
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Widget Builders ---

  Widget _buildRevenueCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.emeraldGreen,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Total Revenue', style: TextStyle(color: Colors.white70)),
          const Text('\$84,520', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 8),
          const Text('+18.2% vs last month', style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildStatCard(IconData icon, String value, String label, String percentage, bool isPositive) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppTheme.goldAccent, size: 28),
          const SizedBox(height: 12),
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
          Text(label, style: const TextStyle(fontSize: 10, color: AppTheme.textGray)),
          Text(percentage, style: TextStyle(fontSize: 12, color: isPositive ? AppTheme.emeraldLight : Colors.red, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildWeeklyChart() {
    return Container(
      height: 180,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(7, (index) => Container(
          width: 12,
          height: (index + 1) * 20.0,
          decoration: BoxDecoration(color: AppTheme.emeraldGreen, borderRadius: BorderRadius.circular(4)),
        )),
      ),
    );
  }

  Widget _buildRoomPerformanceCard(String name, String desc, String rev, String perc, bool pos) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            Text(desc, style: const TextStyle(color: AppTheme.textGray, fontSize: 12)),
          ]),
          Text(rev, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}