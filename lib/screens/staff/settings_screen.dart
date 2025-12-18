import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Settings', style: AppTheme.titleStyle),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const CircleAvatar(
              backgroundColor: AppTheme.cardBackground,
              child: Icon(Icons.arrow_back, color: Colors.white, size: 20),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSettingsItem(Icons.person_outline, 'Personal Information', 'Name, email, phone'),
          _buildSettingsItem(Icons.shield_outlined, 'Security', 'Password, 2FA'),
          _buildSettingsItem(Icons.notifications_none_outlined, 'Notifications', 'Push, email alerts'),
          _buildSettingsItem(Icons.dark_mode_outlined, 'Appearance', 'Theme, display'),
          _buildSettingsItem(Icons.key_outlined, 'Permissions', 'Access levels'),
          _buildSettingsItem(Icons.help_outline, 'Help & Support', 'FAQ, contact'),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(IconData icon, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white.withOpacity(0.05),
          child: Icon(icon, color: AppTheme.goldAccent, size: 22),
        ),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
        subtitle: Text(subtitle, style: const TextStyle(color: AppTheme.textDarkGray, fontSize: 12)),
        trailing: const Icon(Icons.chevron_right, color: AppTheme.textGray),
        onTap: () {},
      ),
    );
  }
}