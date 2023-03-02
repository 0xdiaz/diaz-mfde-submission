import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/series.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/domain/usecases/get_top_rated_series.dart';
import 'package:series/presentation/blocs/top_rated/top_rated_series_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'top_rated_series_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedSeries])
void main() {
  late TopRatedSeriesBloc topRatedSeriesBloc;
  late MockGetTopRatedSeries mockGetTopRatedSeries;

  setUp(() {
    mockGetTopRatedSeries = MockGetTopRatedSeries();
    topRatedSeriesBloc = TopRatedSeriesBloc(mockGetTopRatedSeries);
  });

  final tSeriesList = <Series>[tSeries];

  test('initial state should be empty', () {
    expect(topRatedSeriesBloc.state, TopRatedSeriesEmpty());
  });

  blocTest<TopRatedSeriesBloc, TopRatedSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedSeries.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      return topRatedSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedSeries()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      TopRatedSeriesLoading(),
      TopRatedSeriesHasData(tSeriesList),
    ],
    verify: (bloc) => verify(mockGetTopRatedSeries.execute()),
  );

  blocTest<TopRatedSeriesBloc, TopRatedSeriesState>(
    'Should emit [Loading, Error] when get top rated  series is unsuccessful',
    build: () {
      when(mockGetTopRatedSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return topRatedSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedSeries()),
    expect: () => [
      TopRatedSeriesLoading(),
      const TopRatedSeriesError('Server Failure'),
    ],
    verify: (bloc) => verify(mockGetTopRatedSeries.execute()),
  );
}
