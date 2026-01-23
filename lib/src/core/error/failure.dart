import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  const Failure({required this.message});

  final String message;

  @override
  List<Object?> get props => <Object?>[message];
}

final class UnknownFailure extends Failure {
  const UnknownFailure({required super.message});
}

