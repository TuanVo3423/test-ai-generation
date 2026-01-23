import '../error/failure.dart';

sealed class Result<T> {
  const Result();

  R when<R>({
    required R Function(T data) success,
    required R Function(Failure failure) failure,
  });
}

final class Success<T> extends Result<T> {
  const Success(this.data);

  final T data;

  @override
  R when<R>({
    required R Function(T data) success,
    required R Function(Failure failure) failure,
  }) {
    return success(data);
  }
}

final class Failed<T> extends Result<T> {
  const Failed(this.failureValue);

  final Failure failureValue;

  @override
  R when<R>({
    required R Function(T data) success,
    required R Function(Failure failure) failure,
  }) {
    return failure(failureValue);
  }
}

