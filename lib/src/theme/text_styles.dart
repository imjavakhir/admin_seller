import 'package:admin_seller/app_const/app_exports.dart';

abstract class Styles {
  static const String manropeReg = 'ManropeRegular';
  static const String manropeBold = 'ManropeBold';
  static const String manropeLight = 'ManropeLight';
  static const String manropeMedium = 'ManropeMedium';
  static const String manropeSemibold = 'ManropeSemibold';

  static TextStyle headline1 = TextStyle(
      fontFamily: manropeBold,
      fontSize: 28.sp,
      color: AppColors.black,
      fontWeight: FontWeight.w700);
  static TextStyle headline2 = TextStyle(
      fontFamily: manropeSemibold,
      fontSize: 24.sp,
      color: AppColors.black,
      fontWeight: FontWeight.w600);
  static TextStyle headline3 = TextStyle(
      fontFamily: manropeSemibold,
      fontSize: 20.sp,
      color: AppColors.black,
      fontWeight: FontWeight.w600);
  static TextStyle headline3M = TextStyle(
      fontFamily: manropeMedium,
      fontSize: 20.sp,
      color: AppColors.black,
      fontWeight: FontWeight.w500);
  static TextStyle headline4 = TextStyle(
      fontFamily: manropeMedium,
      fontSize: 18.sp,
      color: AppColors.black,
      fontWeight: FontWeight.w500);
  static TextStyle headline4Reg = TextStyle(
      fontFamily: manropeReg,
      fontSize: 18.sp,
      color: AppColors.black,
      fontWeight: FontWeight.w400);
  static TextStyle headline5M = TextStyle(
      fontFamily: manropeMedium,
      fontSize: 16.sp,
      color: AppColors.black,
      fontWeight: FontWeight.w500);
  static TextStyle headline5 = TextStyle(
      fontFamily: manropeReg,
      fontSize: 16.sp,
      color: AppColors.black,
      fontWeight: FontWeight.w400);
  static TextStyle headline6 = TextStyle(
      fontFamily: manropeLight,
      fontSize: 14.sp,
      color: AppColors.black,
      fontWeight: FontWeight.w300);
}
