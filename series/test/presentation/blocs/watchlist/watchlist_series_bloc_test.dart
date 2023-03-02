import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/series.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/domain/usecases/get_watchlist_series.dart';
import 'package:series/presentation/blocs/watchlist/watchlist_series_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_series_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistSeries])
void main() {
  late WatchlistSeriesBloc watchlistSeriesBloc;
  late MockGetWatchlistSeries mockGetWatchlistSeries;

  setUp(() {
    mockGetWatchlistSeries = MockGetWatchlistSeries();
    watchlistSeriesBloc = WatchlistSeriesBloc(mockGetWatchlistSeries);
  });

  final tWatchlistSeriesList = <Series>[tWatchlistSeries];

  test('initial state should be empty', () {
    expect(watchlistSeriesBloc.state, WatchlistSeriesEmpty());
  });

  blocTest<WatchlistSeriesBloc, WatchlistSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistSeries.execute())
          .thenAnswer((_) async => Right(tWatchlistSeriesList));
      return watchlistSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistSeries()),
    expect: () => [
      WatchlistSeriesLoading(),
      WatchlistSeriesHasData(tWatchlistSeriesList),
    ],
    verify: (bloc) => verify(mockGetWatchlistSeries.execute()),
  );

  blocTest<WatchlistSeriesBloc, WatchlistSeriesState>(
    'Should emit [Loading, Empty] when data is empty',
    build: () {
      when(mockGetWatchlistSeries.execute())
          .thenAnswer((_) async => const Right([]));
      return watchlistSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistSeries()),
    expect: () => [
      WatchlistSeriesLoading(),
      WatchlistSeriesEmpty(),
    ],
    verify: (bloc) => verify(mockGetWatchlistSeries.execute()),
  );

  blocTest<WatchlistSeriesBloc, WatchlistSeriesState>(
    'Should emit [Loading, Error] when get watchlist  series is unsuccessful',
    build: () {
      when(mockGetWatchlistSeries.execute()).thenAnswer(
          (_) async => const Left(DatabaseFailure('Database Failure')));
      return watchlistSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistSeries()),
    expect: () => [
      WatchlistSeriesLoading(),
      const WatchlistSeriesError('Database Failure'),
    ],
    verify: (bloc) => verify(mockGetWatchlistSeries.execute()),
  );
}
