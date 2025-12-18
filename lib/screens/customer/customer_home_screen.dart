import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'customer_booking_screen.dart';
import 'customer_search_screen.dart';
import 'customer_facilities_screen.dart';
import 'customer_saved_rooms_screen.dart';
import 'customer_profile_screen.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  int _selectedIndex = 0;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      // Index 0: Home Content
      _HomeContent(
        onSearchTap: () {
          setState(() {
            _selectedIndex = 1;
          });
        },
        onSavedTap: () {
          setState(() {
            _selectedIndex = 2;
          });
        },
      ),
      
      // Index 1: Search Screen
      const CustomerSearchScreen(),
      
      // Index 2: Saved Screen
      const CustomerSavedRoomsScreen(),
      
      // Index 3: Profile Screen
      const CustomerProfileScreen(), 
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: AppTheme.cardBackground,
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          backgroundColor: AppTheme.cardBackground,
          selectedItemColor: AppTheme.goldAccent,
          unselectedItemColor: AppTheme.textGray,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline), label: 'Saved'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// WIDGET KONTEN HOME
// ---------------------------------------------------------------------------
class _HomeContent extends StatelessWidget {
  final VoidCallback onSearchTap;
  final VoidCallback onSavedTap;

  const _HomeContent({
    required this.onSearchTap,
    required this.onSavedTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- HEADER ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Welcome back',
                          style: TextStyle(fontSize: 14, color: AppTheme.textGray)),
                      SizedBox(height: 4),
                      Text('Alexander',
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Serif',
                              color: Colors.white)),
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppTheme.cardBackground,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppTheme.borderColor),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.notifications_outlined,
                              color: Colors.white, size: 24),
                        ),
                      ),
                      Positioned(
                        right: 12,
                        top: 12,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                              color: AppTheme.goldAccent,
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: AppTheme.cardBackground, width: 1.5)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // --- SEARCH BAR ---
              GestureDetector(
                onTap: onSearchTap,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.cardBackground,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppTheme.borderColor),
                  ),
                  child: const TextField(
                    enabled: false,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search rooms, amenities...',
                      hintStyle: TextStyle(color: AppTheme.textDarkGray),
                      prefixIcon: Icon(Icons.search, color: AppTheme.textGray),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // --- MAIN BANNER ---
              Stack(
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image: NetworkImage(
                            'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?q=80&w=2070&auto=format&fit=crop'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.8)
                        ],
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 20,
                    bottom: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_on,
                                color: Colors.white, size: 16),
                            SizedBox(width: 4),
                            Text('Jakarta, Indonesia',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14)),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text('Discover Luxury Living',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Serif',
                                color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // --- QUICK ACTIONS ---
              const Text('Quick Actions',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Serif',
                      color: Colors.white)),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _QuickActionCard(
                      icon: Icons.calendar_today,
                      label: 'Book',
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const CustomerBookingScreen())),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                      child: _QuickActionCard(
                          icon: Icons.spa, 
                          label: 'Facilities', 
                          onTap: () => Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (_) => const CustomerFacilitiesScreen())
                          ), 
                      )),
                  const SizedBox(width: 12),
                  Expanded(
                      child: _QuickActionCard(
                          icon: Icons.favorite_border,
                          label: 'Saved', 
                          onTap: onSavedTap)),
                  const SizedBox(width: 12),
                  
                  // Reviews Button - Disabled untuk sekarang
                  Expanded(
                      child: _QuickActionCard(
                          icon: Icons.star_border,
                          label: 'Reviews', 
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Reviews feature coming soon!'),
                                backgroundColor: AppTheme.goldAccent,
                              ),
                            );
                          },
                      )),
                ],
              ),
              const SizedBox(height: 32),

              // --- FEATURED ROOMS ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Featured Rooms',
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
                            style: TextStyle(color: AppTheme.goldAccent)),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_forward_ios,
                            size: 12, color: AppTheme.goldAccent),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 290,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    _RoomCard(
                      name: 'Royal Suite',
                      rating: 4.9,
                      price: 850,
                      imageUrl:
                          'https://images.unsplash.com/photo-1631049307264-da0ec9d70304?q=80&w=2070&auto=format&fit=crop',
                    ),
                    SizedBox(width: 16),
                    _RoomCard(
                      name: 'Deluxe Room',
                      rating: 4.8,
                      price: 450,
                      imageUrl:
                          'https://images.unsplash.com/photo-1611892440504-42a792e24d32?q=80&w=2070&auto=format&fit=crop',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- WIDGETS ---

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionCard(
      {required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.borderColor),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: AppTheme.emeraldGreen,
                  borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: Colors.white, size: 22),
            ),
            const SizedBox(height: 12),
            Text(label,
                style: const TextStyle(fontSize: 12, color: AppTheme.textGray)),
          ],
        ),
      ),
    );
  }
}

class _RoomCard extends StatelessWidget {
  final String name;
  final double rating;
  final int price;
  final String imageUrl;

  const _RoomCard({
    required this.name,
    required this.rating,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Show snackbar karena klik dari home belum ada data booking
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please use Book feature to view room details'),
            backgroundColor: AppTheme.goldAccent,
            duration: Duration(seconds: 2),
          ),
        );
      },
      child: Container(
        width: 260,
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppTheme.borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 170,
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
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(8),
                    ),
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
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Serif',
                          color: Colors.white)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text('\$$price',
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.goldAccent)),
                      const Text(' /night',
                          style: TextStyle(
                              fontSize: 12, color: AppTheme.textGray)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}