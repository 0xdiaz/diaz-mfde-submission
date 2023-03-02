import 'package:core/data/datasources/series/series_local_data_source.dart';
import 'package:core/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/series/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SeriesLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = SeriesLocalDataSourceImpl(
      databaseHelper: mockDatabaseHelper,
    );
  });

  group('Save Watchlist TV Series', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlistSeries(tSeriesTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlist(tSeriesTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlistSeries(tSeriesTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlist(tSeriesTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Remove Watchlist TV Series', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlistSeries(tSeriesTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlist(tSeriesTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlistSeries(tSeriesTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlist(tSeriesTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Watchlist TV Series By Id', () {
    const tId = 1;

    test('should return  Series Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getSeriesById(tId))
          .thenAnswer((_) async => tSeriesMap);
      // act
      final result = await dataSource.getSeriesById(tId);
      // assert
      expect(result, tSeriesTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getSeriesById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await dataSource.getSeriesById(tId);
      // assert
      expect(result, null);
    });
  });

  group('Get Watchlist  Series', () {
    test('should return list of SeriesTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistSeries())
          .thenAnswer((_) async => [tSeriesMap]);
      // act
      final result = await dataSource.getWatchlistSeries();
      // assert
      expect(result, [tSeriesTable]);
    });
  });
}
