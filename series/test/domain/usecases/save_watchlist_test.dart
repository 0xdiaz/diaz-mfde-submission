import 'package:dartz/dartz.dart';
import 'package:series/domain/usecases/save_watchlist_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistSeries usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = SaveWatchlistSeries(mockSeriesRepository);
  });

  test('should save  series to the repository', () async {
    // arrange
    when(mockSeriesRepository.saveWatchlist(tSeriesDetail))
        .thenAnswer((_) async => const Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(tSeriesDetail);
    // assert
    verify(mockSeriesRepository.saveWatchlist(tSeriesDetail));
    expect(result, const Right('Added to Watchlist'));
  });
}
