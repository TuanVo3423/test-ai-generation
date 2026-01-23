import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/result/result.dart';
import '../../domain/repositories/counter_repository.dart';
import '../data_sources/counter_local_data_source.dart';

@LazySingleton(as: CounterRepository)
class CounterRepositoryImpl implements CounterRepository {
  const CounterRepositoryImpl(this._localDataSource);

  final CounterLocalDataSource _localDataSource;

  @override
  Result<int> getCounter() {
    try {
      return Success<int>(_localDataSource.getCounter());
    } catch (e) {
      return Failed<int>(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Result<int> increment() {
    try {
      return Success<int>(_localDataSource.increment());
    } catch (e) {
      return Failed<int>(UnknownFailure(message: e.toString()));
    }
  }
}
