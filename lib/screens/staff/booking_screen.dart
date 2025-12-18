import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'staff_main_screen.dart';

class Booking {
  final String name;
  final String initials;
  final String roomType;
  final int guests;
  final String dateRange;
  final String price;
  final String status;

  Booking({
    required this.name,
    required this.initials,
    required this.roomType,
    required this.guests,
    required this.dateRange,
    required this.price,
    required this.status,
  });
}

// 1. UBAH KE STATEFULWIDGET
class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  // 2. PINDAHKAN LIST DATA KE DALAM STATE
  final List<Booking> _allBookings = [
    Booking(name: 'John Smith', initials: 'JS', roomType: 'Royal Suite', guests: 2, dateRange: 'Dec 13 → Dec 16', price: '\$2550', status: 'Confirmed'),
    Booking(name: 'Maria Garcia', initials: 'MG', roomType: 'Deluxe Room', guests: 1, dateRange: 'Dec 13 → Dec 15', price: '\$1800', status: 'Pending'),
    Booking(name: 'Syaikhah Azzahra', initials: 'SA', roomType: 'Deluxe Room', guests: 3, dateRange: 'Dec 16 → Dec 17', price: '\$900', status: 'Pending'),
    Booking(name: 'Rahmah Zulaikha', initials: 'RZ', roomType: 'Royal Suite', guests: 4, dateRange: 'Dec 15 → Dec 16', price: '\$850', status: 'Confirmed'),
    Booking(name: 'Khalif Al Malik', initials: 'KA', roomType: 'Royal Suite', guests: 5, dateRange: 'Dec 15 → Dec 17', price: '\$1700', status: 'Pending'),
    Booking(name: 'M. Fikri Ramadhan', initials: 'MFR', roomType: 'Deluxe Room', guests: 6, dateRange: 'Dec 15 → Dec 16', price: '\$900', status: 'Confirmed'),
    Booking(name: 'Dimas Surya', initials: 'DS', roomType: 'Deluxe Room', guests: 7, dateRange: 'Dec 16 → Dec 17', price: '\$900', status: 'Pending'),
    Booking(name: 'Auzan Taris', initials: 'AT', roomType: 'Royal Suite', guests: 8, dateRange: 'Dec 14 → Dec 18', price: '\$3400', status: 'Confirmed'),
  ];

  // 3. VARIABEL UNTUK MENAMPUNG HASIL FILTER
  List<Booking> _foundBookings = [];

  @override
  void initState() {
    _foundBookings = _allBookings; // Menampilkan semua data di awal
    super.initState();
  }

  // 4. LOGIKA FILTER SEARCH
  void _runFilter(String enteredKeyword) {
    List<Booking> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allBookings;
    } else {
      results = _allBookings
          .where((booking) =>
              booking.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundBookings = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const StaffMainScreen()),
            );
          },
        ),
        title: const Text(
          'Booking Management',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22, fontFamily: 'serif'),
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) => _runFilter(value), // 5. PANGGIL FILTER DI SINI
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search guest...',
                hintStyle: const TextStyle(color: AppTheme.textGray),
                prefixIcon: const Icon(Icons.search, color: AppTheme.textGray),
                filled: true,
                fillColor: AppTheme.cardBackground,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
          ),

          // List Booking
          Expanded(
            child: _foundBookings.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _foundBookings.length, // 6. GUNAKAN LIST HASIL FILTER
                    itemBuilder: (context, index) => _buildBookingCard(_foundBookings[index]),
                  )
                : const Center(
                    child: Text('No guests found', style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingCard(Booking booking) {
    Color statusColor = AppTheme.goldAccent;
    if (booking.status == 'Confirmed') statusColor = AppTheme.emeraldLight;
    if (booking.status == 'Cancelled') statusColor = Colors.redAccent;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppTheme.emeraldGreen.withOpacity(0.2),
                child: Text(booking.initials, style: const TextStyle(color: AppTheme.emeraldLight)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(booking.name, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(booking.roomType, style: const TextStyle(color: AppTheme.textGray)),
                  ],
                ),
              ),
              Text(booking.status, style: TextStyle(color: statusColor, fontWeight: FontWeight.bold)),
            ],
          ),
          const Divider(color: AppTheme.borderColor, height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(booking.dateRange, style: const TextStyle(color: AppTheme.textGray)),
              Text(booking.price, style: const TextStyle(color: AppTheme.goldAccent, fontWeight: FontWeight.bold, fontSize: 18)),
            ],
          )
        ],
      ),
    );
  }
}