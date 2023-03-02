import 'package:dartz/dartz.dart';
import 'package:series/domain/usecases/remove_watchlist_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlistSeries usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = RemoveWatchlistSeries(mockSeriesRepository);
  });

  test('should remove watchlist  series from repository', () async {
    // arrange
    when(mockSeriesRepository.removeWatchlist(tSeriesDetail))
        .thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(tSeriesDetail);
    // assert
    verify(mockSeriesRepository.removeWatchlist(tSeriesDetail));
    expect(result, const Right('Removed from watchlist'));
  });
}
