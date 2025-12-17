import 'package:flutter/material.dart';

// Pastikan import ini sesuai dengan lokasi file Anda
// import '../../theme/app_theme.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0D0D0D),
      ),
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  // List halaman yang digabung
  final List<Widget> _screens = [
    const StaffDashboardContent(), // Halaman Utama
    const Center(child: Text("Rooms Screen")),
    const Center(child: Text("Bookings Screen")),
    const StaffSettingsScreen(), // Halaman Settings yang digabung
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        backgroundColor: const Color(0xFF1A1A1A),
        selectedItemColor: const Color(0xFFD4AF37), // Warna Gold
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.hotel_rounded), label: 'Rooms'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long_rounded), label: 'Bookings'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_rounded), label: 'Settings'),
        ],
      ),
    );
  }
}

// --- BAGIAN DASHBOARD CONTENT ---
class StaffDashboardContent extends StatelessWidget {
  const StaffDashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Analytics', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRevenueCard(),
            const SizedBox(height: 20),
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
            const Text('Room Performance', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _roomItem('Royal Suite', '45 bookings', '\$38,250', '+8%', true),
            _roomItem('Executive Suite', '62 bookings', '\$40,300', '+8%', true),
            _roomItem('Deluxe Room', '89 bookings', '\$40,050', '-3%', false),
          ],
        ),
      ),
    );
  }

  Widget _buildRevenueCard() {
    return Container(
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
            children: [
              const Text('Total Revenue', style: TextStyle(color: Colors.white70)),
              const Text('\$84,520', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('📈 +18.2% vs last month', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12)),
            ],
          ),
          const Icon(Icons.attach_money, color: Colors.white, size: 40),
        ],
      ),
    );
  }

  Widget _miniStatCard(IconData icon, String val, String label, String trend, bool pos) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFFD4AF37), size: 20),
            Text(val, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(label, style: const TextStyle(color: Colors.grey, fontSize: 10)),
            Text(trend, style: TextStyle(color: pos ? Colors.green : Colors.red, fontSize: 10)),
          ],
        ),
      ),
    );
  }

  Widget _roomItem(String name, String sub, String price, String trend, bool pos) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(sub, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ]),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(price, style: const TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
            Text(trend, style: TextStyle(color: pos ? Colors.green : Colors.red, fontSize: 12)),
          ]),
        ],
      ),
    );
  }
}

// --- BAGIAN SETTINGS CONTENT ---
class StaffSettingsScreen extends StatelessWidget {
  const StaffSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Settings"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _settingItem(Icons.person_outline, "Edit Profile"),
          _settingItem(Icons.notifications_none, "Notifications"),
          _settingItem(Icons.lock_outline, "Security"),
          _settingItem(Icons.help_outline, "Help Center"),
          const Divider(color: Colors.white10, height: 40),
          _settingItem(Icons.logout, "Logout", color: Colors.redAccent),
        ],
      ),
    );
  }

  Widget _settingItem(IconData icon, String title, {Color color = Colors.white}) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: TextStyle(color: color)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: () {},
    );
  }
}