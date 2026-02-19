///This class is used for app icons in PNG format
class AppIcons {
  AppIcons._();

  /// Root Images Paths From Assets
  /// For Png images
  static const String iconPath = 'assets/images/png/';

  /// For Svg
  static const String svgPath = 'assets/images/svg/';

  /// All Png images declaration below
  /// To use in whole app
  ///
  static const String myFavorites = '${svgPath}MyFavorites.svg';
  static const String order = '${svgPath}Order.svg';
  static const String positions = '${svgPath}Positions.svg';
  static const String wallet = '${svgPath}Wallet.svg';
  static const String walletIcon = '${iconPath}wallet.png';

  static const String svgDown = '${svgPath}down.svg';
  static const String svgUp = '${svgPath}up.svg';
  static const String chart = '${svgPath}chart.svg';
}
