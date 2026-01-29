import 'package:ai_generation/src/ui/edit_profile/interactor/edit_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit()
      : super(
          const EditProfileState(
            storeLabel: '[東京中央店]',
            roleLabel: 'の アポ担当',
            fullName: '大澤 敬司',
            fullNameKana: 'オオサワ ケイジ',
            birthDate: '1995年11月27日',
            gender: Gender.male,
            email: 'keiji.osawa@example.com',
            phone: '080-9876-5432',
          ),
        );

  void updateFullName(String value) => emit(state.copyWith(fullName: value));
  void updateFullNameKana(String value) =>
      emit(state.copyWith(fullNameKana: value));
  void updateBirthDate(String value) => emit(state.copyWith(birthDate: value));
  void updateGender(Gender value) => emit(state.copyWith(gender: value));
  void updateEmail(String value) => emit(state.copyWith(email: value));
  void updatePhone(String value) => emit(state.copyWith(phone: value));
}

