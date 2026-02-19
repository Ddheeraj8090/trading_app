import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/formatters.dart';
import '../../domain/entities/trading_asset.dart';
import 'price_card_widget.dart';

class AssetListItem extends StatelessWidget {
  final TradingAsset asset;
  final VoidCallback onTap;
  final bool isSelected;

  const AssetListItem({
    super.key,
    required this.asset,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = asset.isUp ? AppColors.success : AppColors.error;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
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
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '31-07-2025',
                    style: TextStyle(fontSize: 12, color: AppColors.textGrey),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        asset.isUp ? Icons.arrow_upward : Icons.arrow_downward,
                        color: color,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        Formatters.formatPercentage(asset.percentageChange),
                        style: TextStyle(
                          fontSize: 12,
                          color: color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.cardGrey,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'Chart',
                          style: TextStyle(
                            fontSize: 10,
                            color: AppColors.textGrey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            PriceCard(
              label: 'Sell',
              price: Formatters.formatPrice(asset.price * 0.98),
              isBuy: false,
            ),
            const SizedBox(width: 10),
            PriceCard(
              label: 'Buy',
              price: Formatters.formatPrice(asset.price),
              isBuy: true,
            ),
          ],
        ),
      ),
    );
  }
}
