import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/series.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/domain/usecases/get_popular_series.dart';
import 'package:series/presentation/blocs/popular/popular_series_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'popular_series_bloc_test.mocks.dart';

@GenerateMocks([GetPopularSeries])
void main() {
  late PopularSeriesBloc popularSeriesBloc;
  late MockGetPopularSeries mockGetPopularSeries;

  setUp(() {
    mockGetPopularSeries = MockGetPopularSeries();
    popularSeriesBloc = PopularSeriesBloc(mockGetPopularSeries);
  });

  final tSeriesList = <Series>[tSeries];

  test('initial state should be empty', () {
    expect(popularSeriesBloc.state, PopularSeriesEmpty());
  });

  blocTest<PopularSeriesBloc, PopularSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetPopularSeries.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      return popularSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchPopularSeries()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      PopularSeriesLoading(),
      PopularSeriesHasData(tSeriesList),
    ],
    verify: (bloc) => verify(mockGetPopularSeries.execute()),
  );

  blocTest<PopularSeriesBloc, PopularSeriesState>(
    'Should emit [Loading, Error] when get popular  series is unsuccessful',
    build: () {
      when(mockGetPopularSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return popularSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchPopularSeries()),
    expect: () => [
      PopularSeriesLoading(),
      const PopularSeriesError('Server Failure'),
    ],
    verify: (bloc) => verify(mockGetPopularSeries.execute()),
  );
}
