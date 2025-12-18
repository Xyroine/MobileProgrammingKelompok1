import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'staff_main_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const StaffMainScreen()),
              );
            },
            child: const CircleAvatar(
              backgroundColor: AppTheme.cardBackground,
              child: Icon(Icons.arrow_back, color: Colors.white, size: 20),
            ),
          ),
        ),
        title: const Text(
          'Staff Profile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'serif'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- SECTION 1: HEADER ---
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.cardBackground,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.borderColor),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: AppTheme.emeraldGreen,
                    child: Text('JD', style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('John Doe', style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold)),
                        const Text('Hotel Manager', style: TextStyle(color: AppTheme.goldAccent, fontSize: 16)),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            _buildBadge('Admin', AppTheme.emeraldGreen.withOpacity(0.2), AppTheme.emeraldLight),
                            const SizedBox(width: 8),
                            _buildBadge('Active', AppTheme.goldAccent.withOpacity(0.1), AppTheme.goldAccent),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // --- SECTION 2: STATISTICS ---
            Row(
              children: [
                Expanded(child: _buildStatCard('156', 'Bookings Handled', AppTheme.goldAccent)),
                const SizedBox(width: 12),
                Expanded(child: _buildStatCard('4.9', 'Rating', AppTheme.emeraldLight)),
                const SizedBox(width: 12),
                Expanded(child: _buildStatCard('2y', 'Experience', AppTheme.goldAccent)),
              ],
            ),
            const SizedBox(height: 20),

            // --- SECTION 3: CONTACT INFO ---
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.cardBackground,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.borderColor),
              ),
              child: Column(
                children: [
                  _buildContactItem(Icons.email_outlined, 'Email', 'john.doe@hotel.com'),
                  const Divider(color: AppTheme.borderColor, height: 24),
                  _buildContactItem(Icons.phone_outlined, 'Phone', '+62 812 3456 7890'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // --- SECTION 4: SETTINGS ---
            const Text('Settings', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildSettingsTile(Icons.person_outline, 'Personal Information', 'Name, email, phone'),
            _buildSettingsTile(Icons.shield_outlined, 'Security', 'Password, 2FA'),
            _buildSettingsTile(Icons.notifications_none_outlined, 'Notifications', 'Push, email alerts'),
            _buildSettingsTile(Icons.dark_mode_outlined, 'Appearance', 'Theme, display'),
            
            const SizedBox(height: 32),
            // Sign Out Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.logout),
                label: const Text('Sign Out', style: TextStyle(fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD32F2F),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // --- HELPER METHODS (Harus di dalam class ProfileScreen) ---

  Widget _buildBadge(String text, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(20)),
      child: Text(text, style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildStatCard(String value, String label, Color vColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        children: [
          Text(value, style: TextStyle(color: vColor, fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(color: AppTheme.textGray, fontSize: 10)),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.goldAccent, size: 20),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: AppTheme.textGray, fontSize: 12)),
            Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
          ],
        ),
      ],
    );
  }

  Widget _buildSettingsTile(IconData icon, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppTheme.goldAccent),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        subtitle: Text(subtitle, style: const TextStyle(color: AppTheme.textDarkGray, fontSize: 12)),
        trailing: const Icon(Icons.chevron_right, color: AppTheme.textGray),
      ),
    );
  }
} // AKHIR DARI KELAS PROFIL