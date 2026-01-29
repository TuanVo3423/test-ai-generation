import 'package:ai_generation/src/localization/locale_key.dart';
import 'package:ai_generation/src/ui/edit_profile/components/floating_label_text_field.dart';
import 'package:ai_generation/src/ui/edit_profile/components/gender_selector.dart';
import 'package:ai_generation/src/ui/edit_profile/components/profile_header.dart';
import 'package:ai_generation/src/ui/edit_profile/interactor/edit_profile_cubit.dart';
import 'package:ai_generation/src/ui/edit_profile/interactor/edit_profile_state.dart';
import 'package:ai_generation/src/utils/app_colors.dart';
import 'package:ai_generation/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfileFormCard extends StatelessWidget {
  const ProfileFormCard({
    super.key,
    required this.nameController,
    required this.nameKanaController,
    required this.birthDateController,
    required this.emailController,
    required this.phoneController,
    this.onBirthDateTap,
  });

  final TextEditingController nameController;
  final TextEditingController nameKanaController;
  final TextEditingController birthDateController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final VoidCallback? onBirthDateTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.only(
        start: 14,
        end: 14,
        top: 20,
        bottom: 14,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(14)),
        color: AppColors.white,
      ),
      child: BlocBuilder<EditProfileCubit, EditProfileState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ProfileHeader(
                storeLabel: '${state.storeLabel} ',
                roleLabel: state.roleLabel,
              ),
              const SizedBox(height: 24),
              FloatingLabelTextField(
                label: LocaleKeys.editProfileName.tr,
                controller: nameController,
                onChanged: context.read<EditProfileCubit>().updateFullName,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 24),
              FloatingLabelTextField(
                label: LocaleKeys.editProfileNameKana.tr,
                controller: nameKanaController,
                onChanged: context.read<EditProfileCubit>().updateFullNameKana,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 24),
              FloatingLabelTextField(
                label: LocaleKeys.editProfileBirthDate.tr,
                controller: birthDateController,
                readOnly: true,
                onTap: onBirthDateTap,
                suffix: SvgPicture.asset(
                  AppAssets.iconCalendar,
                  width: 26,
                  height: 26,
                ),
              ),
              const SizedBox(height: 24),
              GenderSelector(
                selected: state.gender,
                maleLabel: LocaleKeys.editProfileGenderMale.tr,
                femaleLabel: LocaleKeys.editProfileGenderFemale.tr,
                onChanged: context.read<EditProfileCubit>().updateGender,
              ),
              const SizedBox(height: 24),
              FloatingLabelTextField(
                label: LocaleKeys.editProfileEmail.tr,
                controller: emailController,
                onChanged: context.read<EditProfileCubit>().updateEmail,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 24),
              FloatingLabelTextField(
                label: LocaleKeys.editProfilePhone.tr,
                controller: phoneController,
                onChanged: context.read<EditProfileCubit>().updatePhone,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
              ),
            ],
          );
        },
      ),
    );
  }
}
