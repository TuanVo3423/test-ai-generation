import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../../features/home/data/data_sources/counter_local_data_source.dart';
import '../../features/home/data/repositories/counter_repository_impl.dart';
import '../../features/home/domain/repositories/counter_repository.dart';
import '../../features/home/domain/use_cases/get_counter_use_case.dart';
import '../../features/home/domain/use_cases/increment_counter_use_case.dart';
import '../../features/home/presentation/bloc/counter_bloc.dart';

@pragma('vm:prefer-inline')
Future<GetIt> $initGetIt(
  GetIt getIt, {
  String? environment,
  EnvironmentFilter? environmentFilter,
}) async {
  getIt
    ..registerLazySingleton<CounterLocalDataSource>(CounterLocalDataSource.new)
    ..registerLazySingleton<CounterRepository>(
      () => CounterRepositoryImpl(getIt.get<CounterLocalDataSource>()),
    )
    ..registerLazySingleton<GetCounterUseCase>(
      () => GetCounterUseCase(getIt.get<CounterRepository>()),
    )
    ..registerLazySingleton<IncrementCounterUseCase>(
      () => IncrementCounterUseCase(getIt.get<CounterRepository>()),
    )
    ..registerFactory<CounterBloc>(
      () => CounterBloc(
        getCounterUseCase: getIt.get<GetCounterUseCase>(),
        incrementCounterUseCase: getIt.get<IncrementCounterUseCase>(),
      ),
    );
  return getIt;
}

extension GetItInjectableX on GetIt {
  Future<GetIt> init({
    String? environment,
    EnvironmentFilter? environmentFilter,
  }) {
    return $initGetIt(
      this,
      environment: environment,
      environmentFilter: environmentFilter,
    );
  }
}
