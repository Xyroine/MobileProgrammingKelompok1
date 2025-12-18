import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'customer_facility_detail_screen.dart';

class CustomerFacilitiesScreen extends StatelessWidget {
  const CustomerFacilitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    style: IconButton.styleFrom(backgroundColor: AppTheme.cardBackground),
                  ),
                  const SizedBox(width: 16),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hotel Facilities', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                      Text('Discover our premium amenities', style: TextStyle(fontSize: 14, color: AppTheme.textGray)),
                    ],
                  ),
                ],
              ),
            ),

            // Facilities List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  _FacilityCard(
                    icon: Icons.water_drop,
                    iconColor: AppTheme.emeraldGreen,
                    name: 'Infinity Pool',
                    description: 'Dive into luxury with our stunning rooftop infinity pool overlooking the city skyline. Features heated water...',
                    hours: '24 Hours',
                    location: 'Rooftop, Floor 25',
                    imageColor: AppTheme.emeraldGreen,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CustomerFacilityDetailScreen(
                          facility: FacilityModel(
                            icon: Icons.water_drop,
                            iconColor: AppTheme.emeraldGreen,
                            name: 'Infinity Pool',
                            description: 'Dive into luxury with our stunning rooftop infinity pool overlooking the city skyline. Features heated water year-round.',
                            hours: '6:00 AM - 10:00 PM',
                            location: 'Rooftop, Floor 25',
                            imageColor: AppTheme.emeraldGreen,
                            features: ['Heated Pool', 'Poolside Bar', 'Cabanas', 'Towel Service', 'Kids Section'],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _FacilityCard(
                    icon: Icons.fitness_center,
                    iconColor: AppTheme.goldAccent,
                    name: 'Fitness Center',
                    description: 'State-of-the-art gym equipment with personal trainers available. Open 24/7 for your convenience...',
                    hours: '24 Hours',
                    location: 'Floor 3',
                    imageColor: AppTheme.goldAccent,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CustomerFacilityDetailScreen(
                          facility: FacilityModel(
                            icon: Icons.fitness_center,
                            iconColor: AppTheme.goldAccent,
                            name: 'Fitness Center',
                            description: 'State-of-the-art gym equipment with personal trainers available. Open 24/7 for your convenience.',
                            hours: '24 Hours',
                            location: 'Floor 3',
                            imageColor: AppTheme.goldAccent,
                            features: ['Cardio Equipment', 'Free Weights', 'Personal Trainer', 'Yoga Studio', 'Locker Room'],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _FacilityCard(
                    icon: Icons.spa,
                    iconColor: const Color(0xFFE91E63),
                    name: 'Luxury Spa',
                    description: 'Relax and rejuvenate with our premium spa services. Professional therapists and tranquil atmosphere...',
                    hours: '9:00 AM - 9:00 PM',
                    location: 'Floor 2',
                    imageColor: const Color(0xFFE91E63),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CustomerFacilityDetailScreen(
                          facility: FacilityModel(
                            icon: Icons.spa,
                            iconColor: const Color(0xFFE91E63),
                            name: 'Luxury Spa',
                            description: 'Relax and rejuvenate with our premium spa services. Professional therapists and tranquil atmosphere.',
                            hours: '9:00 AM - 9:00 PM',
                            location: 'Floor 2',
                            imageColor: const Color(0xFFE91E63),
                            features: ['Massage Therapy', 'Sauna', 'Steam Room', 'Jacuzzi', 'Beauty Treatments'],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _FacilityCard(
                    icon: Icons.restaurant,
                    iconColor: const Color(0xFFFF9800),
                    name: 'Fine Dining Restaurant',
                    description: 'Experience world-class cuisine prepared by our award-winning chefs. International and local dishes...',
                    hours: '6:00 AM - 11:00 PM',
                    location: 'Floor 1',
                    imageColor: const Color(0xFFFF9800),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CustomerFacilityDetailScreen(
                          facility: FacilityModel(
                            icon: Icons.restaurant,
                            iconColor: const Color(0xFFFF9800),
                            name: 'Fine Dining Restaurant',
                            description: 'Experience world-class cuisine prepared by our award-winning chefs. International and local dishes.',
                            hours: '6:00 AM - 11:00 PM',
                            location: 'Floor 1',
                            imageColor: const Color(0xFFFF9800),
                            features: ['Breakfast Buffet', 'A la Carte Menu', 'Private Dining', 'Wine Selection', 'Outdoor Seating'],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Navigator.pop(context);
          }
        },
        backgroundColor: AppTheme.cardBackground,
        selectedItemColor: AppTheme.goldAccent,
        unselectedItemColor: AppTheme.textGray,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_outline), label: 'Saved'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

class _FacilityCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String name;
  final String description;
  final String hours;
  final String location;
  final Color imageColor;
  final VoidCallback onTap;

  const _FacilityCard({
    required this.icon,
    required this.iconColor,
    required this.name,
    required this.description,
    required this.hours,
    required this.location,
    required this.imageColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppTheme.borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Stack(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: imageColor.withOpacity(0.3),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: iconColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: Colors.white, size: 24),
                  ),
                ),
              ],
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Icon(Icons.chevron_right, color: AppTheme.textGray, size: 24),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppTheme.textGray,
                      height: 1.5,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.access_time, color: AppTheme.textGray, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        hours,
                        style: const TextStyle(fontSize: 14, color: AppTheme.textGray),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.location_on, color: AppTheme.textGray, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        location,
                        style: const TextStyle(fontSize: 14, color: AppTheme.textGray),
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
  }
}

// Model class untuk facility data
class FacilityModel {
  final IconData icon;
  final Color iconColor;
  final String name;
  final String description;
  final String hours;
  final String location;
  final Color imageColor;
  final List<String> features;

  FacilityModel({
    required this.icon,
    required this.iconColor,
    required this.name,
    required this.description,
    required this.hours,
    required this.location,
    required this.imageColor,
    required this.features,
  });
}