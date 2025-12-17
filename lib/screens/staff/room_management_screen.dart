import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class RoomManagementScreen extends StatefulWidget {
  const RoomManagementScreen({super.key});

  @override
  State<RoomManagementScreen> createState() => _RoomManagementScreenState();
}

class _RoomManagementScreenState extends State<RoomManagementScreen> {
  int selectedFilter = 0;

  final filters = ['All', 'Available', 'Occupied', 'Maintenance'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: AppBar(
        backgroundColor: AppTheme.darkBackground,
        elevation: 0,
        title: const Text(
          'Room Management',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Add'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.goldAccent,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          )
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// FILTER BUTTON
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(filters.length, (index) {
                  final isActive = selectedFilter == index;
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ChoiceChip(
                      label: Text(filters[index]),
                      selected: isActive,
                      onSelected: (_) {
                        setState(() => selectedFilter = index);
                      },
                      selectedColor: AppTheme.goldAccent,
                      backgroundColor: AppTheme.cardBackground,
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
                _StatusBox(
                  count: '2',
                  label: 'Occupied',
                  color: AppTheme.emeraldGreen,
                ),
                SizedBox(width: 12),
                _StatusBox(
                  count: '2',
                  label: 'Available',
                  color: AppTheme.goldAccent,
                ),
                SizedBox(width: 12),
                _StatusBox(
                  count: '1',
                  label: 'Maintenance',
                  color: Colors.redAccent,
                ),
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
              image: 'assets/rooms/room1.jpg',
            ),

            const SizedBox(height: 16),

            const _RoomCard(
              title: 'Deluxe Room 201',
              guest: 'No current guest',
              status: 'Available',
              statusColor: AppTheme.goldAccent,
              price: '\$450/night',
              image: 'assets/rooms/room2.jpg',
            ),

            const SizedBox(height: 16),

            const _RoomCard(
              title: 'Executive Suite',
              guest: 'Maria Garcia',
              status: 'Occupied',
              statusColor: AppTheme.emeraldGreen,
              price: '\$650/night',
              image: 'assets/rooms/room3.jpg',
            ),

            const SizedBox(height: 16),

            const _RoomCard(
              title: 'Deluxe Room 202',
              guest: 'No current guest',
              status: 'Maintenance',
              statusColor: Colors.redAccent,
              price: '\$450/night',
              image: 'assets/rooms/room4.jpg',
            ),

            const SizedBox(height: 16),

            const _RoomCard(
              title: 'Presidential Suite',
              guest: 'No current guest',
              status: 'Available',
              statusColor: AppTheme.goldAccent,
              price: '\$1200/night',
              image: 'assets/rooms/room5.jpg',
            ),
          ],
        ),
      ),
    );
  }
}
class _RoomCard extends StatelessWidget {
  final String title;
  final String guest;
  final String status;
  final Color statusColor;
  final String price;
  final String image;

  const _RoomCard({
    required this.title,
    required this.guest,
    required this.status,
    required this.statusColor,
    required this.price,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Row(
        children: [
          /// IMAGE
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(18)),
            child: Image.asset(
              image,
              width: 90,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),

          /// CONTENT
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    guest,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.textGray,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// PRICE
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Text(
              price,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppTheme.goldAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
onTap: (index) {
  setState(() => _selectedIndex = index);

  if (index == 1) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const RoomManagementScreen(),
      ),
    );
  }
},
