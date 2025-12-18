import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/saved_room_service.dart';
import 'customer_payment_screen.dart';

class CustomerRoomDetailScreen extends StatefulWidget {
  final String roomId;
  final String roomName;
  final int pricePerNight;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int guests;
  final int nights;
  final String imageUrl;
  final double rating;
  final int beds;
  final int sqm;
  final int maxGuests;

  const CustomerRoomDetailScreen({
    super.key,
    required this.roomId,
    required this.roomName,
    required this.pricePerNight,
    required this.checkInDate,
    required this.checkOutDate,
    required this.guests,
    required this.nights,
    required this.imageUrl,
    required this.rating,
    required this.beds,
    required this.sqm,
    required this.maxGuests,
  });

  @override
  State<CustomerRoomDetailScreen> createState() =>
      _CustomerRoomDetailScreenState();
}

class _CustomerRoomDetailScreenState extends State<CustomerRoomDetailScreen> {
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
    final totalPrice = widget.pricePerNight * widget.nights;
    final dateStr =
        '${_getMonthShort(widget.checkInDate.month)} ${widget.checkInDate.day} - ${_getMonthShort(widget.checkOutDate.month)} ${widget.checkOutDate.day}';
    final isSaved = _savedService.isRoomSaved(widget.roomId);

    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      body: Stack(
        children: [
          // --- SCROLLABLE CONTENT ---
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. IMAGE HEADER
                Stack(
                  children: [
                    Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(widget.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.transparent,
                            Colors.black.withOpacity(0.4),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 2. TITLE SECTION
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppTheme.goldAccent.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.star,
                                    color: AppTheme.goldAccent, size: 16),
                                const SizedBox(width: 4),
                                Text(widget.rating.toString(),
                                    style: const TextStyle(
                                        color: AppTheme.goldAccent,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text('(124 reviews)',
                              style: TextStyle(color: AppTheme.textGray)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(widget.roomName,
                          style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Serif',
                              color: Colors.white)),
                      const SizedBox(height: 8),
                      Text(
                          '${widget.beds} beds • ${widget.sqm} m² • Up to ${widget.maxGuests} guests',
                          style: const TextStyle(
                              color: AppTheme.textGray, fontSize: 16)),

                      const SizedBox(height: 32),

                      // 3. BOOKING INFO CARD
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppTheme.cardBackground,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppTheme.borderColor),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Check-in',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: AppTheme.textGray)),
                                Text(dateStr.split(' - ')[0],
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Check-out',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: AppTheme.textGray)),
                                Text(dateStr.split(' - ')[1],
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Guests',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: AppTheme.textGray)),
                                Text('${widget.guests} guests',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ],
                            ),
                            const Divider(
                                color: AppTheme.borderColor, height: 32),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    '${widget.nights} nights × \$${widget.pricePerNight}',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: AppTheme.textGray)),
                                Text('\$$totalPrice',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.goldAccent)),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      // 4. ABOUT SECTION
                      const Text('About',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Serif',
                              color: Colors.white)),
                      const SizedBox(height: 12),
                      const Text(
                          'Experience unparalleled luxury in our suite. Featuring panoramic city views, a private terrace, and handcrafted Italian furnishings.',
                          style:
                              TextStyle(color: AppTheme.textGray, height: 1.5)),

                      const SizedBox(height: 32),

                      // 5. AMENITIES SECTION
                      const Text('Amenities',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Serif',
                              color: Colors.white)),
                      const SizedBox(height: 16),
                      const Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          _AmenityCard(icon: Icons.wifi, label: 'Free Wi-Fi'),
                          _AmenityCard(
                              icon: Icons.local_parking, label: 'Parking'),
                          _AmenityCard(icon: Icons.coffee, label: 'Breakfast'),
                          _AmenityCard(
                              icon: Icons.fitness_center, label: 'Gym Access'),
                          _AmenityCard(
                              icon: Icons.pool, label: 'Pool Access'),
                          _AmenityCard(
                              icon: Icons.room_service, label: 'Room Service'),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // 6. FEATURES SECTION
                      const Text('Features',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Serif',
                              color: Colors.white)),
                      const SizedBox(height: 16),
                      const Column(
                        children: [
                          _FeatureRow(label: '24/7 Room Service'),
                          _FeatureRow(label: 'Smart TV with streaming'),
                          _FeatureRow(label: 'Premium minibar'),
                          _FeatureRow(label: 'Luxury bathroom amenities'),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // 7. GUEST REVIEWS
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Guest Reviews',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Serif',
                                  color: Colors.white)),
                          TextButton(
                            onPressed: () {},
                            child: const Row(
                              children: [
                                Text('View All',
                                    style:
                                        TextStyle(color: AppTheme.goldAccent)),
                                SizedBox(width: 4),
                                Icon(Icons.arrow_forward_ios,
                                    size: 12, color: AppTheme.goldAccent),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const _ReviewCard(
                        name: 'James Wilson',
                        review:
                            'Absolutely stunning suite! The views are breathtaking and the service was impeccable.',
                        rating: 5,
                        initials: 'JW',
                        color: Colors.teal,
                      ),
                      const SizedBox(height: 16),
                      const _ReviewCard(
                        name: 'Sophie Chen',
                        review:
                            'Worth every penny! The furnishings are exquisite and the bed is incredibly comfortable.',
                        rating: 5,
                        initials: 'SC',
                        color: Colors.purple,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // --- HEADER BUTTONS ---
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _CircleIconButton(
                  icon: Icons.arrow_back,
                  onTap: () => Navigator.pop(context),
                ),
                Row(
                  children: [
                    _CircleIconButton(
                        icon: Icons.share_outlined, onTap: () {}),
                    const SizedBox(width: 12),
                    _CircleIconButton(
                      icon: isSaved ? Icons.favorite : Icons.favorite_border,
                      color: isSaved ? Colors.red : Colors.white,
                      onTap: () {
                        final room = SavedRoom(
                          id: widget.roomId,
                          name: widget.roomName,
                          price: widget.pricePerNight,
                          rating: widget.rating,
                          imageUrl: widget.imageUrl,
                        );
                        _savedService.toggleSave(room);

                        // Show snackbar
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              isSaved
                                  ? 'Removed from saved'
                                  : 'Added to saved',
                              style: const TextStyle(color: Colors.white),
                            ),
                            backgroundColor: AppTheme.cardBackground,
                            duration: const Duration(milliseconds: 800),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          // --- BOTTOM BAR (BOOK NOW) ---
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: const BoxDecoration(
                color: AppTheme.darkBackground,
                border: Border(top: BorderSide(color: AppTheme.borderColor)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('\$$totalPrice',
                              style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.goldAccent)),
                          Text(' for ${widget.nights} nights',
                              style: const TextStyle(
                                  color: AppTheme.textGray, fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CustomerPaymentScreen(
                            roomName: widget.roomName,
                            pricePerNight: widget.pricePerNight,
                            checkInDate: widget.checkInDate,
                            checkOutDate: widget.checkOutDate,
                            guests: widget.guests,
                            nights: widget.nights,
                            totalPrice: totalPrice,
                            imageUrl: widget.imageUrl,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.goldAccent,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text('Book Now',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ],
              ),
            ),
          ),
        ],
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

// =========================================================
// WIDGET PENDUKUNG
// =========================================================

class _AmenityCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const _AmenityCard({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final width = (MediaQuery.of(context).size.width - 48 - 24) / 3;

    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppTheme.goldAccent, size: 24),
          const SizedBox(height: 8),
          Text(label,
              style: const TextStyle(color: AppTheme.textGray, fontSize: 12),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  final String label;

  const _FeatureRow({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppTheme.emeraldGreen.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check,
                color: AppTheme.emeraldGreen, size: 14),
          ),
          const SizedBox(width: 12),
          Text(label,
              style:
                  const TextStyle(color: AppTheme.textGray, fontSize: 14)),
        ],
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final String name;
  final String review;
  final int rating;
  final String initials;
  final Color color;

  const _ReviewCard({
    required this.name,
    required this.review,
    required this.rating,
    required this.initials,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
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
          Row(
            children: [
              CircleAvatar(
                backgroundColor: color,
                radius: 20,
                child: Text(initials,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                    const SizedBox(height: 4),
                    Row(
                      children: List.generate(
                          5,
                          (index) => Icon(Icons.star,
                              size: 14,
                              color: index < rating
                                  ? AppTheme.goldAccent
                                  : AppTheme.textGray)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(review,
              style: const TextStyle(
                  color: AppTheme.textGray, fontSize: 14, height: 1.4)),
          const SizedBox(height: 8),
          const Row(
            children: [
              Icon(Icons.thumb_up_outlined,
                  size: 14, color: AppTheme.textGray),
              SizedBox(width: 4),
              Text('Helpful',
                  style: TextStyle(color: AppTheme.textGray, fontSize: 12)),
            ],
          )
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;

  const _CircleIconButton({
    required this.icon,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color ?? Colors.white, size: 20),
      ),
    );
  }
}