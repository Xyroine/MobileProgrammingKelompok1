import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum HotelLogoSize { small, medium, large, extraLarge }

class HotelLogo extends StatelessWidget {
  final HotelLogoSize size;
  final bool showTagline;

  const HotelLogo({
    super.key,
    this.size = HotelLogoSize.medium,
    this.showTagline = true,
  });

  double get _logoSize {
    switch (size) {
      case HotelLogoSize.small:
        return 60;
      case HotelLogoSize.medium:
        return 80;
      case HotelLogoSize.large:
        return 100;
      case HotelLogoSize.extraLarge:
        return 120;
    }
  }

  double get _fontSize {
    switch (size) {
      case HotelLogoSize.small:
        return 32;
      case HotelLogoSize.medium:
        return 40;
      case HotelLogoSize.large:
        return 48;
      case HotelLogoSize.extraLarge:
        return 64;
    }
  }

  double get _titleFontSize {
    switch (size) {
      case HotelLogoSize.small:
        return 24;
      case HotelLogoSize.medium:
        return 32;
      case HotelLogoSize.large:
        return 40;
      case HotelLogoSize.extraLarge:
        return 48;
    }
  }

  double get _subtitleFontSize {
    switch (size) {
      case HotelLogoSize.small:
        return 10;
      case HotelLogoSize.medium:
        return 12;
      case HotelLogoSize.large:
        return 13;
      case HotelLogoSize.extraLarge:
        return 14;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: _logoSize,
          height: _logoSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppTheme.goldAccent, width: 2),
          ),
          child: Center(
            child: Text(
              'É',
              style: TextStyle(
                fontSize: _fontSize,
                color: AppTheme.goldAccent,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
        SizedBox(height: _logoSize * 0.25),
        Text(
          'ÉCLAT',
          style: TextStyle(
            fontSize: _titleFontSize,
            color: AppTheme.goldAccent,
            fontWeight: FontWeight.w300,
            letterSpacing: _titleFontSize * 0.15,
          ),
        ),
        if (showTagline) ...[
          SizedBox(height: _logoSize * 0.06),
          Text(
            'LUXURY HOTELS',
            style: TextStyle(
              fontSize: _subtitleFontSize,
              color: AppTheme.textGray,
              letterSpacing: _subtitleFontSize * 0.28,
            ),
          ),
        ],
      ],
    );
  }
}