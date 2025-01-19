import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_app/utils/constants/colors.dart';
import 'package:video_app/utils/widgets/text_style.dart';

class CustomBottomNav extends BottomNavigationBarItem {
  CustomBottomNav({
    String? label,
    required String iconPath,
    int badgeCount = 0,
  }) : super(
          // label: label,
          label: '',

          icon: badges.Badge(
            showBadge: badgeCount > 0,
            position: badges.BadgePosition.topEnd(top: -8, end: -5),
            badgeContent: Text(
              badgeCount > 9 ? "9+" : "$badgeCount",
              style: CustomTextStyles.f14W400(color: AppColors.background),
            ),
            badgeStyle: const badges.BadgeStyle(
              badgeColor: AppColors.primary,
              shape: badges.BadgeShape.circle,
            ),
            child: SvgPicture.asset(
              iconPath,
              height: 25,
              width: 25,
              colorFilter:
                  const ColorFilter.mode(AppColors.largeText, BlendMode.srcIn),
            ),
          ),
          activeIcon: badges.Badge(
            showBadge: badgeCount > 0,
            position: badges.BadgePosition.topEnd(top: -8, end: -5),
            badgeContent: Text(
              badgeCount > 9 ? "9+" : "$badgeCount",
              style: CustomTextStyles.f14W400(color: AppColors.background),
            ),
            badgeStyle: const badges.BadgeStyle(
              badgeColor: AppColors.primary,
              shape: badges.BadgeShape.circle,
            ),
            child: SvgPicture.asset(
              iconPath,
              height: 30,
              width: 30,
              colorFilter:
                  const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
            ),
          ),
        );
}
