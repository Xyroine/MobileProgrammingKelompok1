import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'customer_room_detail_screen.dart';

class CustomerSavedRoomsScreen extends StatefulWidget {
  const CustomerSavedRoomsScreen({super.key});

  @override
  State<CustomerSavedRoomsScreen> createState() => _CustomerSavedRoomsScreenState();
}

class _CustomerSavedRoomsScreenState extends State<CustomerSavedRoomsScreen> {
  // --- DATA DUMMY ---
  final List<Map<String, dynamic>> _savedRooms = [
    {
      'id': '1',
      'name': 'Royal Suite',
      'price': '\$850',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1631049307264-da0ec9d70304?q=80&w=2070&auto=format&fit=crop',
    },
    {
      'id': '2',
      'name': 'Deluxe Room',
      'price': '\$450',
      'rating': '4.8',
      'imageUrl': 'https://images.unsplash.com/photo-1611892440504-42a792e24d32?q=80&w=2070&auto=format&fit=crop',
    },
    {
      'id': '3',
      'name': 'Presidential',
      'price': '\$1,200',
      'rating': '5.0',
      'imageUrl': 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?q=80&w=2070&auto=format&fit=crop',
    },
    {
      'id': '4',
      'name': 'Ocean View',
      'price': '\$600',
      'rating': '4.7',
      'imageUrl': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?q=80&w=2070&auto=format&fit=crop',
    },
    {
      'id': '5',
      'name': 'Luxury Garden',
      'price': '\$550',
      'rating': '4.6',
      'imageUrl': 'https://images.unsplash.com/photo-1590490360182-c33d57733427?q=80&w=1974&auto=format&fit=crop',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Background Hitam (Dark Mode)
      appBar: AppBar(
        automaticallyImplyLeading: false, // Hilangkan tombol back
        title: const Text(
          'Saved Rooms',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: _savedRooms.isEmpty
          // 1. TAMPILAN JIKA KOSONG (EMPTY STATE)
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
                    child: const Icon(Icons.favorite_border, size: 40, color: AppTheme.textGray),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No saved rooms yet',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Start exploring and save your favorite rooms!',
                    style: TextStyle(color: AppTheme.textGray, fontSize: 14),
                  ),
                ],
              ),
            )
          // 2. TAMPILAN LIST KAMAR (LIST VIEW)
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _savedRooms.length,
              itemBuilder: (context, index) {
                final room = _savedRooms[index];
                
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: AppTheme.cardBackground,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (_) => const CustomerRoomDetailScreen())
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
                            room['imageUrl'],
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
                                  child: CircularProgressIndicator(strokeWidth: 2, color: AppTheme.goldAccent),
                                ),
                              );
                            },
                            errorBuilder: (ctx, err, stack) => Container(
                              width: 110,
                              height: 110,
                              color: Colors.grey[800],
                              child: const Icon(Icons.broken_image, color: Colors.white54),
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
                                // Nama Kamar
                                Text(
                                  room['name'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                
                                const SizedBox(height: 12),

                                // Harga & Rating
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // BAGIAN HARGA + /night
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          room['price'],
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

                                    // RATING
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.star, color: Colors.amber, size: 12),
                                          const SizedBox(width: 4),
                                          Text(
                                            room['rating'],
                                            style: const TextStyle(color: Colors.white, fontSize: 11),
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

                        // TOMBOL HAPUS / LOVE
                        Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                _savedRooms.removeAt(index);
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: AppTheme.cardBackground,
                                  content: const Text("Room removed from saved", style: TextStyle(color: Colors.white)),
                                  duration: const Duration(milliseconds: 800),
                                ),
                              );
                            },
                            icon: const Icon(Icons.favorite, color: Colors.red),
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