import 'package:flutter/material.dart';
import 'package:video_app/utils/constants/colors.dart';

class CustomAlertDialog extends StatelessWidget {
  final String? title;
  final String? message;
  final VoidCallback? onCancel;
  final VoidCallback onConfirm;
  final Color confirmColor;
  final String confirmText;
  const CustomAlertDialog({
    super.key,
    this.title,
    this.message,
    this.onCancel,
    required this.onConfirm,
    this.confirmColor = AppColors.golden,
    required this.confirmText,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return AlertDialog(
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      title: title == null
          ? null
          : Text(
              "$title",
              style: theme.textTheme.bodyLarge,
            ),
      content: message == null
          ? null
          : Text(
              "$message",
              textAlign: TextAlign.justify,
              style: theme.textTheme.bodyLarge,
            ),
      actions: [
        TextButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(8), // Set your desired border radius
              ),
              backgroundColor: AppColors.background),
          onPressed: () {
            Navigator.of(context).pop();
            if (onCancel != null) onCancel!();
          },
          child: Text(
            "Cancel",
            style: theme.textTheme.bodyLarge,
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(8), // Set your desired border radius
              ),
              backgroundColor: AppColors.accent),
          onPressed: () {
            onConfirm();
            // Navigator.of(context).pop();
            // Get.back();
          },
          child: Text(
            confirmText,
            style: theme.textTheme.bodyLarge,
          ),
        )
      ],
    );
  }
}
