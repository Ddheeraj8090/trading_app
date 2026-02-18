import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class PriceCard extends StatelessWidget {
  final String label;
  final String price;
  final bool isBuy;

  const PriceCard({
    super.key,
    required this.label,
    required this.price,
    required this.isBuy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.cardGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textGrey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            price,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isBuy ? AppColors.blue : AppColors.error,
            ),
          ),
        ],
      ),
    );
  }
}
