import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/series.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/domain/usecases/get_now_playing_series.dart';
import 'package:series/presentation/blocs/now_playing/now_playing_series_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'now_playing_series_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingSeries])
void main() {
  late NowPlayingSeriesBloc nowPlayingSeriesBloc;
  late MockGetNowPlayingSeries mockGetNowPlayingSeries;

  setUp(() {
    mockGetNowPlayingSeries = MockGetNowPlayingSeries();
    nowPlayingSeriesBloc = NowPlayingSeriesBloc(mockGetNowPlayingSeries);
  });

  test('initial state should be empty', () {
    expect(nowPlayingSeriesBloc.state, NowPlayingSeriesEmpty());
  });

  final tSeriesList = <Series>[tSeries];

  blocTest<NowPlayingSeriesBloc, NowPlayingSeriesState>(
    'Should emit [Loading, HasData] when data is gotten succesfully',
    build: () {
      when(mockGetNowPlayingSeries.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      return nowPlayingSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingSeries()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      NowPlayingSeriesLoading(),
      NowPlayingSeriesHasData(tSeriesList),
    ],
    verify: (bloc) => verify(mockGetNowPlayingSeries.execute()),
  );

  blocTest<NowPlayingSeriesBloc, NowPlayingSeriesState>(
    'Should emit [Loading, Error] when get now playing  series is unsuccessful',
    build: () {
      when(mockGetNowPlayingSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return nowPlayingSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingSeries()),
    expect: () => [
      NowPlayingSeriesLoading(),
      const NowPlayingSeriesError('Server Failure'),
    ],
    verify: (bloc) => verify(mockGetNowPlayingSeries.execute()),
  );
}
