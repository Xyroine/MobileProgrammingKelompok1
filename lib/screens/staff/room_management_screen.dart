import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class RoomManagementScreen extends StatefulWidget {
  const RoomManagementScreen({super.key});

  @override
  State<RoomManagementScreen> createState() => _RoomManagementScreenState();
}

class _RoomManagementScreenState extends State<RoomManagementScreen> {
  int selectedFilter = 0;
  int _selectedIndex = 1; // Kamar dipilih secara default

  final filters = ['All', 'Available', 'Occupied', 'Maintenance'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: AppBar(
        backgroundColor: AppTheme.darkBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Room Management',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Add'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.goldAccent,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            /// FILTER CHIPS
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(filters.length, (index) {
                  final isActive = selectedFilter == index;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(filters[index]),
                      selected: isActive,
                      onSelected: (_) => setState(() => selectedFilter = index),
                      selectedColor: AppTheme.goldAccent,
                      backgroundColor: AppTheme.cardBackground,
                      showCheckmark: false,
                      labelStyle: TextStyle(
                        color: isActive ? Colors.black : AppTheme.textGray,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 20),

            /// STATUS SUMMARY
            Row(
              children: const [
                _StatusBox(count: '2', label: 'Occupied', color: AppTheme.emeraldGreen),
                SizedBox(width: 12),
                _StatusBox(count: '2', label: 'Available', color: AppTheme.goldAccent),
                SizedBox(width: 12),
                _StatusBox(count: '1', label: 'Maintenance', color: Colors.redAccent),
              ],
            ),

            const SizedBox(height: 24),

            /// ROOM LIST
            const _RoomCard(
              title: 'Royal Suite',
              guest: 'John Smith',
              status: 'Occupied',
              statusColor: AppTheme.emeraldGreen,
              price: '\$850/night',
              imageUrl: 'https://images.unsplash.com/photo-1590490360182-c33d57733427?q=80&w=200', // Ganti dengan path lokal jika sudah ada
            ),
            const SizedBox(height: 16),
            const _RoomCard(
              title: 'Deluxe Room 201',
              guest: 'No current guest',
              status: 'Available',
              statusColor: AppTheme.goldAccent,
              price: '\$450/night',
              imageUrl: 'https://images.unsplash.com/photo-1566665797739-1674de7a421a?q=80&w=200',
            ),
            const SizedBox(height: 16),
            const _RoomCard(
              title: 'Executive Suite',
              guest: 'Maria Garcia',
              status: 'Occupied',
              statusColor: AppTheme.emeraldGreen,
              price: '\$650/night',
              imageUrl: 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?q=80&w=200',
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      
      /// BOTTOM NAVIGATION BAR
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppTheme.darkBackground,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppTheme.goldAccent,
        unselectedItemColor: AppTheme.textGray,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.bed_rounded), label: 'Rooms'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment_rounded), label: 'Bookings'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

/// WIDGET KOTAK STATUS (ATAS)
class _StatusBox extends StatelessWidget {
  final String count;
  final String label;
  final Color color;

  const _StatusBox({required this.count, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.borderColor),
        ),
        child: Column(
          children: [
            Text(count, style: TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(color: AppTheme.textGray, fontSize: 11)),
          ],
        ),
      ),
    );
  }
}

/// WIDGET KARTU KAMAR
class _RoomCard extends StatelessWidget {
  final String title;
  final String guest;
  final String status;
  final Color statusColor;
  final String price;
  final String imageUrl;

  const _RoomCard({
    required this.title,
    required this.guest,
    required this.status,
    required this.statusColor,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
            child: Image.network(
              imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(width: 100, height: 100, color: Colors.grey),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                      const Icon(Icons.more_vert, color: AppTheme.textGray, size: 18),
                    ],
                  ),
                  Text(guest, style: const TextStyle(color: AppTheme.textGray, fontSize: 12)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(status, style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                      Text(price, style: const TextStyle(color: AppTheme.goldAccent, fontWeight: FontWeight.bold, fontSize: 14)),
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