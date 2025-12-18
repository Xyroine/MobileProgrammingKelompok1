import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
// Import Service dari folder models
import '../../models/saved_room_service.dart'; 
import 'customer_room_detail_screen.dart';

class CustomerAvailableRoomsScreen extends StatefulWidget {
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int guests;

  const CustomerAvailableRoomsScreen({
    super.key,
    required this.checkInDate,
    required this.checkOutDate,
    required this.guests,
  });

  @override
  State<CustomerAvailableRoomsScreen> createState() =>
      _CustomerAvailableRoomsScreenState();
}

class _CustomerAvailableRoomsScreenState
    extends State<CustomerAvailableRoomsScreen> {
  final SavedRoomService _savedService = SavedRoomService();
  String _selectedPriceFilter = 'All'; // Default filter

  @override
  void initState() {
    super.initState();
    _savedService.addListener(_onSavedRoomsChanged);
  }

  @override
  void dispose() {
    _savedService.removeListener(_onSavedRoomsChanged);
    super.dispose();
  }

  void _onSavedRoomsChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  List<Map<String, dynamic>> _filterRoomsByPrice(List<Map<String, dynamic>> rooms) {
    if (_selectedPriceFilter == 'All') {
      return rooms;
    }

    switch (_selectedPriceFilter) {
      case '\$0-\$500':
        return rooms.where((room) => (room['price'] as int) <= 500).toList();
      case '\$500-\$800':
        return rooms.where((room) {
          final price = room['price'] as int;
          return price > 500 && price <= 800;
        }).toList();
      case '\$800-\$1200':
        return rooms.where((room) {
          final price = room['price'] as int;
          return price > 800 && price <= 1200;
        }).toList();
      case '\$1200+':
        return rooms.where((room) => (room['price'] as int) > 1200).toList();
      default:
        return rooms;
    }
  }

  @override
  Widget build(BuildContext context) {
    final nights = widget.checkOutDate.difference(widget.checkInDate).inDays;

    // Data room statis
    final allRooms = [
      {
        'id': 'deluxe_room',
        'name': 'Deluxe Room',
        'beds': 2,
        'sqm': 65,
        'maxGuests': 3,
        'price': 450,
        'rating': 4.8,
        'imageUrl':
            'https://images.unsplash.com/photo-1611892440504-42a792e24d32?q=80&w=2070&auto=format&fit=crop'
      },
      {
        'id': 'royal_suite',
        'name': 'Royal Suite',
        'beds': 2,
        'sqm': 85,
        'maxGuests': 4,
        'price': 850,
        'rating': 4.9,
        'imageUrl':
            'https://images.unsplash.com/photo-1631049307264-da0ec9d70304?q=80&w=2070&auto=format&fit=crop'
      },
      {
        'id': 'ocean_view',
        'name': 'Ocean View',
        'beds': 1,
        'sqm': 45,
        'maxGuests': 2,
        'price': 450,
        'rating': 4.7,
        'imageUrl':
            'https://images.unsplash.com/photo-1566073771259-6a8506099945?q=80&w=2070&auto=format&fit=crop'
      },
      {
        'id': 'presidential_suite',
        'name': 'Presidential Suite',
        'beds': 3,
        'sqm': 120,
        'maxGuests': 6,
        'price': 1200,
        'rating': 5.0,
        'imageUrl':
            'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?q=80&w=2070&auto=format&fit=crop'
      },
      {
        'id': 'family_room',
        'name': 'Family Room',
        'beds': 3,
        'sqm': 90,
        'maxGuests': 5,
        'price': 680,
        'rating': 4.6,
        'imageUrl':
            'https://images.unsplash.com/photo-1590490360182-c33d57733427?q=80&w=2070&auto=format&fit=crop'
      },
      {
        'id': 'grand_deluxe',
        'name': 'Grand Deluxe',
        'beds': 4,
        'sqm': 150,
        'maxGuests': 8,
        'price': 1500,
        'rating': 4.9,
        'imageUrl':
            'https://images.unsplash.com/photo-1618773928121-c32242e63f39?q=80&w=2070&auto=format&fit=crop'
      },
    ];

    // Filter logic
    final roomsByGuest = allRooms
        .where((room) => room['maxGuests'] as int >= widget.guests)
        .toList();

    final availableRooms = _filterRoomsByPrice(roomsByGuest);

    final dateStr =
        '${_getMonthShort(widget.checkInDate.month)} ${widget.checkInDate.day} - ${_getMonthShort(widget.checkOutDate.month)} ${widget.checkOutDate.day}';

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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Available Rooms',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Serif',
                                color: Colors.white)),
                        Text('$dateStr · ${widget.guests} guests',
                            style: const TextStyle(
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
                      label: 'All',
                      isSelected: _selectedPriceFilter == 'All',
                      onTap: () {
                        setState(() {
                          _selectedPriceFilter = 'All';
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    _FilterChip(
                      label: '\$0-\$500',
                      isSelected: _selectedPriceFilter == '\$0-\$500',
                      onTap: () {
                        setState(() {
                          _selectedPriceFilter = '\$0-\$500';
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    _FilterChip(
                      label: '\$500-\$800',
                      isSelected: _selectedPriceFilter == '\$500-\$800',
                      onTap: () {
                        setState(() {
                          _selectedPriceFilter = '\$500-\$800';
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    _FilterChip(
                      label: '\$800-\$1200',
                      isSelected: _selectedPriceFilter == '\$800-\$1200',
                      onTap: () {
                        setState(() {
                          _selectedPriceFilter = '\$800-\$1200';
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    _FilterChip(
                      label: '\$1200+',
                      isSelected: _selectedPriceFilter == '\$1200+',
                      onTap: () {
                        setState(() {
                          _selectedPriceFilter = '\$1200+';
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // --- RESULT COUNT ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    '${availableRooms.length} rooms available for $nights nights',
                    style:
                        const TextStyle(fontSize: 14, color: AppTheme.textGray)),
              ),
            ),
            const SizedBox(height: 16),

            // --- ROOM LIST ---
            Expanded(
              child: availableRooms.isEmpty
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
                            child: const Icon(Icons.hotel_outlined,
                                size: 48, color: AppTheme.textGray),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'No available rooms',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _selectedPriceFilter == 'All'
                                ? 'No rooms available for ${widget.guests} guests'
                                : 'No rooms in $_selectedPriceFilter range\nfor ${widget.guests} guests',
                            style: const TextStyle(
                                color: AppTheme.textGray, fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _selectedPriceFilter = 'All';
                              });
                            },
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.refresh,
                                    color: AppTheme.goldAccent, size: 16),
                                SizedBox(width: 8),
                                Text('Clear filters',
                                    style:
                                        TextStyle(color: AppTheme.goldAccent)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      itemCount: availableRooms.length,
                      itemBuilder: (context, index) {
                        final room = availableRooms[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: _AvailableRoomCard(
                            id: room['id'] as String,
                            name: room['name'] as String,
                            beds: room['beds'] as int,
                            sqm: room['sqm'] as int,
                            maxGuests: room['maxGuests'] as int,
                            price: room['price'] as int,
                            rating: room['rating'] as double,
                            imageUrl: room['imageUrl'] as String,
                            nights: nights,
                            checkInDate: widget.checkInDate,
                            checkOutDate: widget.checkOutDate,
                            guests: widget.guests,
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  String _getMonthShort(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }
}

// ==========================================
// WIDGETS
// ==========================================

// ✅ PERBAIKAN: Parameter 'icon' dihapus dari sini karena tidak digunakan
class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    this.isSelected = false,
    required this.onTap,
  });

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
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}

class _AvailableRoomCard extends StatefulWidget {
  final String id;
  final String name;
  final int beds;
  final int sqm;
  final int maxGuests;
  final int price;
  final double rating;
  final String imageUrl;
  final int nights;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int guests;

  const _AvailableRoomCard({
    required this.id,
    required this.name,
    required this.beds,
    required this.sqm,
    required this.maxGuests,
    required this.price,
    required this.rating,
    required this.imageUrl,
    required this.nights,
    required this.checkInDate,
    required this.checkOutDate,
    required this.guests,
  });

  @override
  State<_AvailableRoomCard> createState() => _AvailableRoomCardState();
}

class _AvailableRoomCardState extends State<_AvailableRoomCard> {
  final SavedRoomService _savedService = SavedRoomService();

  @override
  void initState() {
    super.initState();
    _savedService.addListener(_onSavedChanged);
  }

  @override
  void dispose() {
    _savedService.removeListener(_onSavedChanged);
    super.dispose();
  }

  void _onSavedChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = widget.price * widget.nights;
    final isSaved = _savedService.isRoomSaved(widget.id);

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
                    image: NetworkImage(widget.imageUrl),
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
                      Text(widget.rating.toString(),
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
                child: GestureDetector(
                  onTap: () {
                    final room = SavedRoom(
                      id: widget.id,
                      name: widget.name,
                      price: widget.price,
                      rating: widget.rating,
                      imageUrl: widget.imageUrl,
                    );
                    _savedService.toggleSave(room);

                    // Show snackbar
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          isSaved ? 'Removed from saved' : 'Added to saved',
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: AppTheme.cardBackground,
                        duration: const Duration(milliseconds: 800),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        shape: BoxShape.circle),
                    child: Icon(
                      isSaved ? Icons.favorite : Icons.favorite_border,
                      color: isSaved ? Colors.red : Colors.white,
                      size: 20,
                    ),
                  ),
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
                Text(widget.name,
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
                    Text('${widget.beds} beds',
                        style: const TextStyle(
                            fontSize: 14, color: AppTheme.textGray)),
                    const SizedBox(width: 16),
                    const Icon(Icons.straighten,
                        color: AppTheme.textGray, size: 16),
                    const SizedBox(width: 4),
                    Text('${widget.sqm} m²',
                        style: const TextStyle(
                            fontSize: 14, color: AppTheme.textGray)),
                    const SizedBox(width: 16),
                    const Icon(Icons.people,
                        color: AppTheme.textGray, size: 16),
                    const SizedBox(width: 4),
                    Text('Up to ${widget.maxGuests}',
                        style: const TextStyle(
                            fontSize: 14, color: AppTheme.textGray)),
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
                            Text('\$${widget.price}',
                                style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            const Text('/night',
                                style: TextStyle(
                                    fontSize: 14, color: AppTheme.textGray)),
                          ],
                        ),
                        Text('\$$totalPrice total',
                            style: const TextStyle(
                                fontSize: 12, color: AppTheme.textGray)),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CustomerRoomDetailScreen(
                              roomId: widget.id,
                              roomName: widget.name,
                              pricePerNight: widget.price,
                              checkInDate: widget.checkInDate,
                              checkOutDate: widget.checkOutDate,
                              guests: widget.guests,
                              nights: widget.nights,
                              imageUrl: widget.imageUrl,
                              rating: widget.rating,
                              beds: widget.beds,
                              sqm: widget.sqm,
                              maxGuests: widget.maxGuests,
                            ),
                          ),
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