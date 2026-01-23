# Repositories & DTO Mapping Reference

## **Data Transfer Object (DTO)**

DTOs live in the **Infrastructure** layer and represent the raw JSON response.

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

## **Repository Implementation**

The implementation handles the actual data fetching (Remote/Local) and mapping.

```dart
class BankRepository implements IBankRepository {
  final BankRemoteDataSource remoteDataSource;

  BankRepository(this.remoteDataSource);

  @override
  Future<Result<List<Bank>>> fetchBanks() async {
    try {
      final dtoList = await remoteDataSource.getBanks();
      final banks = dtoList.map((dto) => dto.toDomain()).toList();
      return Success(banks);
    } catch (e) {
      return FailureResult(ApiFailure.fromException(e));
    }
  }
}
```
