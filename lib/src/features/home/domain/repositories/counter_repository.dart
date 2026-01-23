import '../../../../core/result/result.dart';

abstract interface class CounterRepository {
  Result<int> getCounter();
  Result<int> increment();
}
