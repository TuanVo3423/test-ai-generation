import 'package:injectable/injectable.dart';

import '../../../../core/result/result.dart';
import '../repositories/counter_repository.dart';

@lazySingleton
class GetCounterUseCase {
  const GetCounterUseCase(this._repository);

  final CounterRepository _repository;

  Result<int> call() => _repository.getCounter();
}
