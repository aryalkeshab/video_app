import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_app/utils/constants/colors.dart';
import 'package:video_app/utils/constants/icon_path.dart';
import 'package:video_app/utils/constants/validators.dart';
import 'package:video_app/utils/widgets/text_field.dart';

class PasswordField extends StatelessWidget {
  final FocusNode? focusNode;
  final String hint;
  final bool showPassword;
  final VoidCallback onEyeClick;
  final Function(String)? onSubmit;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final String? Function(String? value)? validator;
  const PasswordField({
    Key? key,
    required this.hint,
    required this.showPassword,
    required this.onEyeClick,
    required this.controller,
    required this.textInputAction,
    this.onSubmit,
    this.focusNode,
    this.validator = Validators.checkFieldEmpty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyTextField(
      maxLine: 1,
      onSubmitted: onSubmit,
      focusNode: focusNode,
      controller: controller,
      obscureText: !showPassword,
      hint: hint,
      validator: validator,
      textInputAction: textInputAction,
      textInputType: TextInputType.visiblePassword,
      suffixIcon: InkWell(
        onTap: onEyeClick,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: SvgPicture.asset(
            showPassword ? IconPath.eye : IconPath.eyeOff,
            fit: BoxFit.scaleDown,
            height: 12,
            width: 12,
            colorFilter: const ColorFilter.mode(
              AppColors.smallText,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
