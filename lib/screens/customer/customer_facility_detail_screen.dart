import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'customer_facilities_screen.dart';

class CustomerFacilityDetailScreen extends StatelessWidget {
  final FacilityModel facility;

  const CustomerFacilityDetailScreen({super.key, required this.facility});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hero Image with Back Button
                    Stack(
                      children: [
                        Container(
                          height: 300,
                          decoration: BoxDecoration(
                            color: facility.imageColor.withOpacity(0.3),
                          ),
                        ),
                        Positioned(
                          top: 16,
                          left: 16,
                          child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.arrow_back, color: Colors.white),
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.black.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Content
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Icon and Title
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: facility.iconColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Icon(facility.icon, color: Colors.white, size: 32),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  facility.name,
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Hours and Location
                          Row(
                            children: [
                              const Icon(Icons.access_time, color: AppTheme.goldAccent, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                facility.hours,
                                style: const TextStyle(fontSize: 14, color: Colors.white),
                              ),
                              const SizedBox(width: 24),
                              const Icon(Icons.location_on, color: AppTheme.goldAccent, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                facility.location,
                                style: const TextStyle(fontSize: 14, color: Colors.white),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),

                          // About Section
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: AppTheme.cardBackground,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: AppTheme.borderColor),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'About',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  facility.description,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: AppTheme.textGray,
                                    height: 1.6,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Features & Amenities
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: AppTheme.cardBackground,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: AppTheme.borderColor),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Features & Amenities',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                ...facility.features.map((feature) => Padding(
                                      padding: const EdgeInsets.only(bottom: 12),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.check_circle,
                                            color: AppTheme.emeraldGreen,
                                            size: 20,
                                          ),
                                          const SizedBox(width: 12),
                                          Text(
                                            feature,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: AppTheme.textGray,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Operating Hours Card
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: AppTheme.cardBackground,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: AppTheme.borderColor),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: AppTheme.goldAccent.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.access_time,
                                    color: AppTheme.goldAccent,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Operating Hours',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        facility.hours,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: AppTheme.textGray,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Button
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: AppTheme.cardBackground,
                border: Border(top: BorderSide(color: AppTheme.borderColor)),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // Show success dialog
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: AppTheme.cardBackground,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        title: const Row(
                          children: [
                            Icon(Icons.check_circle, color: AppTheme.emeraldGreen, size: 32),
                            SizedBox(width: 12),
                            Text(
                              'Access Reserved',
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ],
                        ),
                        content: Text(
                          'Your access to ${facility.name} has been reserved successfully!',
                          style: const TextStyle(color: AppTheme.textGray, fontSize: 14),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'OK',
                              style: TextStyle(color: AppTheme.goldAccent, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.goldAccent,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.bookmark_add, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Reserve Access',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}