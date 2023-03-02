import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/domain/usecases/get_series_detail.dart';
import 'package:series/presentation/blocs/detail/detail_series_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'detail_series_bloc_test.mocks.dart';

@GenerateMocks([GetSeriesDetail])
void main() {
  late DetailSeriesBloc detailSeriesBloc;
  late MockGetDetailSeries mockGetDetailSeries;

  setUp(() {
    mockGetDetailSeries = MockGetDetailSeries();
    detailSeriesBloc = DetailSeriesBloc(mockGetDetailSeries);
  });

  const tId = 1;

  test('initial state should be empty', () {
    expect(detailSeriesBloc.state, DetailSeriesEmpty());
  });

  blocTest<DetailSeriesBloc, DetailSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetDetailSeries.execute(tId))
          .thenAnswer((_) async => const Right(tSeriesDetail));
      return detailSeriesBloc;
    },
    act: (bloc) => bloc.add(const FetchDetailSeries(tId)),
    expect: () => [
      DetailSeriesLoading(),
      const DetailSeriesHasData(tSeriesDetail),
    ],
    verify: (bloc) => verify(mockGetDetailSeries.execute(tId)),
  );

  blocTest<DetailSeriesBloc, DetailSeriesState>(
    'Should emit [Loading, Error] when get detail  series is unsuccessful',
    build: () {
      when(mockGetDetailSeries.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return detailSeriesBloc;
    },
    act: (bloc) => bloc.add(const FetchDetailSeries(tId)),
    expect: () => [
      DetailSeriesLoading(),
      const DetailSeriesError('Server Failure'),
    ],
    verify: (bloc) => verify(mockGetDetailSeries.execute(tId)),
  );
}
