import 'package:flutter/material.dart';
import 'package:trading_app/core/utils/size_config.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/fonts/font_family.dart';

class MarketCategoryItem extends StatelessWidget {
  final String icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const MarketCategoryItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(icon, width: 38.h, height: 38.w),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: isSelected ? 12.sp : 11.sp,
              color: isSelected ? AppColors.textColor : AppColors.textGrey,
              fontWeight: isSelected ? FontStyles.semiBold : FontStyles.regular,
              fontFamily: FontFamily.roboto,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 6),
          if (isSelected)
            Container(width: 10.hp, height: 2, color: AppColors.textColor),
        ],
      ),
    );
  }
}
