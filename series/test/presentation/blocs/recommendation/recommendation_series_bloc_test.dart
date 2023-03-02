import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/series.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/domain/usecases/get_series_recommendations.dart';
import 'package:series/presentation/blocs/recommendation/recommendation_series_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'recommendation_series_bloc_test.mocks.dart';

@GenerateMocks([GetSeriesRecommendations])
void main() {
  late RecommendationSeriesBloc recommendationSeriesBloc;
  late MockGetRecommendationSeries mockGetRecommendationSeries;

  setUp(() {
    mockGetRecommendationSeries = MockGetRecommendationSeries();
    recommendationSeriesBloc =
        RecommendationSeriesBloc(mockGetRecommendationSeries);
  });

  const tId = 1;
  final tSeriesList = <Series>[tSeries];

  test('initial state should be empty', () {
    expect(recommendationSeriesBloc.state, RecommendationSeriesEmpty());
  });

  blocTest<RecommendationSeriesBloc, RecommendationSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetRecommendationSeries.execute(tId))
          .thenAnswer((_) async => Right(tSeriesList));
      return recommendationSeriesBloc;
    },
    act: (bloc) => bloc.add(const FetchRecommendationSeries(tId)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      RecommendationSeriesLoading(),
      RecommendationSeriesHasData(tSeriesList),
    ],
    verify: (bloc) => verify(mockGetRecommendationSeries.execute(tId)),
  );

  blocTest<RecommendationSeriesBloc, RecommendationSeriesState>(
    'Should emit [Loading, Empty] when data is empty',
    build: () {
      when(mockGetRecommendationSeries.execute(tId))
          .thenAnswer((_) async => const Right([]));
      return recommendationSeriesBloc;
    },
    act: (bloc) => bloc.add(const FetchRecommendationSeries(tId)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      RecommendationSeriesLoading(),
      RecommendationSeriesEmpty(),
    ],
    verify: (bloc) => verify(mockGetRecommendationSeries.execute(tId)),
  );

  blocTest<RecommendationSeriesBloc, RecommendationSeriesState>(
    'Should emit [Loading, Error] when get recommendations  series is unsuccessful',
    build: () {
      when(mockGetRecommendationSeries.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return recommendationSeriesBloc;
    },
    act: (bloc) => bloc.add(const FetchRecommendationSeries(tId)),
    expect: () => [
      RecommendationSeriesLoading(),
      const RecommendationSeriesError('Server Failure'),
    ],
    verify: (bloc) => verify(mockGetRecommendationSeries.execute(tId)),
  );
}
