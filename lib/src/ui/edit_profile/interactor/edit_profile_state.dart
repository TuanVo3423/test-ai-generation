import 'package:equatable/equatable.dart';

enum Gender { male, female }

class EditProfileState extends Equatable {
  const EditProfileState({
    required this.storeLabel,
    required this.roleLabel,
    required this.fullName,
    required this.fullNameKana,
    required this.birthDate,
    required this.gender,
    required this.email,
    required this.phone,
  });

  final String storeLabel;
  final String roleLabel;
  final String fullName;
  final String fullNameKana;
  final String birthDate;
  final Gender gender;
  final String email;
  final String phone;

  EditProfileState copyWith({
    String? storeLabel,
    String? roleLabel,
    String? fullName,
    String? fullNameKana,
    String? birthDate,
    Gender? gender,
    String? email,
    String? phone,
  }) {
    return EditProfileState(
      storeLabel: storeLabel ?? this.storeLabel,
      roleLabel: roleLabel ?? this.roleLabel,
      fullName: fullName ?? this.fullName,
      fullNameKana: fullNameKana ?? this.fullNameKana,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }

  @override
  List<Object?> get props => [
        storeLabel,
        roleLabel,
        fullName,
        fullNameKana,
        birthDate,
        gender,
        email,
        phone,
      ];
}

