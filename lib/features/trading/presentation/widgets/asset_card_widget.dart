import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/utils/size_config.dart';
import '../../domain/entities/trading_asset.dart';

class AssetCardWidget extends StatelessWidget {
  final TradingAsset asset;
  final VoidCallback onTap;

  const AssetCardWidget({
    super.key,
    required this.asset,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = asset.isUp ? AppColors.success : AppColors.error;

    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${asset.symbol} - JULY 25',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textColor,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '31-07-2025',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.textGrey,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(
                        asset.isUp ? Icons.arrow_upward : Icons.arrow_downward,
                        color: color,
                        size: 14.w,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        Formatters.formatPercentage(asset.percentageChange),
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: AppColors.cardGrey,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          'Chart',
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: AppColors.textGrey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            _buildPriceCard('Sell', Formatters.formatPrice(asset.price * 0.98), false),
            SizedBox(width: 10.w),
            _buildPriceCard('Buy', Formatters.formatPrice(asset.price), true),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceCard(String label, String price, bool isBuy) {
    return Container(
      width: 85.w,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.cardGrey,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.textGrey,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            price,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: isBuy ? AppColors.blue : AppColors.error,
            ),
          ),
        ],
      ),
    );
  }
}
