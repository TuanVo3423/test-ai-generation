part of 'counter_bloc.dart';

enum CounterStatus { initial, ready, failure }

class CounterState extends Equatable {
  const CounterState({
    required this.status,
    required this.value,
    required this.message,
  });

  const CounterState.initial()
      : status = CounterStatus.initial,
        value = 0,
        message = '';

  const CounterState.ready({required this.value})
      : status = CounterStatus.ready,
        message = '';

  const CounterState.failure({required this.message})
      : status = CounterStatus.failure,
        value = 0;

  final CounterStatus status;
  final int value;
  final String message;

  @override
  List<Object?> get props => <Object?>[status, value, message];
}
