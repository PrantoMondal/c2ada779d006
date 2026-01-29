import 'package:device_vitals/src/features/history/data/models/history_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:device_vitals/src/features/history/data/datasources/history_remote_datasource.dart';
import 'package:device_vitals/src/features/history/data/repositories/history_repository_impl.dart';
import 'package:device_vitals/src/features/history/domain/entities/history_entity.dart';

class MockHistoryRemoteDataSource extends Mock
    implements HistoryRemoteDataSource {}

void main() {
  late HistoryRepositoryImpl repository;
  late MockHistoryRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockHistoryRemoteDataSource();
    repository = HistoryRepositoryImpl(mockRemoteDataSource);
  });

  test('getHistory returns list of HistoryEntity', () async {
    final fakeResponse = HistoryResponse(
      histories: [
        HistoryData(
          id: 1,
          deviceId: 'device_1',
          batteryLevel: 90,
          thermalValue: 2,
          memoryUsage: 40,
          timestamp: "2026-01-29T00:00:00.000Z",
        ),
      ],
    );

    when(() => mockRemoteDataSource.fetchHistory())
        .thenAnswer((_) async => fakeResponse);

    final result = await repository.getHistory();

    expect(result, isA<List<HistoryEntity>>());
    expect(result.length, 1);
    expect(result.first.deviceId, 'device_1');

    verify(() => mockRemoteDataSource.fetchHistory()).called(1);
  });
}
