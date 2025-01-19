import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_app/utils/constants/colors.dart';
import 'package:video_app/utils/widgets/text_style.dart';

class MyTextField extends StatelessWidget {
  final Function(String)? onValueChange;
  final String? hint;
  final String? prefixIconPath;
  final Widget? prefixIcon;
  final String? suffixIconPath;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final Color? border;
  final bool? readOnly;
  final bool? showError;
  final bool? autofocus;
  final Function()? onTap;
  final Function(String)? onSubmitted;
  final TextCapitalization textCapitalization;
  final Color? fillColor;
  final Color? hintColor;
  final Color? textColor;
  final bool showLabel;
  final bool obscureText;
  final FocusNode? focusNode;
  final double radius;
  final int? maxLength;
  final int? maxLine;
  final int? minLine;

  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final EdgeInsets? contentPadding;
  final InputBorder? enabledBorder;
  final InputBorder? focusedErrorBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? disabledBorder;
  final TextStyle? hintStyle;

  const MyTextField({
    Key? key,
    this.enabled = true,
    this.hint,
    this.prefixIconPath,
    this.suffixIconPath,
    this.onValueChange,
    this.controller,
    this.validator,
    required this.textInputAction,
    required this.textInputType,
    this.border,
    this.readOnly = false,
    this.showError = true,
    this.textCapitalization = TextCapitalization.none,
    this.onTap,
    this.onSubmitted,
    this.autofocus = false,
    this.showLabel = true,
    this.fillColor,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.focusNode,
    this.maxLength,
    this.maxLine,
    this.minLine,
    this.inputFormatters,
    this.hintColor,
    this.radius = 4,
    this.textColor,
    this.contentPadding,
    this.enabledBorder,
    this.focusedErrorBorder,
    this.focusedBorder,
    this.errorBorder,
    this.disabledBorder,
    this.hintStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      onTapOutside: (event) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      maxLength: maxLength,
      cursorColor: AppColors.smallText,
      maxLines: maxLine,
      // minLines: minLine != null ? 1 : null,
      minLines: minLine,
      focusNode: focusNode,
      obscureText: obscureText,
      autocorrect: false,
      autofocus: autofocus!,
      textCapitalization: textCapitalization,
      onFieldSubmitted: onSubmitted,
      onTap: (onTap != null) ? onTap! : null,
      readOnly: (readOnly == null) ? false : readOnly!,
      keyboardType: textInputType,
      textInputAction: textInputAction,
      validator: (validator != null) ? validator : null,
      controller: (controller != null) ? controller : null,
      onChanged: (text) {
        if (onValueChange != null) {
          onValueChange!(text);
        }
      },
      decoration: InputDecoration(
        fillColor: fillColor ?? Colors.transparent,
        filled: true,
        counterStyle: CustomTextStyles.f10W600(),
        prefixIcon: (prefixIconPath != null)
            ? SizedBox(
                width: 24,
                child: Center(
                  child: SvgPicture.asset(
                    prefixIconPath!,
                    height: 24,
                    width: 24,
                    colorFilter: const ColorFilter.mode(
                        AppColors.primary, BlendMode.srcIn),
                  ),
                ),
              )
            : prefixIcon,
        suffixIcon: (suffixIconPath != null)
            ? SvgPicture.asset(suffixIconPath!, fit: BoxFit.scaleDown)
            : suffixIcon,
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: BorderSide(
                  width: 1,
                  color: (border == null) ? AppColors.largeText : border!),
            ),
        focusedErrorBorder: focusedErrorBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: BorderSide(
                  width: 1,
                  color: (border == null) ? AppColors.primary : border!),
            ),
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                  width: 1,
                  color: (border == null) ? AppColors.smallText : border!),
            ),
        errorBorder: errorBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: const BorderSide(width: 1, color: AppColors.primary),
            ),
        disabledBorder: disabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide:
                  const BorderSide(width: 1, color: AppColors.largeText),
            ),
        errorStyle: (showError!)
            ? const TextStyle(fontSize: 12)
            : const TextStyle(fontSize: 0),
        hintText: hint,
        hintStyle: hintStyle ??
            CustomTextStyles.f16W400(
              // color: (!enabled)
              //     ? AppColors.largeText
              //     : hintColor ?? AppColors.smallText

              color: AppColors.largeText,
            ),
      ),
      style: CustomTextStyles.f16W400(color: textColor),
      inputFormatters: inputFormatters,
    );
  }
}
