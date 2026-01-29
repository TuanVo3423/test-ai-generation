import 'package:ai_generation/utils/app_assets.dart';
import 'package:ai_generation/src/utils/app_colors.dart';
import 'package:ai_generation/src/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditProfileAppBar extends StatelessWidget {
  const EditProfileAppBar({
    super.key,
    required this.title,
    this.onBackPressed,
  });

  final String title;
  final VoidCallback? onBackPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsetsDirectional.only(
        start: 14,
        end: 14,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(14)),
              onTap: onBackPressed ?? () => Navigator.maybePop(context),
              child: SvgPicture.asset(
                AppAssets.iconBack,
                width: 40,
                height: 40,
              ),
            ),
          ),
          _GradientTitle(title: title),
        ],
      ),
    );
  }
}

class _GradientTitle extends StatelessWidget {
  const _GradientTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) => const LinearGradient(
        colors: [AppColors.primary, AppColors.accentTeal],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(rect),
      child: Text(
        title,
        style: AppStyles.title26Bold().copyWith(color: AppColors.white),
      ),
    );
  }
}
