import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/drawables/icons.dart';
import '../../../../core/utils/fonts/font_family.dart';
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
                            fontSize: 14.sp,
                            color: AppColors.textColor,
                            fontWeight: FontStyles.regular,
                            fontFamily: FontFamily.roboto,
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
                        fontSize: 11.sp,
                        color: AppColors.textGrey,
                        fontWeight: FontStyles.semiBold,
                        fontFamily: FontFamily.roboto,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      SvgPicture.asset(
                        asset.isUp ? AppIcons.svgUp : AppIcons.svgDown,
                        height: 8.h,
                        width: 14.w,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        Formatters.formatPercentage(asset.percentageChange),
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: trendColor,
                          fontWeight: FontStyles.regular,
                          fontFamily: FontFamily.roboto,
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
                              color: AppColors.black.withValues(alpha: 0.12),
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
                              AppStrings.chart,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: AppColors.chartTextColor,
                                fontWeight: FontStyles.regular,
                                fontFamily: FontFamily.roboto,
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
              AppStrings.sell,
              Formatters.formatPrice(asset.price),
              false,
            ),
            SizedBox(width: 10.w),
            _buildPriceCard(
              AppStrings.buy,
              Formatters.formatPrice(asset.price),
              true,
            ),
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
        color: AppColors.priceCardBackground,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13.sp,
                color: AppColors.darkPurple,
                fontWeight: FontStyles.regular,
                fontFamily: FontFamily.roboto,
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Center(
            child: Text(
              price,
              style: TextStyle(
                fontSize: 13.sp,
                color: isBuy ? AppColors.blue : AppColors.error,
                fontWeight: FontStyles.regular,
                fontFamily: FontFamily.roboto,
              ),
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
          color: AppColors.white,
          fontSize: 9.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  _BadgeConfig _badgeConfig(String symbol) {
    switch (symbol) {
      case AppStrings.symbolAxis:
        return const _BadgeConfig(
          label: AppStrings.badgeAxis,
          colors: [AppColors.axisBadgeStart, AppColors.axisBadgeEnd],
          logoUrl: AppStrings.axisLogoUrl,
        );
      case AppStrings.symbolHdfc:
        return const _BadgeConfig(
          label: AppStrings.badgeHdfc,
          colors: [AppColors.hdfcBadgeStart, AppColors.hdfcBadgeEnd],
          logoUrl: AppStrings.hdfcLogoUrl,
        );
      case AppStrings.symbolSbin:
        return const _BadgeConfig(
          label: AppStrings.badgeSbin,
          colors: [AppColors.sbinBadgeStart, AppColors.sbinBadgeEnd],
        );
      case AppStrings.symbolIcici:
        return const _BadgeConfig(
          label: AppStrings.badgeIcici,
          colors: [AppColors.iciciBadgeStart, AppColors.iciciBadgeEnd],
          logoUrl: AppStrings.iciciLogoUrl,
        );
      case AppStrings.symbolReliance:
        return const _BadgeConfig(
          label: AppStrings.badgeReliance,
          colors: [AppColors.relianceBadgeStart, AppColors.relianceBadgeEnd],
        );
      case AppStrings.symbolInfy:
        return const _BadgeConfig(
          label: AppStrings.badgeInfy,
          colors: [AppColors.infyBadgeStart, AppColors.infyBadgeEnd],
        );
      default:
        return const _BadgeConfig(
          label: AppStrings.badgeFallback,
          colors: [AppColors.fallbackBadgeStart, AppColors.fallbackBadgeEnd],
        );
    }
  }
}

class _BadgeConfig {
  final String label;
  final List<Color> colors;
  final String? logoUrl;

  const _BadgeConfig({required this.label, required this.colors, this.logoUrl});
}
