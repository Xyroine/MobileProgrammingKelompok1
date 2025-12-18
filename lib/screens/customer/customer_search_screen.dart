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
      "location": "Jakarta, Indonesia",
      "image": "https://images.unsplash.com/photo-1631049307264-da0ec9d70304?q=80&w=2070&auto=format&fit=crop",
    },
    {
      "name": "Deluxe Room",
      "price": 450,
      "rating": 4.8,
      "location": "Bali, Indonesia",
      "image": "https://images.unsplash.com/photo-1611892440504-42a792e24d32?q=80&w=2070&auto=format&fit=crop",
    },
    {
      "name": "Presidential Suite",
      "price": 1200,
      "rating": 5.0,
      "location": "Bandung, Indonesia",
      "image": "https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?q=80&w=2070&auto=format&fit=crop",
    },
    {
      "name": "Ocean View",
      "price": 600,
      "rating": 4.7,
      "location": "Lombok, Indonesia",
      "image": "https://images.unsplash.com/photo-1566073771259-6a8506099945?q=80&w=2070&auto=format&fit=crop",
    },
     {
      "name": "Luxury Garden",
      "price": 550,
      "rating": 4.6,
      "location": "Medan, Indonesia",
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
    // KITA HAPUS SCAFFOLD DI SINI AGAR MENGIKUTI PARENT
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header sederhana pengganti AppBar
            const Text("Find your room", 
                style: TextStyle(fontSize: 24, color: Colors.white, fontFamily: 'Serif', fontWeight: FontWeight.bold)),
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
                autofocus: false, // Diubah ke false agar keyboard tidak kaget muncul saat tab pindah
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

            // --- LIST HASIL ---
            Expanded(
              child: _foundRooms.isNotEmpty
                  ? ListView.builder(
                      itemCount: _foundRooms.length,
                      itemBuilder: (context, index) => Card(
                        color: AppTheme.cardBackground,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),
                          leading: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: NetworkImage(_foundRooms[index]['image']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Text(_foundRooms[index]['name'], 
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Serif')),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text(_foundRooms[index]['location'], style: const TextStyle(color: AppTheme.textGray, fontSize: 12)),
                              const SizedBox(height: 4),
                              Text('\$${_foundRooms[index]['price']} /night', 
                                  style: const TextStyle(color: AppTheme.goldAccent, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
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