import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class CustomerSearchScreen extends StatefulWidget {
  const CustomerSearchScreen({super.key});

  @override
  State<CustomerSearchScreen> createState() => _CustomerSearchScreenState();
}

class _CustomerSearchScreenState extends State<CustomerSearchScreen> {
  // --- DUMMY DATA ---
  final List<Map<String, dynamic>> _allRooms = [
    {
      "name": "Royal Suite",
      "price": 850,
      "rating": 4.9,
      "image": "https://images.unsplash.com/photo-1631049307264-da0ec9d70304?q=80&w=2070&auto=format&fit=crop",
    },
    {
      "name": "Deluxe Room",
      "price": 450,
      "rating": 4.8,
      "image": "https://images.unsplash.com/photo-1611892440504-42a792e24d32?q=80&w=2070&auto=format&fit=crop",
    },
    {
      "name": "Presidential",
      "price": 1200,
      "rating": 5.0,
      "image": "https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?q=80&w=2070&auto=format&fit=crop",
    },
    {
      "name": "Ocean View",
      "price": 600,
      "rating": 4.7,
      "image": "https://images.unsplash.com/photo-1566073771259-6a8506099945?q=80&w=2070&auto=format&fit=crop",
    },
    {
      "name": "Luxury Garden",
      "price": 550,
      "rating": 4.6,
      "image": "https://images.unsplash.com/photo-1590490360182-c33d57733427?q=80&w=1974&auto=format&fit=crop",
    },
  ];

  List<Map<String, dynamic>> _foundRooms = [];

  @override
  void initState() {
    _foundRooms = _allRooms;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allRooms;
    } else {
      results = _allRooms
          .where((room) =>
              room["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundRooms = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Text("Find your room",
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontFamily: 'Serif',
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),

            // --- INPUT PENCARIAN ---
            Container(
              decoration: BoxDecoration(
                color: AppTheme.cardBackground,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.borderColor),
              ),
              child: TextField(
                onChanged: (value) => _runFilter(value),
                autofocus: false,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Search rooms...',
                  hintStyle: TextStyle(color: AppTheme.textDarkGray),
                  prefixIcon: Icon(Icons.search, color: AppTheme.textGray),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // --- GRID HASIL PENCARIAN (2 KOLOM) ---
            Expanded(
              child: _foundRooms.isNotEmpty
                  ? GridView.builder(
                      itemCount: _foundRooms.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) {
                        final room = _foundRooms[index];
                        return GestureDetector(
                          onTap: () {
                            // Show info snackbar
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please use Book feature to select dates and view room details'),
                                backgroundColor: AppTheme.goldAccent,
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppTheme.cardBackground,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: AppTheme.borderColor),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // GAMBAR KAMAR
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20)),
                                      image: DecorationImage(
                                        image: NetworkImage(room['image']),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        margin: const EdgeInsets.all(12),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.6),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(Icons.star,
                                                color: AppTheme.goldAccent,
                                                size: 12),
                                            const SizedBox(width: 4),
                                            Text(
                                              room['rating'].toString(),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                
                                // INFO KAMAR
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        room['name'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Serif',
                                            color: Colors.white),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Text(
                                            '\$${room['price']}',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: AppTheme.goldAccent),
                                          ),
                                          const Text(
                                            ' /night',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: AppTheme.textGray),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text(
                        'No rooms found',
                        style: TextStyle(color: AppTheme.textGray),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}