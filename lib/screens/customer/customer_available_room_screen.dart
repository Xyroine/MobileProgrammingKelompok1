import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'customer_room_detail_screen.dart'; 

class CustomerAvailableRoomsScreen extends StatelessWidget {
  const CustomerAvailableRoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      body: SafeArea(
        child: Column(
          children: [
            // --- HEADER ---
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    style: IconButton.styleFrom(
                        backgroundColor: AppTheme.cardBackground),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Available Rooms',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Serif', 
                                color: Colors.white)),
                        Text('Dec 16 - Dec 18 · 3 guests',
                            style: TextStyle(
                                fontSize: 14, color: AppTheme.textGray)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // --- FILTER CHIPS ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _FilterChip(
                        label: 'Filters', icon: Icons.tune, onTap: () {}),
                    const SizedBox(width: 8),
                    _FilterChip(
                        label: 'All', isSelected: true, onTap: () {}),
                    const SizedBox(width: 8),
                    _FilterChip(label: '\$300-\$500', onTap: () {}),
                    const SizedBox(width: 8),
                    _FilterChip(label: '\$500-\$800', onTap: () {}),
                    const SizedBox(width: 8),
                    _FilterChip(label: '\$800+', onTap: () {}),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // --- RESULT COUNT ---
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('4 rooms available for 2 nights',
                    style: TextStyle(fontSize: 14, color: AppTheme.textGray)),
              ),
            ),
            const SizedBox(height: 16),

            // --- ROOM LIST ---
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: const [
                  // --- PERUBAHAN DI SINI (Executive Suite -> Deluxe Room) ---
                  _AvailableRoomCard(
                    name: 'Deluxe Room', // Nama diubah
                    beds: 2,
                    sqm: 65,
                    guests: 3,
                    price: 450, // Harga diubah jadi 450
                    rating: 4.8,
                    imageUrl:
                        'https://images.unsplash.com/photo-1611892440504-42a792e24d32?q=80&w=2070&auto=format&fit=crop',
                  ),
                  SizedBox(height: 16),
                  _AvailableRoomCard(
                    name: 'Royal Suite',
                    beds: 2,
                    sqm: 85,
                    guests: 4,
                    price: 850,
                    rating: 4.9,
                    imageUrl:
                        'https://images.unsplash.com/photo-1631049307264-da0ec9d70304?q=80&w=2070&auto=format&fit=crop',
                  ),
                  SizedBox(height: 16),
                  _AvailableRoomCard(
                    name: 'Ocean View',
                    beds: 1,
                    sqm: 45,
                    guests: 2,
                    price: 450,
                    rating: 4.7,
                    imageUrl:
                        'https://images.unsplash.com/photo-1566073771259-6a8506099945?q=80&w=2070&auto=format&fit=crop',
                  ),
                  SizedBox(height: 24), 
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// WIDGETS
// ==========================================

class _FilterChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip(
      {required this.label,
      this.icon,
      this.isSelected = false,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.goldAccent : AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: isSelected ? AppTheme.goldAccent : AppTheme.borderColor),
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(icon,
                  size: 16, 
                  color: isSelected ? Colors.black : Colors.white), 
              const SizedBox(width: 6),
            ],
            Text(label,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.black : Colors.white)),
          ],
        ),
      ),
    );
  }
}

class _AvailableRoomCard extends StatelessWidget {
  final String name;
  final int beds;
  final int sqm;
  final int guests;
  final int price;
  final double rating;
  final String imageUrl; 

  const _AvailableRoomCard({
    required this.name,
    required this.beds,
    required this.sqm,
    required this.guests,
    required this.price,
    required this.rating,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- GAMBAR KAMAR ---
          Stack(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl), 
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Rating Badge
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      const Icon(Icons.star,
                          color: AppTheme.goldAccent, size: 14),
                      const SizedBox(width: 4),
                      Text(rating.toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              // Favorite Button
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      shape: BoxShape.circle),
                  child: const Icon(Icons.favorite_outline,
                      color: Colors.white, size: 20),
                ),
              ),
            ],
          ),

          // --- INFO KAMAR ---
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Serif', 
                        color: Colors.white)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.bed, color: AppTheme.textGray, size: 16),
                    const SizedBox(width: 4),
                    Text('$beds beds',
                        style:
                            const TextStyle(fontSize: 14, color: AppTheme.textGray)),
                    const SizedBox(width: 16),
                    const Icon(Icons.straighten,
                        color: AppTheme.textGray, size: 16),
                    const SizedBox(width: 4),
                    Text('$sqm m²',
                        style:
                            const TextStyle(fontSize: 14, color: AppTheme.textGray)),
                    const SizedBox(width: 16),
                    const Icon(Icons.people,
                        color: AppTheme.textGray, size: 16),
                    const SizedBox(width: 4),
                    Text('Up to $guests',
                        style:
                            const TextStyle(fontSize: 14, color: AppTheme.textGray)),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Price & Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('\$$price',
                                style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            const Text('/night',
                                style: TextStyle(
                                    fontSize: 14, color: AppTheme.textGray)),
                          ],
                        ),
                        Text('\$${price * 2} total',
                            style: const TextStyle(
                                fontSize: 12, color: AppTheme.textGray)),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const CustomerRoomDetailScreen()),
                          );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.goldAccent,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('View Details',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}