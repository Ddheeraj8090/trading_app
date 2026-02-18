import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading_app/core/utils/drawables/images.dart';
import 'package:trading_app/core/utils/fonts/font_family.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/drawables/icons.dart';
import '../../../../core/utils/size_config.dart';
import '../bloc/trading_bloc.dart';
import '../bloc/trading_event.dart';
import '../bloc/trading_state.dart';
import '../widgets/asset_card_widget.dart';
import '../widgets/market_category_item.dart';

class TradingPage extends StatefulWidget {
  const TradingPage({super.key});

  @override
  State<TradingPage> createState() => _TradingPageState();
}

class _TradingPageState extends State<TradingPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedCategory = 0;
  int _selectedBottomNav = 2;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildHeader(),
          _buildTabBar(),
          _buildSearchBar(),
          SizedBox(height: 10.h,),
          Expanded(child: _buildAssetList()),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildHeader() {
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
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFC28FEA),
                            offset: const Offset(0, 4),
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
                          /// Amount Text
                          Text(
                            "122200",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontStyles.medium,
                              fontFamily: FontFamily.poppins,
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
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.notifications,
                            size: 30.w,
                            color: const Color(0xFF1A1A1A),
                          ),
                        ],
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
                              colors: [
                                Color(0xFFA71212),
                                Color(0xFFFF0000),
                              ],
                            ),
                            border: Border.all(
                              color: Color(0xFFDFC5EC),
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
                            "10",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w700,
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
                children: [
                  MarketCategoryItem(
                    icon: AppImages.indianMarket,
                    label: 'Indian Market',
                    isSelected: _selectedCategory == 0,
                    onTap: () => setState(() => _selectedCategory = 0),
                  ),
                  MarketCategoryItem(
                    icon: AppImages.international,
                    label: 'International',
                    isSelected: _selectedCategory == 1,
                    onTap: () => setState(() => _selectedCategory = 1),
                  ),
                  MarketCategoryItem(
                    icon: AppImages.forexFutures,
                    label: 'Forex Futures',
                    isSelected: _selectedCategory == 2,
                    onTap: () => setState(() => _selectedCategory = 2),
                  ),
                  MarketCategoryItem(
                    icon: AppImages.cryptoFutures,
                    label: 'Crypto Futures',
                    isSelected: _selectedCategory == 3,
                    onTap: () => setState(() => _selectedCategory = 3),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: AppColors.background,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        indicator: const BoxDecoration(),
        labelPadding: EdgeInsets.symmetric(horizontal: 8.w),
        dividerColor: Colors.transparent,
        tabs: [
          _buildTab('NSE FUTURES', 0),
          _buildTab('NSE OPTION', 1),
          _buildTab('MCX FUTURES', 2),
          _buildTab('MCX OPTIONS', 3),
        ],
      ),
    );
  }

  Widget _buildTab(String text, int index) {
    final isSelected = _tabController.index == index;
    return Container(
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
        color: isSelected ? null : Colors.transparent,
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
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      height: 45.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 4),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search Nse Futures',
          hintStyle: TextStyle(color: AppColors.textLight, fontSize: 14.sp),
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

  Widget _buildAssetList() {
    return BlocBuilder<TradingBloc, TradingState>(
      builder: (context, state) {
        if (state is TradingLoaded) {
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: state.assets.length,
            itemBuilder: (context, index) {
              final asset = state.assets[index];
              return AssetCardWidget(
                asset: asset,
                onTap: () {
                  context.read<TradingBloc>().add(SelectAsset(asset.symbol));
                },
              );
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        );
      },
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 75.h,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.primary, AppColors.darkPurple],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildBottomNavItem(Icons.favorite_border, 'My Favorites', 0),
          _buildBottomNavItem(Icons.receipt_long, 'Order', 1),
          _buildBottomNavCenter(),
          _buildBottomNavItem(Icons.work_outline, 'Positions', 3),
          _buildBottomNavItem(Icons.account_balance_wallet, 'Wallet', 4),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedBottomNav == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedBottomNav = index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: AppColors.white.withOpacity(isSelected ? 1.0 : 0.7),
            size: 24.w,
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              color: AppColors.white.withOpacity(isSelected ? 1.0 : 0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavCenter() {
    return Container(
      width: 60.w,
      height: 60.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.darkPurple],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.remove_red_eye, color: AppColors.white, size: 26.w),
          SizedBox(height: 2.h),
          Text(
            'Watchlist',
            style: TextStyle(
              fontSize: 9.sp,
              color: AppColors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
