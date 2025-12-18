import 'package:flutter/material.dart';
import '../../theme/app_theme.dart'; // Sesuaikan path ini dengan project Anda
import 'customer_facility_detail_screen.dart';

// ==================== MODEL ====================
class FacilityModel {
  final IconData icon;
  final Color iconColor;
  final String name;
  final String description;
  final String hours;
  final String location;
  final Color imageColor;
  final List<String> features;
  final String imageUrl; 

  FacilityModel({
    required this.icon,
    required this.iconColor,
    required this.name,
    required this.description,
    required this.hours,
    required this.location,
    required this.imageColor,
    required this.features,
    required this.imageUrl,
  });
}

// ==================== SCREEN ====================

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
                  // 1. Infinity Pool
                  _FacilityCard(
                    icon: Icons.water_drop,
                    iconColor: AppTheme.emeraldGreen,
                    name: 'Infinity Pool',
                    description: 'Dive into luxury with our stunning rooftop infinity pool overlooking the city skyline.',
                    hours: '24 Hours',
                    location: 'Rooftop, Floor 25',
                    imageUrl: 'https://images.unsplash.com/photo-1576013551627-0cc20b96c2a7?q=80&w=800&auto=format&fit=crop',
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
                            imageUrl: 'https://images.unsplash.com/photo-1576013551627-0cc20b96c2a7?q=80&w=800&auto=format&fit=crop',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // 2. Fitness Center
                  _FacilityCard(
                    icon: Icons.fitness_center,
                    iconColor: AppTheme.goldAccent,
                    name: 'Fitness Center',
                    description: 'State-of-the-art gym equipment with personal trainers available. Open 24/7.',
                    hours: '24 Hours',
                    location: 'Floor 3',
                    imageUrl: 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?q=80&w=800&auto=format&fit=crop',
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
                            imageUrl: 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?q=80&w=800&auto=format&fit=crop',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 3. Luxury Spa (LINK SUDAH DIPERBAIKI)
                  _FacilityCard(
                    icon: Icons.spa,
                    iconColor: const Color(0xFFE91E63),
                    name: 'Luxury Spa',
                    description: 'Relax and rejuvenate with our premium spa services. Professional therapists.',
                    hours: '9:00 AM - 9:00 PM',
                    location: 'Floor 2',
                    // URL BARU
                    imageUrl: 'https://images.unsplash.com/photo-1540555700478-4be289fbecef?q=80&w=800&auto=format&fit=crop',
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
                            // URL BARU
                            imageUrl: 'https://images.unsplash.com/photo-1540555700478-4be289fbecef?q=80&w=800&auto=format&fit=crop',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 4. Fine Dining
                  _FacilityCard(
                    icon: Icons.restaurant,
                    iconColor: const Color(0xFFFF9800),
                    name: 'Fine Dining',
                    description: 'Experience world-class cuisine prepared by our award-winning chefs.',
                    hours: '6:00 AM - 11:00 PM',
                    location: 'Floor 1',
                    imageUrl: 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?q=80&w=800&auto=format&fit=crop',
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
                            imageUrl: 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?q=80&w=800&auto=format&fit=crop',
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
  final String imageUrl;
  final VoidCallback onTap;

  const _FacilityCard({
    required this.icon,
    required this.iconColor,
    required this.name,
    required this.description,
    required this.hours,
    required this.location,
    required this.imageUrl,
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
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: 200,
                        color: AppTheme.cardBackground,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: iconColor,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => Container(
                       height: 200,
                       color: iconColor.withOpacity(0.3),
                       child: const Center(child: Icon(Icons.broken_image, color: AppTheme.textGray)),
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