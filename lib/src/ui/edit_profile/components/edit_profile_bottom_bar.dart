import 'package:ai_generation/utils/app_assets.dart';
import 'package:ai_generation/src/utils/app_colors.dart';
import 'package:ai_generation/src/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditProfileBottomBar extends StatelessWidget {
  const EditProfileBottomBar({
    super.key,
    required this.saveLabel,
    required this.onSavePressed,
    required this.homeLabel,
    required this.customerInfoLabel,
    required this.calendarLabel,
    required this.mapLabel,
    this.onHomePressed,
    this.onCustomerInfoPressed,
    this.onCalendarPressed,
    this.onMapPressed,
    this.onCenterActionPressed,
  });

  final String saveLabel;
  final VoidCallback onSavePressed;

  final String homeLabel;
  final String customerInfoLabel;
  final String calendarLabel;
  final String mapLabel;

  final VoidCallback? onHomePressed;
  final VoidCallback? onCustomerInfoPressed;
  final VoidCallback? onCalendarPressed;
  final VoidCallback? onMapPressed;
  final VoidCallback? onCenterActionPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowBlackAlpha06,
            offset: Offset(0, -2),
            blurRadius: 26,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(14),
            child: SizedBox(
              height: 56,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                onPressed: onSavePressed,
                child: Text(saveLabel, style: AppStyles.button18Bold()),
              ),
            ),
          ),
          Container(
            height: 80,
            padding: const EdgeInsetsDirectional.only(
              start: 20,
              end: 20,
              bottom: 16,
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              color: AppColors.bottomNavBackground,
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowBlackAlpha06,
                  offset: Offset(0, -2),
                  blurRadius: 26,
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _NavItem(
                  label: homeLabel,
                  iconAsset: AppAssets.navHome,
                  onTap: onHomePressed,
                ),
                const SizedBox(width: 27),
                _NavItem(
                  label: customerInfoLabel,
                  iconAsset: AppAssets.navCustomerInfo,
                  onTap: onCustomerInfoPressed,
                ),
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: InkWell(
                      onTap: onCenterActionPressed,
                      child: SvgPicture.asset(
                        AppAssets.navCenterAction,
                        width: 90,
                        height: 90,
                      ),
                    ),
                  ),
                ),
                _NavItem(
                  label: calendarLabel,
                  iconAsset: AppAssets.navCalendar,
                  onTap: onCalendarPressed,
                ),
                const SizedBox(width: 27),
                _NavItem(
                  label: mapLabel,
                  iconAsset: AppAssets.navMap,
                  onTap: onMapPressed,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.label,
    required this.iconAsset,
    this.onTap,
  });

  final String label;
  final String iconAsset;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 58,
      child: InkWell(
        onTap: onTap,
        child: Align(
          alignment: AlignmentDirectional.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(iconAsset, width: 34, height: 34),
              const SizedBox(height: 2),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppStyles.label12(AppColors.baseBlack),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
