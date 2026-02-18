import 'package:intl/intl.dart';

class Formatters {
  static String formatPrice(double price) {
    return NumberFormat('#,##0.00').format(price);
  }

  static String formatPercentage(double percentage) {
    final sign = percentage >= 0 ? '+' : '';
    return '$sign${percentage.toStringAsFixed(2)}%';
  }

  static String formatCompactNumber(double number) {
    if (number >= 1000000000) {
      return '${(number / 1000000000).toStringAsFixed(1)}B';
    } else if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toStringAsFixed(0);
  }
}
