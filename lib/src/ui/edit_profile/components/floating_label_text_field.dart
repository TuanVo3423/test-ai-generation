import 'package:ai_generation/src/utils/app_colors.dart';
import 'package:ai_generation/src/utils/app_styles.dart';
import 'package:flutter/material.dart';

class FloatingLabelTextField extends StatelessWidget {
  const FloatingLabelTextField({
    super.key,
    required this.label,
    required this.controller,
    this.onChanged,
    this.readOnly = false,
    this.suffix,
    this.keyboardType,
    this.textInputAction,
    this.onTap,
  });

  final String label;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final bool readOnly;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 60,
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 15),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            border: Border.fromBorderSide(
              BorderSide(color: AppColors.textFieldBorder, width: 1),
            ),
            color: AppColors.white,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller,
                  onChanged: onChanged,
                  readOnly: readOnly,
                  onTap: onTap,
                  keyboardType: keyboardType,
                  textInputAction: textInputAction,
                  style: AppStyles.body14Medium(AppColors.gray900),
                  decoration: const InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsetsDirectional.only(top: 16),
                  ),
                ),
              ),
              if (suffix != null) suffix!,
            ],
          ),
        ),
        PositionedDirectional(
          top: -12,
          start: 11,
          child: Container(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 8,
              vertical: 2,
            ),
            decoration: const BoxDecoration(color: AppColors.white),
            child: Text(
              label,
              style: AppStyles.label12(AppColors.titleText),
            ),
          ),
        ),
      ],
    );
  }
}

