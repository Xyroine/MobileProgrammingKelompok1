import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

enum RoomStatus { occupied, available, maintenance }

class Room {
  final String id;
  final String name;
  final String? guestName;
  final RoomStatus status;
  final double pricePerNight;
  final String imageUrl;

  Room({
    required this.id,
    required this.name,
    this.guestName,
    required this.status,
    required this.pricePerNight,
    required this.imageUrl,
  });
}

class RoomManagementScreen extends StatefulWidget {
  const RoomManagementScreen({super.key});

  @override
  State<RoomManagementScreen> createState() => _RoomManagementScreenState();
}

class _RoomManagementScreenState extends State<RoomManagementScreen> {
  String _selectedFilter = 'All';

  // Sample data - nanti ganti dengan data dari API/Database
  final List<Room> _allRooms = [
    Room(
      id: '1',
      name: 'Royal Suite',
      guestName: 'John Smith',
      status: RoomStatus.occupied,
      pricePerNight: 850,
      imageUrl: 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?w=500',
    ),
    Room(
      id: '2',
      name: 'Deluxe Room 201',
      status: RoomStatus.available,
      pricePerNight: 450,
      imageUrl: 'https://images.unsplash.com/photo-1590490360182-c33d57733427?w=500',
    ),
    Room(
      id: '3',
      name: 'Executive Suite',
      guestName: 'Maria Garcia',
      status: RoomStatus.occupied,
      pricePerNight: 650,
      imageUrl: 'https://images.unsplash.com/photo-1591088398332-8a7791972843?w=500',
    ),
    Room(
      id: '4',
      name: 'Deluxe Room 202',
      status: RoomStatus.maintenance,
      pricePerNight: 450,
      imageUrl: 'https://images.unsplash.com/photo-1590490360182-c33d57733427?w=500',
    ),
    Room(
      id: '5',
      name: 'Presidential Suite',
      status: RoomStatus.available,
      pricePerNight: 1200,
      imageUrl: 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?w=500',
    ),
  ];

  List<Room> get _filteredRooms {
    if (_selectedFilter == 'All') return _allRooms;
    if (_selectedFilter == 'Available') {
      return _allRooms.where((r) => r.status == RoomStatus.available).toList();
    }
    if (_selectedFilter == 'Occupied') {
      return _allRooms.where((r) => r.status == RoomStatus.occupied).toList();
    }
    if (_selectedFilter == 'Maintenance') {
      return _allRooms.where((r) => r.status == RoomStatus.maintenance).toList();
    }
    return _allRooms;
  }

  int get _occupiedCount =>
      _allRooms.where((r) => r.status == RoomStatus.occupied).length;
  int get _availableCount =>
      _allRooms.where((r) => r.status == RoomStatus.available).length;
  int get _maintenanceCount =>
      _allRooms.where((r) => r.status == RoomStatus.maintenance).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  const Expanded(
                    child: Text(
                      'Room Management',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Navigate to add room screen
                    },
                    icon: const Icon(Icons.add, size: 20),
                    label: const Text('Add'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Filter Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildFilterChip('All', true),
                  const SizedBox(width: 12),
                  _buildFilterChip('Available', false),
                  const SizedBox(width: 12),
                  _buildFilterChip('Occupied', false),
                  const SizedBox(width: 12),
                  _buildFilterChip('Maintenance', false),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Status Summary Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: _buildStatusCard(
                      count: _occupiedCount,
                      label: 'Occupied',
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatusCard(
                      count: _availableCount,
                      label: 'Available',
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatusCard(
                      count: _maintenanceCount,
                      label: 'Maintenance',
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Room List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 80),
                itemCount: _filteredRooms.length,
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final room = _filteredRooms[index];
                  return _buildRoomCard(room);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isDefault) {
    final isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.yellow : AppTheme.textGray,
          ),
        ),
      ),
    );
  }

  Widget _buildStatusCard({
    required int count,
    required String label,
    required Color color,
  }) {
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
            count.toString(),
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

  Widget _buildRoomCard(Room room) {
    String statusText;

    switch (room.status) {
      case RoomStatus.occupied:
        statusText = 'Occupied';
        break;
      case RoomStatus.available:
        statusText = 'Available';
        break;
      case RoomStatus.maintenance:
        statusText = 'Maintenance';
        break;
    }

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Row(
        children: [
          // Room Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
            child: Container(
              width: 140,
              height: 140,
              color: AppTheme.borderColor,
              child: Image.network(
                room.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.hotel,
                      color: AppTheme.textGray,
                      size: 40,
                    ),
                  );
                },
              ),
            ),
          ),

          // Room Info
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
                          room.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // TODO: Show room options menu
                        },
                        icon: const Icon(
                          Icons.more_vert,
                          color: AppTheme.textGray,
                        ),
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    room.guestName ?? 'No current guest',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppTheme.textGray,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          statusText,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        '\$${room.pricePerNight.toStringAsFixed(0)}/night',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
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