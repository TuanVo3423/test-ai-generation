import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/use_cases/get_counter_use_case.dart';
import '../../domain/use_cases/increment_counter_use_case.dart';

part 'counter_event.dart';
part 'counter_state.dart';

@injectable
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc({
    required GetCounterUseCase getCounterUseCase,
    required IncrementCounterUseCase incrementCounterUseCase,
  })  : _getCounterUseCase = getCounterUseCase,
        _incrementCounterUseCase = incrementCounterUseCase,
        super(const CounterState.initial()) {
    on<CounterStarted>(_onStarted);
    on<CounterIncremented>(_onIncremented);
  }

  final GetCounterUseCase _getCounterUseCase;
  final IncrementCounterUseCase _incrementCounterUseCase;

  Future<void> _onStarted(
    CounterStarted event,
    Emitter<CounterState> emit,
  ) async {
    emit(
      _getCounterUseCase().when(
        success: (value) => CounterState.ready(value: value),
        failure: (failure) => CounterState.failure(message: failure.message),
      ),
    );
  }

  Future<void> _onIncremented(
    CounterIncremented event,
    Emitter<CounterState> emit,
  ) async {
    emit(
      _incrementCounterUseCase().when(
        success: (value) => CounterState.ready(value: value),
        failure: (failure) => CounterState.failure(message: failure.message),
      ),
    );
  }
}
