import 'package:ai_generation/src/ui/edit_profile/interactor/edit_profile_state.dart';
import 'package:ai_generation/src/utils/app_colors.dart';
import 'package:ai_generation/src/utils/app_styles.dart';
import 'package:flutter/material.dart';

class GenderSelector extends StatelessWidget {
  const GenderSelector({
    super.key,
    required this.selected,
    required this.maleLabel,
    required this.femaleLabel,
    required this.onChanged,
  });

  final Gender selected;
  final String maleLabel;
  final String femaleLabel;
  final ValueChanged<Gender> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _GenderOption(
            label: maleLabel,
            selected: selected == Gender.male,
            onTap: () => onChanged(Gender.male),
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _GenderOption(
            label: femaleLabel,
            selected: selected == Gender.female,
            onTap: () => onChanged(Gender.female),
          ),
        ),
      ],
    );
  }
}

class _GenderOption extends StatelessWidget {
  const _GenderOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderColor = selected ? AppColors.primary : AppColors.tabDisableText;
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(100)),
              border: Border.all(color: borderColor, width: 1),
              color: AppColors.transparent,
            ),
            child: selected
                ? Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary,
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          const SizedBox(width: 8),
          Text(label, style: AppStyles.radio16(AppColors.baseBlack)),
        ],
      ),
    );
  }
}

