import 'package:ai_generation/utils/app_assets.dart';
import 'package:ai_generation/src/utils/app_colors.dart';
import 'package:ai_generation/src/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.storeLabel,
    required this.roleLabel,
  });

  final String storeLabel;
  final String roleLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          padding: const EdgeInsets.all(6),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(14)),
            color: AppColors.primaryAlpha10,
          ),
          child: SvgPicture.asset(
            AppAssets.iconUserSettings,
            width: 20,
            height: 20,
          ),
        ),
        const SizedBox(width: 4),
        Text(storeLabel, style: AppStyles.body14Bold(AppColors.gray900)),
        const SizedBox(width: 4),
        Text(roleLabel, style: AppStyles.body14Medium(AppColors.titleText)),
      ],
    );
  }
}

