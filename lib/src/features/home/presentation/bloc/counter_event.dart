part of 'counter_bloc.dart';

sealed class CounterEvent extends Equatable {
  const CounterEvent();

  @override
  List<Object?> get props => const <Object?>[];
}

final class CounterStarted extends CounterEvent {
  const CounterStarted();
}

final class CounterIncremented extends CounterEvent {
  const CounterIncremented();
}

