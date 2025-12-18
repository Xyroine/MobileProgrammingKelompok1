import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'analytics_screen.dart';
import 'settings_screen.dart';
import 'room_screen.dart';
import 'booking_screen.dart';
import 'profile_screen.dart';

class StaffMainScreen extends StatefulWidget {
  final int initialIndex;
  
  const StaffMainScreen({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<StaffMainScreen> createState() => _StaffMainScreenState();
}

class _StaffMainScreenState extends State<StaffMainScreen> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  // Callback untuk navigasi dari Quick Actions di Dashboard
  void _navigateFromDashboard(int targetIndex) {
    setState(() => _selectedIndex = targetIndex);
  }

  void _onNavigationTap(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          StaffDashboardContent(onNavigate: _navigateFromDashboard),
          const RoomManagementScreen(),
          const BookingScreen(),
          const ProfileContent(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavigationTap,
        backgroundColor: AppTheme.cardBackground,
        selectedItemColor: AppTheme.goldAccent,
        unselectedItemColor: AppTheme.textGray,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.meeting_room),
            label: 'Rooms',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_online),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// ============ DASHBOARD CONTENT ============
class StaffDashboardContent extends StatelessWidget {
  final Function(int) onNavigate;
  
  const StaffDashboardContent({
    super.key,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back',
                      style: TextStyle(fontSize: 14, color: AppTheme.textGray),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Admin Panel',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications_outlined, color: Colors.white, size: 24),
                      style: IconButton.styleFrom(
                        backgroundColor: AppTheme.cardBackground,
                      ),
                    ),
                    Positioned(
                      right: 12,
                      top: 12,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppTheme.goldAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Friday, December 13, 2024',
              style: TextStyle(fontSize: 12, color: AppTheme.textGray),
            ),
            const SizedBox(height: 24),
            
            // Stats Grid
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    icon: Icons.calendar_today,
                    value: '24',
                    label: 'Today\'s Bookings',
                    percentage: '+12%',
                    isPositive: true,
                    color: AppTheme.goldAccent,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _StatCard(
                    icon: Icons.hotel,
                    value: '85%',
                    label: 'Rooms Occupied',
                    percentage: '+5%',
                    isPositive: true,
                    color: AppTheme.emeraldGreen,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    icon: Icons.people,
                    value: '18',
                    label: 'Check-ins Today',
                    percentage: '+8%',
                    isPositive: true,
                    color: AppTheme.goldAccent,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _StatCard(
                    icon: Icons.attach_money,
                    value: '\$12,450',
                    label: 'Revenue Today',
                    percentage: '+15%',
                    isPositive: true,
                    color: AppTheme.emeraldLight,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            
            // Quick Actions
            const Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _QuickActionCard(
                    icon: Icons.analytics,
                    label: 'Analytics',
                    onTap: () {
                      // Analytics: buka sebagai halaman baru (tidak sinkron navbar)
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AnalyticsScreen()),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _QuickActionCard(
                    icon: Icons.meeting_room,
                    label: 'Rooms',
                    onTap: () {
                      // Room: sinkronkan navbar ke index 1
                      onNavigate(1);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _QuickActionCard(
                    icon: Icons.book_online,
                    label: 'Bookings',
                    onTap: () {
                      // Booking: sinkronkan navbar ke index 2
                      onNavigate(2);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _QuickActionCard(
                    icon: Icons.settings,
                    label: 'Settings',
                    onTap: () {
                      // Settings: buka sebagai halaman baru (tidak sinkron navbar)
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SettingsScreen()),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            
            // Recent Bookings
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Bookings',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // View All: pindah ke Booking tab
                    onNavigate(2);
                  },
                  child: const Text(
                    'View All',
                    style: TextStyle(color: AppTheme.goldAccent),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _BookingCard(
              initials: 'JS',
              name: 'John Smith',
              roomType: 'Royal Suite',
              time: 'Today',
              status: 'Confirmed',
              statusColor: AppTheme.emeraldLight,
            ),
            const SizedBox(height: 12),
            _BookingCard(
              initials: 'MG',
              name: 'Maria Garcia',
              roomType: 'Deluxe Room',
              time: 'Today',
              status: 'Pending',
              statusColor: AppTheme.goldAccent,
            ),
          ],
        ),
      ),
    );
  }
}

// ============ ROOM MANAGEMENT CONTENT ============
class RoomManagementContent extends StatelessWidget {
  const RoomManagementContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header (tanpa back button karena sudah ada navbar)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Room\nManagement',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Add'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.emeraldGreen,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Filter Tabs
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _FilterChip(label: 'All', isSelected: true, onTap: () {}),
                  const SizedBox(width: 12),
                  _FilterChip(label: 'Available', isSelected: false, onTap: () {}),
                  const SizedBox(width: 12),
                  _FilterChip(label: 'Occupied', isSelected: false, onTap: () {}),
                  const SizedBox(width: 12),
                  _FilterChip(label: 'Maintenance', isSelected: false, onTap: () {}),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Stats
            Row(
              children: [
                Expanded(
                  child: _RoomStatCard(
                    number: '2',
                    label: 'Occupied',
                    color: AppTheme.emeraldGreen,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _RoomStatCard(
                    number: '2',
                    label: 'Available',
                    color: AppTheme.emeraldLight,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _RoomStatCard(
                    number: '1',
                    label: 'Maintenance',
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Room Cards
            _RoomManagementCard(
              imageUrl: 'assets/images/royal_suite.jpg',
              roomName: 'Royal Suite',
              guestName: 'John Smith',
              status: 'Occupied',
              statusColor: AppTheme.emeraldGreen,
              price: '\$850/night',
            ),
            const SizedBox(height: 16),
            _RoomManagementCard(
              imageUrl: 'assets/images/deluxe_room.jpg',
              roomName: 'Deluxe Room\n201',
              guestName: 'No current guest',
              status: 'Available',
              statusColor: AppTheme.emeraldLight,
              price: '\$450/night',
            ),
          ],
        ),
      ),
    );
  }
}

// ============ BOOKING CONTENT ============
class BookingContent extends StatelessWidget {
  const BookingContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Booking\nManagement',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            const Center(
              child: Text(
                'Booking screen content here',
                style: TextStyle(color: AppTheme.textGray),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============ PROFILE CONTENT ============
class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Staff Profile',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            const Center(
              child: Text(
                'Profile screen content here',
                style: TextStyle(color: AppTheme.textGray),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============ WIDGET COMPONENTS ============
class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final String percentage;
  final bool isPositive;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.percentage,
    required this.isPositive,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Row(
                children: [
                  Icon(
                    isPositive ? Icons.trending_up : Icons.trending_down,
                    size: 14,
                    color: AppTheme.emeraldLight,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    percentage,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.emeraldLight,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.textGray,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.borderColor),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.darkBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppTheme.goldAccent, size: 20),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BookingCard extends StatelessWidget {
  final String initials;
  final String name;
  final String roomType;
  final String time;
  final String status;
  final Color statusColor;

  const _BookingCard({
    required this.initials,
    required this.name,
    required this.roomType,
    required this.time,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppTheme.emeraldGreen,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                initials,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$roomType • $time',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textGray,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: statusColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.emeraldGreen : AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppTheme.emeraldGreen : AppTheme.borderColor,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : AppTheme.textGray,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class _RoomStatCard extends StatelessWidget {
  final String number;
  final String label;
  final Color color;

  const _RoomStatCard({
    required this.number,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        children: [
          Text(
            number,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.textGray,
            ),
          ),
        ],
      ),
    );
  }
}

class _RoomManagementCard extends StatelessWidget {
  final String imageUrl;
  final String roomName;
  final String guestName;
  final String status;
  final Color statusColor;
  final String price;

  const _RoomManagementCard({
    required this.imageUrl,
    required this.roomName,
    required this.guestName,
    required this.status,
    required this.statusColor,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 140,
            height: 180,
            decoration: BoxDecoration(
              color: AppTheme.emeraldGreen,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          roomName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_vert, color: Colors.white),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    guestName,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppTheme.textGray,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          status,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: statusColor,
                          ),
                        ),
                      ),
                      Text(
                        price,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}