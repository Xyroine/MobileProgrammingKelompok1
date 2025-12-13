import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/hotel_logo.dart';
import 'login_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 32),
              const HotelLogo(size: HotelLogoSize.medium, showTagline: false),
              const Spacer(),
              const Text(
                'Welcome Back',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Please select how you\'d like to continue',
                style: TextStyle(fontSize: 14, color: AppTheme.textGray),
              ),
              const SizedBox(height: 40),
              _RoleCard(
                icon: Icons.person_outline,
                title: 'Guest',
                subtitle: 'Book rooms & explore amenities',
                gradientColors: [AppTheme.emeraldGreen, AppTheme.emeraldLight],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LoginScreen(isStaff: false),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              _RoleCard(
                icon: Icons.shield_outlined,
                title: 'Staff',
                subtitle: 'Manage bookings & operations',
                gradientColors: null,
                iconColor: AppTheme.goldAccent,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LoginScreen(isStaff: true),
                    ),
                  );
                },
              ),
              const Spacer(),
              RichText(
                text: const TextSpan(
                  text: 'By continuing, you agree to our ',
                  style: TextStyle(fontSize: 12, color: AppTheme.textGray),
                  children: [
                    TextSpan(
                      text: 'Terms of Service',
                      style: TextStyle(color: AppTheme.goldAccent),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final List<Color>? gradientColors;
  final Color? iconColor;
  final VoidCallback onTap;

  const _RoleCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.gradientColors,
    this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.borderColor),
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: gradientColors != null
                    ? LinearGradient(colors: gradientColors!)
                    : null,
                color: gradientColors == null ? AppTheme.cardBackground : null,
                border: gradientColors == null
                    ? Border.all(color: AppTheme.borderColor)
                    : null,
              ),
              child: Icon(icon, color: iconColor ?? Colors.white, size: 24),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 14, color: AppTheme.textGray),
                  ),
                ],
              ),
            ),
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.cardBackground,
              ),
              child: const Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: AppTheme.textGray,
              ),
            ),
          ],
        ),
      ),
    );
  }
}