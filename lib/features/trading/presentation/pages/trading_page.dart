import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trading_app/core/utils/drawables/images.dart';
import 'package:trading_app/core/utils/fonts/font_family.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/drawables/icons.dart';
import '../../../../core/utils/size_config.dart';
import '../bloc/trading_bloc.dart';
import '../bloc/trading_event.dart';
import '../bloc/trading_state.dart';
import '../widgets/asset_card_widget.dart';
import '../widgets/bottom_navigation/curved_navigation_bar.dart';
import '../widgets/bottom_navigation/curved_navigation_bar_item.dart';
import '../widgets/market_category_item.dart';

class TradingPage extends StatelessWidget {
  const TradingPage({super.key});

  static const List<String> _tabs = [
    'NSE FUTURES',
    'NSE OPTION',
    'MCX FUTURES',
    'MCX OPTIONS',
  ];

  static const List<_CategoryConfig> _categories = [
    _CategoryConfig(icon: AppImages.indianMarket, label: 'Indian Market'),
    _CategoryConfig(icon: AppImages.international, label: 'International'),
    _CategoryConfig(icon: AppImages.forexFutures, label: 'Forex Futures'),
    _CategoryConfig(icon: AppImages.cryptoFutures, label: 'Crypto Futures'),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TradingBloc, TradingState>(
      builder: (context, state) {
        final loadedState = state is TradingLoaded ? state : null;
        final selectedCategoryIndex = loadedState?.selectedCategoryIndex ?? 0;
        final selectedTabIndex = loadedState?.selectedTabIndex ?? 0;

        return Scaffold(
          backgroundColor: AppColors.background,
          body: Column(
            children: [
              _buildHeader(context, selectedCategoryIndex),
              _buildTabBar(context, selectedTabIndex),
              _buildSearchBar(context),
              SizedBox(height: 10.h),
              Expanded(child: _buildAssetList(context, state)),
            ],
          ),
          bottomNavigationBar: _buildBottomNav(context, loadedState),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, int selectedCategoryIndex) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(67, 110, 221, 0.4),
            Color.fromRGBO(175, 124, 227, 0.4),
            Color.fromRGBO(175, 105, 199, 0.4),
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Row(
                children: [
                  Icon(Icons.menu, color: AppColors.textColor, size: 24.w),
                  SizedBox(width: 20.w),
                  Text(
                    'Market Watch',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontStyles.medium,
                      color: AppColors.textColor,
                      fontFamily: FontFamily.poppins,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: EdgeInsets.all(1.2),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF436EDD),
                          Color(0xFFAF7CE3),
                          Color(0xFFAF69C7),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(9.r),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(9.r),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFFC28FEA),
                            offset: Offset(0, 4),
                            blurRadius: 1,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            AppIcons.walletIcon,
                            height: 21.h,
                            width: 21.w,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            '122200',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontStyles.semiBold,
                              fontFamily: FontFamily.roboto,
                              foreground: Paint()
                                ..shader = const LinearGradient(
                                  colors: [
                                    Color(0xFF6768E1),
                                    Color(0xFF4A419C),
                                  ],
                                ).createShader(Rect.fromLTWH(0, 0, 200, 70)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Icon(
                        Icons.notifications,
                        size: 30.w,
                        color: const Color(0xFF1A1A1A),
                      ),
                      Positioned(
                        top: -6,
                        right: -6,
                        child: Container(
                          width: 22.w,
                          height: 22.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xFFA71212), Color(0xFFFF0000)],
                            ),
                            border: Border.all(
                              color: const Color(0xFFDFC5EC),
                              width: 1.4,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xFF6D0404),
                                offset: Offset(0, 2),
                                blurRadius: 0,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '10',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.sp,
                              fontWeight: FontStyles.semiBold,
                              fontFamily: FontFamily.roboto,
                              height: 1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(_categories.length, (index) {
                  final category = _categories[index];
                  return MarketCategoryItem(
                    icon: category.icon,
                    label: category.label,
                    isSelected: selectedCategoryIndex == index,
                    onTap: () {
                      context.read<TradingBloc>().add(CategoryChanged(index));
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar(BuildContext context, int selectedTabIndex) {
    return Container(
      color: AppColors.background,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            _tabs.length,
            (index) => Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: _buildTab(
                context: context,
                text: _tabs[index],
                isSelected: selectedTabIndex == index,
                onTap: () {
                  context.read<TradingBloc>().add(TabChanged(index));
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTab({
    required BuildContext context,
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          gradient: isSelected
              ? const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF436EDD),
                    Color(0xFFAF7CE3),
                    Color(0xFFAF69C7),
                  ],
                )
              : null,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: isSelected ? AppColors.white : AppColors.textGrey,
            fontFamily: FontFamily.poppins,
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      height: 45.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 4),
        ],
      ),
      child: TextField(
        onChanged: (value) {
          context.read<TradingBloc>().add(SearchQueryChanged(value));
        },
        decoration: InputDecoration(
          hintText: 'Search Nse Futures',
          hintStyle: TextStyle(
            color: AppColors.textLight,
            fontSize: 14.sp,
            fontWeight: FontStyles.regular,
            fontFamily: FontFamily.roboto,
          ),
          prefixIcon: Icon(Icons.search, color: AppColors.textGrey, size: 20.w),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 12.h,
          ),
        ),
      ),
    );
  }

  Widget _buildAssetList(BuildContext context, TradingState state) {
    if (state is TradingLoaded) {
      if (state.assets.isEmpty) {
        return Center(
          child: Text(
            'No Data found',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.textGrey,
              fontWeight: FontStyles.semiBold,
              fontFamily: FontFamily.roboto,
            ),
          ),
        );
      }

      return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: state.assets.length,
        itemBuilder: (context, index) {
          final asset = state.assets[index];
          return Column(
            children: [
              AssetCardWidget(
                asset: asset,
                bottomMargin: 0,
                onTap: () {
                  /// hand on click
                },
              ),
              if (index != state.assets.length - 1)
                Divider(height: 1, thickness: 1, color: AppColors.border),
            ],
          );
        },
      );
    }

    return const Center(
      child: CircularProgressIndicator(color: AppColors.primary),
    );
  }

  Widget _buildBottomNav(BuildContext context, TradingLoaded? state) {
    final selectedBottomNav = state?.selectedBottomNavIndex ?? 2;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Color(0xFF6768E1),
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
      child: SafeArea(
        top: false,
        child: CurvedNavigationBar(
          index: selectedBottomNav,
          height: 88,
          backgroundColor: Colors.transparent,
          color: const Color(0xFF6768E1),
          gradient: AppColors.footerGradient,
          buttonBackgroundColor: Colors.transparent,
          animationDuration: const Duration(milliseconds: 520),
          animationCurve: Curves.easeInOutCubicEmphasized,
          iconPadding: 0,
          maxWidth: double.infinity,
          onTap: (index) {
            context.read<TradingBloc>().add(BottomNavChanged(index));
          },
          items: [
            _navItem(
              AppIcons.myFavorites,
              'My Favorites',
              0,
              selectedBottomNav,
            ),
            _navItem(AppIcons.order, 'Order', 1, selectedBottomNav),
            _navItem(AppIcons.order, 'Watchlist', 2, selectedBottomNav),
            _navItem(AppIcons.positions, 'Positions', 3, selectedBottomNav),
            _navItem(AppIcons.wallet, 'Wallet', 4, selectedBottomNav),
          ],
        ),
      ),
    );
  }

  CurvedNavigationBarItem _navItem(
    String iconPath,
    String label,
    int index,
    int selectedBottomNav,
  ) {
    final isSelected = selectedBottomNav == index;

    return CurvedNavigationBarItem(
      child: isSelected
          ? Container(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF436EDD),
                    Color(0xFFAF7CE3),
                    Color(0xFFAF69C7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            )
          : Column(
              children: [
                const SizedBox(height: 25),
                SvgPicture.asset(
                  iconPath,
                  height: 20,
                  width: 20,
                  colorFilter: const ColorFilter.mode(
                    Colors.white70,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
      label: label,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.white70,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        fontFamily: FontFamily.poppins,
      ),
    );
  }
}

class _CategoryConfig {
  final String icon;
  final String label;

  const _CategoryConfig({required this.icon, required this.label});
}
