import 'package:ai_generation/src/localization/locale_key.dart';
import 'package:ai_generation/src/ui/edit_profile/components/edit_profile_app_bar.dart';
import 'package:ai_generation/src/ui/edit_profile/components/edit_profile_bottom_bar.dart';
import 'package:ai_generation/src/ui/edit_profile/components/profile_form_card.dart';
import 'package:ai_generation/src/ui/edit_profile/interactor/edit_profile_cubit.dart';
import 'package:ai_generation/src/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final TextEditingController _nameController;
  late final TextEditingController _nameKanaController;
  late final TextEditingController _birthDateController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: '大澤 敬司');
    _nameKanaController = TextEditingController(text: 'オオサワ ケイジ');
    _birthDateController = TextEditingController(text: '1995年11月27日');
    _emailController = TextEditingController(text: 'keiji.osawa@example.com');
    _phoneController = TextEditingController(text: '080-9876-5432');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nameKanaController.dispose();
    _birthDateController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EditProfileCubit(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.colorF7F7FA, AppColors.colorF2F1EC],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    EditProfileAppBar(title: LocaleKeys.editProfileTitle.tr),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsetsDirectional.only(
                          start: 14,
                          end: 14,
                          top: 14,
                          bottom: 24,
                        ),
                        child: ProfileFormCard(
                          nameController: _nameController,
                          nameKanaController: _nameKanaController,
                          birthDateController: _birthDateController,
                          emailController: _emailController,
                          phoneController: _phoneController,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: EditProfileBottomBar(
              saveLabel: LocaleKeys.editProfileSave.tr,
              onSavePressed: () {},
              homeLabel: LocaleKeys.navHome.tr,
              customerInfoLabel: LocaleKeys.navCustomerInfo.tr,
              calendarLabel: LocaleKeys.navCalendar.tr,
              mapLabel: LocaleKeys.navMap.tr,
            ),
          );
        },
      ),
    );
  }
}
