# Reference: Layer-based Clean Architecture Examples

## **Full Layer Implementation**

### 1. Domain Layer (Entity)

```dart
class Bank {
  final String id;
  final String name;
  final String branchCode;

  const Bank({
    required this.id,
    required this.name,
    required this.branchCode,
  });
}
```

### 2. Infrastructure Layer (DTO & Mapper)

```dart
class BankDto {
  final String id;
  final String name;
  final String branchCode;

  const BankDto({
    required this.id,
    required this.name,
    required this.branchCode,
  });

  factory BankDto.fromJson(Map<String, dynamic> json) => BankDto(
        id: json['bank_id'] as String,
        name: json['bank_name'] as String,
        branchCode: json['code'] as String,
      );

  Bank toDomain() => Bank(id: id, name: name, branchCode: branchCode);
}
```

### 3. Application Layer (BLoC)

```dart
class BankBloc extends Bloc<BankEvent, BankState> {
  final IBankRepository repository;

  BankBloc(this.repository) : super(const BankState.initial()) {
    on<BankFetchRequested>(_onFetch);
  }

  Future<void> _onFetch(
    BankFetchRequested event,
    Emitter<BankState> emit,
  ) async {
    emit(state.copyWith(status: BankStatus.loading));
    final result = await repository.fetchBanks();

    switch (result) {
      case Success(value: final banks):
        emit(state.copyWith(status: BankStatus.loaded, banks: banks));
      case FailureResult(failure: final failure):
        emit(state.copyWith(status: BankStatus.failure, message: failure.message));
    }
  }
}
```

### 4. Shared Types (Result, Event, State)

```dart
sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  final T value;
  const Success(this.value);
}

class FailureResult<T> extends Result<T> {
  final Failure failure;
  const FailureResult(this.failure);
}

class Failure {
  final String message;
  const Failure(this.message);
}

abstract class BankEvent extends Equatable {
  const BankEvent();
  @override
  List<Object?> get props => [];
}

class BankFetchRequested extends BankEvent {
  const BankFetchRequested();
}

enum BankStatus { initial, loading, loaded, failure }

class BankState extends Equatable {
  final BankStatus status;
  final List<Bank> banks;
  final String? message;

  const BankState({
    required this.status,
    this.banks = const [],
    this.message,
  });

  const BankState.initial() : this(status: BankStatus.initial);

  BankState copyWith({
    BankStatus? status,
    List<Bank>? banks,
    String? message,
  }) {
    return BankState(
      status: status ?? this.status,
      banks: banks ?? this.banks,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, banks, message];
}
```
