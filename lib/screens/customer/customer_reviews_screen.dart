import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class CustomerReviewsScreen extends StatelessWidget {
  const CustomerReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // --- DUMMY DATA REVIEWS (DENGAN GAMBAR KAMAR) ---
    final List<Map<String, dynamic>> reviews = [
      {
        'name': 'Sarah Johnson',
        'date': '2 days ago',
        'rating': 5.0,
        'comment': 'Absolutely stunning hotel! The service was impeccable and the room view was breathtaking. Will definitely come back.',
        'avatar': 'S',
        'color': const Color(0xFFE91E63),
        // Data Kamar
        'roomName': 'Royal Suite',
        'roomImage': 'https://images.unsplash.com/photo-1631049307264-da0ec9d70304?q=80&w=800&auto=format&fit=crop',
      },
      {
        'name': 'Michael Chen',
        'date': '1 week ago',
        'rating': 4.5,
        'comment': 'Great facilities, especially the gym and pool. The breakfast buffet had a huge variety of options.',
        'avatar': 'M',
        'color': const Color(0xFF2196F3),
        // Data Kamar
        'roomName': 'Deluxe Room',
        'roomImage': 'https://images.unsplash.com/photo-1611892440504-42a792e24d32?q=80&w=800&auto=format&fit=crop',
      },
      {
        'name': 'Jessica Davis',
        'date': '2 weeks ago',
        'rating': 5.0,
        'comment': 'The spa experience was the highlight of my stay. Very relaxing atmosphere and professional therapists.',
        'avatar': 'J',
        'color': const Color(0xFFFF9800),
        // Data Kamar
        'roomName': 'Ocean View',
        'roomImage': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?q=80&w=800&auto=format&fit=crop',
      },
      {
        'name': 'David Wilson',
        'date': '3 weeks ago',
        'rating': 4.0,
        'comment': 'Nice room but the check-in process was a bit slow. Otherwise, everything was perfect.',
        'avatar': 'D',
        'color': const Color(0xFF4CAF50),
        // Data Kamar
        'roomName': 'Standard City View',
        'roomImage': 'https://images.unsplash.com/photo-1590490360182-c33d57733427?q=80&w=800&auto=format&fit=crop',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Guest Reviews',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      // Langsung ListView, Header Summary dihapus
      body: ListView.separated(
        padding: const EdgeInsets.all(24),
        itemCount: reviews.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final review = reviews[index];
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.cardBackground,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.borderColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. USER INFO ROW
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: review['color'],
                      radius: 20,
                      child: Text(
                        review['avatar'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review['name'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            review['date'],
                            style: const TextStyle(
                              color: AppTheme.textGray,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Rating Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.star,
                              color: AppTheme.goldAccent, size: 14),
                          const SizedBox(width: 4),
                          Text(
                            review['rating'].toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // 2. ROOM INFO (GAMBAR KAMAR YG DI-REVIEW)
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: Row(
                    children: [
                      // Gambar Kamar Kecil
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          review['roomImage'],
                          width: 60,
                          height: 45,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(width: 60, height: 45, color: Colors.grey),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Nama Kamar & Label
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Stayed in",
                            style: TextStyle(
                              color: AppTheme.textGray,
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            review['roomName'],
                            style: const TextStyle(
                              color: AppTheme.goldAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // 3. COMMENT
                Text(
                  review['comment'],
                  style: const TextStyle(
                    color: Colors.white70,
                    height: 1.5,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}