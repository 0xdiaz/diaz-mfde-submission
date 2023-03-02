import 'package:dartz/dartz.dart';
import 'package:series/domain/usecases/get_watchlist_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistSeries usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = GetWatchlistSeries(mockSeriesRepository);
  });

  final tSeriesList = [tSeries];

  test('should get list of  series from the repository', () async {
    // arrange
    when(mockSeriesRepository.getWatchlistSeries())
        .thenAnswer((_) async => Right(tSeriesList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tSeriesList));
  });
}
