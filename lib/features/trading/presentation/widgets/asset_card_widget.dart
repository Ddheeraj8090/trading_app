import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/drawables/icons.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/utils/size_config.dart';
import '../../domain/entities/trading_asset.dart';

class AssetCardWidget extends StatelessWidget {
  final TradingAsset asset;
  final VoidCallback onTap;
  final double bottomMargin;

  const AssetCardWidget({
    super.key,
    required this.asset,
    required this.onTap,
    this.bottomMargin = 14,
  });

  @override
  Widget build(BuildContext context) {
    final trendColor = asset.isUp ? AppColors.blue : AppColors.error;
    final now = DateTime.now();
    final contractMonth = Formatters.formatContractMonth(now);
    final tradeDate = Formatters.formatTradeDate(now);

    return Container(
      margin: EdgeInsets.only(bottom: bottomMargin.h),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
      decoration: BoxDecoration(color: AppColors.background),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildSymbolBadge(),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          '${asset.symbol} - $contractMonth',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 29.w),
                    child: Text(
                      tradeDate,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.textGrey,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      SvgPicture.asset(
                        asset.isUp ? AppIcons.svgUp : AppIcons.svgDown,
                        height: 14.h,
                        width: 14.w,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        Formatters.formatPercentage(asset.percentageChange),
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: trendColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 3.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(4.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.12),
                              blurRadius: 3,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              AppIcons.chart,
                              height: 12.h,
                              width: 12.w,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              'Chart',
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: AppColors.textGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            _buildPriceCard(
              'Sell',
              Formatters.formatPrice(asset.price * 0.98),
              false,
            ),
            SizedBox(width: 10.w),
            _buildPriceCard('Buy', Formatters.formatPrice(asset.price), true),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceCard(String label, String price, bool isBuy) {
    return Container(
      width: 92.w,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 13.sp, color: AppColors.darkPurple),
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

  Widget _buildSymbolBadge() {
    final config = _badgeConfig(asset.symbol);
    final badgeSize = 20.w;

    if (config.logoUrl != null) {
      return ClipOval(
        child: SizedBox(
          width: badgeSize,
          height: badgeSize,
          child: Image.network(
            config.logoUrl!,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                _buildFallbackBadge(config, badgeSize),
          ),
        ),
      );
    }

    return _buildFallbackBadge(config, badgeSize);
  }

  Widget _buildFallbackBadge(_BadgeConfig config, double badgeSize) {
    return Container(
      width: badgeSize,
      height: badgeSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: config.colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        config.label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 9.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  _BadgeConfig _badgeConfig(String symbol) {
    switch (symbol) {
      case 'AXIS':
        return const _BadgeConfig(
          label: 'A',
          colors: [Color(0xFFB11762), Color(0xFFD04E8C)],
          logoUrl:
              'https://companieslogo.com/img/orig/AXISBANK.BO-8f59e95b.png?t=1720244490',
        );
      case 'HDFC':
        return const _BadgeConfig(
          label: 'H',
          colors: [Color(0xFF004A9F), Color(0xFF0A72D8)],
          logoUrl:
              'https://companieslogo.com/img/orig/HDB-bb6241fe.png?t=1720244492',
        );
      case 'SBIN':
        return const _BadgeConfig(
          label: 'S',
          colors: [Color(0xFF1F6DF0), Color(0xFF4E90FF)],
        );
      case 'ICICI':
        return const _BadgeConfig(
          label: 'I',
          colors: [Color(0xFF7E2F18), Color(0xFFC1552D)],
          logoUrl:
              'https://i.pinimg.com/736x/ff/d5/31/ffd531a6a78464512a97848e14506738.jpg',
        );
      case 'RELIANCE':
        return const _BadgeConfig(
          label: 'R',
          colors: [Color(0xFF3A2C9E), Color(0xFF6457D3)],
        );
      case 'INFY':
        return const _BadgeConfig(
          label: 'IN',
          colors: [Color(0xFF0F8A78), Color(0xFF28B4A0)],
        );
      default:
        return const _BadgeConfig(
          label: 'M',
          colors: [Color(0xFF5E5E5E), Color(0xFF8C8C8C)],
        );
    }
  }
}

class _BadgeConfig {
  final String label;
  final List<Color> colors;
  final String? logoUrl;

  const _BadgeConfig({
    required this.label,
    required this.colors,
    this.logoUrl,
  });
}
