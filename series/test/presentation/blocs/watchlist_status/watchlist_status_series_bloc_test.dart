import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/domain/usecases/get_watchlist_series_status.dart';
import 'package:series/domain/usecases/remove_watchlist_series.dart';
import 'package:series/domain/usecases/save_watchlist_series.dart';
import 'package:series/presentation/blocs/watchlist_status/watchlist_status_series_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_status_series_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchListSeriesStatus,
  SaveWatchlistSeries,
  RemoveWatchlistSeries,
])
void main() {
  late WatchlistStatusSeriesBloc watchlistStatusSeriesBloc;
  late MockGetWatchListStatusSeries mockGetWatchListStatusSeries;
  late MockSaveWatchlistSeries mockSaveWatchlistSeries;
  late MockRemoveWatchlistSeries mockRemoveWatchlistSeries;

  setUp(() {
    mockGetWatchListStatusSeries = MockGetWatchListStatusSeries();
    mockSaveWatchlistSeries = MockSaveWatchlistSeries();
    mockRemoveWatchlistSeries = MockRemoveWatchlistSeries();
    watchlistStatusSeriesBloc = WatchlistStatusSeriesBloc(
      getWatchListStatusSeries: mockGetWatchListStatusSeries,
      saveWatchlistSeries: mockSaveWatchlistSeries,
      removeWatchlistSeries: mockRemoveWatchlistSeries,
    );
  });

  const tId = 1;

  group('Watchlist Status  Series', () {
    blocTest<WatchlistStatusSeriesBloc, WatchlistStatusSeriesState>(
      'Should emit [WatchlistStatusState] when get watchlist status true',
      build: () {
        when(mockGetWatchListStatusSeries.execute(tId))
            .thenAnswer((_) async => true);
        return watchlistStatusSeriesBloc;
      },
      act: (bloc) => bloc.add(const LoadWatchlistStatusSeries(tId)),
      expect: () => [
        const WatchlistStatusSeriesState(
            isAddedToWatchlist: true, message: ''),
      ],
    );
  });

  group('Save Watchlist  Series', () {
    blocTest<WatchlistStatusSeriesBloc, WatchlistStatusSeriesState>(
      'Should emit [WatchlistStatusState] when data is saved',
      build: () {
        when(mockSaveWatchlistSeries.execute(tSeriesDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        when(mockGetWatchListStatusSeries.execute(tId))
            .thenAnswer((_) async => true);
        return watchlistStatusSeriesBloc;
      },
      act: (bloc) => bloc.add(const AddWatchlistSeries(tSeriesDetail)),
      expect: () => [
        const WatchlistStatusSeriesState(
          isAddedToWatchlist: true,
          message: 'Added to Watchlist',
        ),
      ],
      verify: (bloc) => [
        verify(mockSaveWatchlistSeries.execute(tSeriesDetail)),
        verify(mockGetWatchListStatusSeries.execute(tId)),
      ],
    );

    blocTest<WatchlistStatusSeriesBloc, WatchlistStatusSeriesState>(
      'Should emit [WatchlistStatusState] when save data is unsuccessful',
      build: () {
        when(mockSaveWatchlistSeries.execute(tSeriesDetail)).thenAnswer(
            (_) async =>
                const Left(DatabaseFailure('Failed Added to Watchlist')));
        when(mockGetWatchListStatusSeries.execute(tId))
            .thenAnswer((_) async => false);
        return watchlistStatusSeriesBloc;
      },
      act: (bloc) => bloc.add(const AddWatchlistSeries(tSeriesDetail)),
      expect: () => [
        const WatchlistStatusSeriesState(
          isAddedToWatchlist: false,
          message: 'Failed Added to Watchlist',
        ),
      ],
      verify: (bloc) => [
        verify(mockSaveWatchlistSeries.execute(tSeriesDetail)),
        verify(mockGetWatchListStatusSeries.execute(tId)),
      ],
    );
  });

  group('Remove Watchlist  Series', () {
    blocTest<WatchlistStatusSeriesBloc, WatchlistStatusSeriesState>(
      'Should emit [WatchlistStatusState] when data is removed',
      build: () {
        when(mockRemoveWatchlistSeries.execute(tSeriesDetail))
            .thenAnswer((_) async => const Right('Removed from Watchlist'));
        when(mockGetWatchListStatusSeries.execute(tId))
            .thenAnswer((_) async => false);
        return watchlistStatusSeriesBloc;
      },
      act: (bloc) =>
          bloc.add(const RemoveFromWatchlistSeries(tSeriesDetail)),
      expect: () => [
        const WatchlistStatusSeriesState(
          isAddedToWatchlist: false,
          message: 'Removed from Watchlist',
        ),
      ],
      verify: (bloc) => [
        verify(mockRemoveWatchlistSeries.execute(tSeriesDetail)),
        verify(mockGetWatchListStatusSeries.execute(tId)),
      ],
    );

    blocTest<WatchlistStatusSeriesBloc, WatchlistStatusSeriesState>(
      'Should emit [WatchlistStatusState] when remove data is unsuccessful',
      build: () {
        when(mockRemoveWatchlistSeries.execute(tSeriesDetail)).thenAnswer(
            (_) async =>
                const Left(DatabaseFailure('Failed Removed from Watchlist')));
        when(mockGetWatchListStatusSeries.execute(tId))
            .thenAnswer((_) async => true);
        return watchlistStatusSeriesBloc;
      },
      act: (bloc) =>
          bloc.add(const RemoveFromWatchlistSeries(tSeriesDetail)),
      expect: () => [
        const WatchlistStatusSeriesState(
          isAddedToWatchlist: true,
          message: 'Failed Removed from Watchlist',
        ),
      ],
      verify: (bloc) => [
        verify(mockRemoveWatchlistSeries.execute(tSeriesDetail)),
        verify(mockGetWatchListStatusSeries.execute(tId)),
      ],
    );
  });
}
