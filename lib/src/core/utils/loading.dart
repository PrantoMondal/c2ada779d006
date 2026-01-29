import 'dart:ui';
import 'package:device_vitals/src/core/constants/app_colors.dart';
import 'package:device_vitals/src/core/constants/app_values.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppValues.radiusSmall),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(AppValues.gap),
            decoration: BoxDecoration(
              color: AppColors.surfaceColor.withAlpha((0.4 * 255).round()),
              borderRadius: BorderRadius.circular(AppValues.radiusSmall),
              border: Border.all(
                color: AppColors.primary.withAlpha((0.2 * 255).round()),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowColor.withAlpha((0.2 * 255).round()),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const SizedBox(
              height: 60,
              width: 60,
              child: CircularProgressIndicator(
                strokeWidth: 3.5,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
