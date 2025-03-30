import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

class NavItem {
  Widget icon;
  Widget icon2;
  String title;

  NavItem(this.icon, this.icon2, this.title);

  static List<NavItem> navItems = [
    NavItem(
      SvgPicture.asset(
        'assets/icons/campaign-navbar-icon.svg',
        colorFilter: ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
      ),
      SvgPicture.asset(
        'assets/icons/campaign-navbar-icon.svg',
        colorFilter: ColorFilter.mode(kLowTextColor, BlendMode.srcIn),
      ),
      "Chiến Dịch",
    ),
    NavItem(
      SvgPicture.asset(
        'assets/icons/voucher-navbar-icon.svg',
        colorFilter: ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
      ),
      SvgPicture.asset(
        'assets/icons/voucher-navbar-icon.svg',
        colorFilter: ColorFilter.mode(kLowTextColor, BlendMode.srcIn),
      ),
      "Kho Ưu Đãi",
    ),
    NavItem(
      SvgPicture.asset(
        'assets/icons/reward-navbar-icon.svg',
        colorFilter: ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
      ),
      SvgPicture.asset(
        'assets/icons/reward-navbar-icon.svg',
        colorFilter: ColorFilter.mode(kLowTextColor, BlendMode.srcIn),
      ),
      "Thành Tựu",
    ),
    NavItem(
      SvgPicture.asset(
        'assets/icons/profile-navbar-icon.svg',
        colorFilter: ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
      ),
      SvgPicture.asset(
        'assets/icons/profile-navbar-icon.svg',
        colorFilter: ColorFilter.mode(kLowTextColor, BlendMode.srcIn),
      ),
      "Cá nhân",
    ),
  ];
}

class NavItemStore {
  Widget icon;
  Widget icon2;
  String title;

  NavItemStore(this.icon, this.icon2, this.title);

  static List<NavItemStore> navItems = [
    NavItemStore(
      SvgPicture.asset(
        'assets/icons/voucher-navbar-icon.svg',
        colorFilter: ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
      ),
      SvgPicture.asset(
        'assets/icons/voucher-navbar-icon.svg',
        colorFilter: ColorFilter.mode(kLowTextColor, BlendMode.srcIn),
      ),
      "Ưu đãi",
    ),
    NavItemStore(
      SvgPicture.asset(
        'assets/icons/dashboard-icon.svg',
        colorFilter: ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
      ),
      SvgPicture.asset(
        'assets/icons/dashboard-icon.svg',
        colorFilter: ColorFilter.mode(kLowTextColor, BlendMode.srcIn),
      ),
      "Thống kê",
    ),
    NavItemStore(
      SvgPicture.asset(
        'assets/icons/transaction-icon.svg',
        colorFilter: ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
      ),
      SvgPicture.asset(
        'assets/icons/transaction-icon.svg',
        colorFilter: ColorFilter.mode(kLowTextColor, BlendMode.srcIn),
      ),
      "Giao dịch",
    ),
    NavItemStore(
      SvgPicture.asset(
        'assets/icons/profile-navbar-icon.svg',
        colorFilter: ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
      ),
      SvgPicture.asset(
        'assets/icons/profile-navbar-icon.svg',
        colorFilter: ColorFilter.mode(kLowTextColor, BlendMode.srcIn),
      ),
      "Cá nhân",
    ),
  ];
}

class NavItemLecturer {
  Widget icon;
  Widget icon2;
  String title;

  NavItemLecturer(this.icon, this.icon2, this.title);

  static List<NavItemLecturer> navItems = [
    NavItemLecturer(
      SvgPicture.asset(
        'assets/icons/university.svg',
        colorFilter: ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
      ),
      SvgPicture.asset(
        'assets/icons/university.svg',
        colorFilter: ColorFilter.mode(kLowTextColor, BlendMode.srcIn),
      ),
      "Campus",
    ),
    NavItemLecturer(
      SvgPicture.asset(
        'assets/icons/dashboard-icon.svg',
        colorFilter: ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
      ),
      SvgPicture.asset(
        'assets/icons/dashboard-icon.svg',
        colorFilter: ColorFilter.mode(kLowTextColor, BlendMode.srcIn),
      ),
      "Thống kê",
    ),
    NavItemLecturer(
      SvgPicture.asset(
        'assets/icons/transaction-icon.svg',
        colorFilter: ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
      ),
      SvgPicture.asset(
        'assets/icons/transaction-icon.svg',
        colorFilter: ColorFilter.mode(kLowTextColor, BlendMode.srcIn),
      ),
      "Giao dịch",
    ),
    NavItemLecturer(
      SvgPicture.asset(
        'assets/icons/profile-navbar-icon.svg',
        colorFilter: ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
      ),
      SvgPicture.asset(
        'assets/icons/profile-navbar-icon.svg',
        colorFilter: ColorFilter.mode(kLowTextColor, BlendMode.srcIn),
      ),
      "Cá nhân",
    ),
  ];
}
