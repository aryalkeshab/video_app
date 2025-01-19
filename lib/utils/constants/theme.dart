import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_app/utils/constants/colors.dart';
import 'package:video_app/utils/widgets/text_style.dart';

class CustomTheme {
  static ThemeData basicTheme() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: AppColors.background));

    return ThemeData.light().copyWith(
      dialogBackgroundColor: AppColors.background,
      cardColor: AppColors.background,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColors.background,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.smallText,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle:
              CustomTextStyles.f12W400(color: AppColors.primary),
          unselectedLabelStyle: CustomTextStyles.f12W400(),
          type: BottomNavigationBarType.fixed),
      textTheme: getBasicTextTheme(),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.background,
        modalBackgroundColor: AppColors.background,
        surfaceTintColor: AppColors.background,
        showDragHandle: true,
        dragHandleColor: AppColors.largeText,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: AppColors.background,
          refreshBackgroundColor: AppColors.background,
          linearTrackColor: AppColors.primary,
          circularTrackColor: AppColors.primary),
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      hintColor: AppColors.smallText,
      brightness: Brightness.light,
      colorScheme: ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.smallText,
        error: AppColors.primary,
        onBackground: AppColors.textColor,
        shadow: AppColors.smallText,
        outline: AppColors.largeText,
      ),
      dialogTheme: DialogTheme(
        backgroundColor: AppColors.background,
        titleTextStyle: CustomTextStyles.f16W700(color: AppColors.primary),
        contentTextStyle: CustomTextStyles.f14W400(color: AppColors.textColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  static TextTheme getBasicTextTheme() {
    return ThemeData.light().textTheme.copyWith().apply(
          fontFamily: "Outfit",
          bodyColor: AppColors.largeText,
          displayColor: AppColors.textColor,
          decorationColor: AppColors.smallText,
        );
  }
}
