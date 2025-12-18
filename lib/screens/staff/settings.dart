import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Analytics',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// TOTAL REVENUE
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF1B4332),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Total Revenue',
                            style: TextStyle(color: Colors.white70)),
                        SizedBox(height: 8),
                        Text('\$84,520',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 12),
                        Text('📈 +18.2% vs last month',
                            style: TextStyle(color: Colors.white, fontSize: 12)),
                      ],
                    ),
                    const Icon(Icons.attach_money,
                        color: Colors.white, size: 32),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// MINI STATS
              Row(
                children: [
                  _miniStatCard(Icons.people_outline, '1,248', 'Guests', '+12%', true),
                  const SizedBox(width: 12),
                  _miniStatCard(Icons.bed_outlined, '87%', 'Occupancy', '+5%', true),
                  const SizedBox(width: 12),
                  _miniStatCard(Icons.star_outline, '4.9', 'Rating', '+0.2', true),
                ],
              ),

              const SizedBox(height: 30),

              /// WEEKLY CHART
              const Text('Weekly Occupancy',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Container(
                height: 180,
                decoration: BoxDecoration(
                  color: AppTheme.cardBackground,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.borderColor),
                ),
                child: const Center(
                  child: Text('Chart Placeholder',
                      style: TextStyle(color: AppTheme.textGray)),
                ),
              ),

              const SizedBox(height: 30),

              /// ROOM PERFORMANCE
              const Text('Room Performance',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              _roomPerformanceItem(
                  'Royal Suite', '45 bookings this month', '\$38,250', '+8%', true),
              _roomPerformanceItem(
                  'Executive Suite', '62 bookings this month', '\$40,300', '+8%', true),
              _roomPerformanceItem(
                  'Deluxe Room', '89 bookings this month', '\$40,050', '-3%', false),
            ],
          ),
        ),
      ),

      /// BOTTOM NAV
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        backgroundColor: AppTheme.cardBackground,
        selectedItemColor: AppTheme.goldAccent,
        unselectedItemColor: AppTheme.textGray,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_rounded), label: 'Dashboard'),
          BottomNavigationBarItem(
              icon: Icon(Icons.hotel_rounded), label: 'Rooms'),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_rounded), label: 'Bookings'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _miniStatCard(
      IconData icon, String value, String label, String trend, bool positive) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.borderColor),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppTheme.goldAccent),
            const SizedBox(height: 8),
            Text(value,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            Text(label,
                style: const TextStyle(color: AppTheme.textGray, fontSize: 12)),
            Text(trend,
                style: TextStyle(
                    color: positive ? Colors.green : Colors.red, fontSize: 10)),
          ],
        ),
      ),
    );
  }

  Widget _roomPerformanceItem(String title, String subtitle, String price,
      String trend, bool positive) {
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
            Text(title,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            Text(subtitle,
                style: const TextStyle(color: AppTheme.textGray, fontSize: 12)),
          ]),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(price,
                style: const TextStyle(
                    color: AppTheme.goldAccent,
                    fontWeight: FontWeight.bold)),
            Text(trend,
                style: TextStyle(
                    color: positive ? Colors.green : Colors.red)),
          ]),
        ],
      ),
    );
  }
}
