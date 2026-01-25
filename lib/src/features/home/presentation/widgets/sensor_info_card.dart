import 'package:flutter/material.dart';

class SensorInfoCard extends StatelessWidget {
  final String title;
  final String value;
  final String? unit;
  final String? subtitle;
  final Widget? icon;
  final Color backgroundColor;
  final Color? textColor;
  final double height;
  final BorderRadius? borderRadius;

  const SensorInfoCard({
    super.key,
    required this.title,
    required this.value,
    this.unit,
    this.subtitle,
    this.icon,
    required this.backgroundColor,
    this.textColor,
    this.height = 140,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveTextColor = textColor ?? Colors.white.withOpacity(0.95);
    final effectiveRadius = borderRadius ?? BorderRadius.circular(16);

    return Container(
      height: height,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor.withAlpha(130),
        borderRadius: effectiveRadius,
        border: Border.all(color: effectiveTextColor.withOpacity(0.6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Top row: Icon + Title
          Row(
            children: [
              if (icon != null) ...[icon!, const SizedBox(width: 12)],
              Text(
                title,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: effectiveTextColor,
                ),
              ),
            ],
          ),

          // Main value area (big number)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: effectiveTextColor,
                      height: 1.0,
                    ),
                  ),
                  if (unit != null) ...[
                    const SizedBox(width: 4),
                    Text(
                      unit!,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: effectiveTextColor.withOpacity(0.85),
                      ),
                    ),
                  ],
                ],
              ),

              if (subtitle != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    subtitle!,
                    style: TextStyle(
                      fontSize: 13,
                      color: effectiveTextColor.withOpacity(0.75),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
