import 'package:device_vitals/src/core/constants/app_values.dart';
import 'package:flutter/material.dart';

class SensorInfoCard extends StatelessWidget {
  final String title;
  final String status;
  final String value;
  final String? subtitle;

  /// Icon OR asset
  final IconData? icon;
  final String? assetPath;

  final Color iconColor;
  final Color cardColor;
  final Color textColor;
  final double height;
  final BorderRadius borderRadius;

  const SensorInfoCard({
    super.key,
    required this.title,
    required this.status,
    required this.value,
    this.subtitle,
    this.icon,
    this.assetPath,
    required this.iconColor,
    required this.cardColor,
    this.textColor = Colors.black87,
    this.height = 140,
    this.borderRadius = const BorderRadius.all(Radius.circular(AppValues.radiusMedium)),
  }) : assert(
         icon != null || assetPath != null,
         'Either icon or assetPath must be provided',
       );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsets.only(bottom: AppValues.gap),
      padding: const EdgeInsets.all(AppValues.gap),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: borderRadius,
        border: Border.all(
          color: cardColor.withOpacity(0.4),
          width: AppValues.borderWidth,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Header
          Row(
            children: [
              _buildIcon(),
              const SizedBox(width: AppValues.gapSmall),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: AppValues.fontMedium,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    status,
                    style: TextStyle(
                      fontSize: AppValues.fontSmall,
                      color: textColor.withOpacity(0.65),
                    ),
                  ),
                ],
              ),
            ],
          ),

          /// Value Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: AppValues.fontXLarge,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(
                  subtitle!,
                  style: TextStyle(
                    fontSize: AppValues.fontSmall,
                    color: textColor.withOpacity(0.7),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      padding: const EdgeInsets.all(AppValues.gapSmall),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: iconColor.withOpacity(0.15),
      ),
      child: icon != null
          ? Icon(icon, size: AppValues.iconMedium, color: iconColor)
          : Image.asset(
              assetPath!,
              height: AppValues.iconMedium,
              width: AppValues.iconMedium,
              color: iconColor,
            ),
    );
  }
}
