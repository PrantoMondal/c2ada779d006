import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

extension Extensions on dynamic {
  String get formattedTime {
    try {
      final dateTime = DateTime.parse(this).toLocal();
      return DateFormat('dd MMM yyyy · hh:mm a').format(dateTime);
    } catch (_) {
      return this;
    }
  }

  String get thermalStatus {
    final temp = this;
    if (temp == null) return 'Loading...';
    if (temp < 35) return 'Cool';
    if (temp < 42) return 'Normal';
    if (temp < 50) return 'Warm';
    return 'Hot • Caution';
  }

  Color get thermalColor {
    final temp = this;
    if (temp == null) return Colors.deepOrange;
    if (temp < 35) return Colors.blue;
    if (temp < 42) return Colors.teal;
    if (temp < 50) return Colors.orange;
    return Colors.redAccent;
  }
}
