import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/saved_room_service.dart';

class CustomerSavedRoomsScreen extends StatefulWidget {
  const CustomerSavedRoomsScreen({super.key});

  @override
  State<CustomerSavedRoomsScreen> createState() =>
      _CustomerSavedRoomsScreenState();
}

class _CustomerSavedRoomsScreenState extends State<CustomerSavedRoomsScreen> {
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
    final savedRooms = _savedService.getAllSavedRooms();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Saved Rooms',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: savedRooms.isEmpty
          // 1. TAMPILAN JIKA KOSONG
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppTheme.cardBackground,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.favorite_border,
                        size: 40, color: AppTheme.textGray),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No saved rooms yet',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Start exploring and save your favorite rooms!',
                    style: TextStyle(color: AppTheme.textGray, fontSize: 14),
                  ),
                ],
              ),
            )
          // 2. TAMPILAN LIST KAMAR
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: savedRooms.length,
              itemBuilder: (context, index) {
                final room = savedRooms[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: AppTheme.cardBackground,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Please use Book feature to select dates and view room details'),
                          backgroundColor: AppTheme.goldAccent,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Row(
                      children: [
                        // GAMBAR
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            bottomLeft: Radius.circular(16),
                          ),
                          child: Image.network(
                            room.imageUrl,
                            width: 110,
                            height: 110,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                width: 110,
                                height: 110,
                                color: AppTheme.cardBackground,
                                child: const Center(
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: AppTheme.goldAccent),
                                ),
                              );
                            },
                            errorBuilder: (ctx, err, stack) => Container(
                              width: 110,
                              height: 110,
                              color: Colors.grey[800],
                              child: const Icon(Icons.broken_image,
                                  color: Colors.white54),
                            ),
                          ),
                        ),

                        // INFO TEKS
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  room.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          '\$${room.price}',
                                          style: const TextStyle(
                                            color: AppTheme.goldAccent,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                        const Text(
                                          ' /night',
                                          style: TextStyle(
                                            color: AppTheme.textGray,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.star,
                                              color: Colors.amber, size: 12),
                                          const SizedBox(width: 4),
                                          Text(
                                            room.rating.toString(),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 11),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        // TOMBOL HAPUS
                        Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: IconButton(
                            onPressed: () {
                              // Langsung hapus dari service
                              // Service akan notify semua listener (termasuk Profile)
                              _savedService.removeRoom(room.id);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: AppTheme.cardBackground,
                                  content: Text("Room removed from saved",
                                      style: TextStyle(color: Colors.white)),
                                  duration: Duration(milliseconds: 800),
                                ),
                              );
                            },
                            icon:
                                const Icon(Icons.favorite, color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}