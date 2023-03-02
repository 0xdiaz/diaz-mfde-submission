import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/series.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/domain/usecases/search_series.dart';
import 'package:series/presentation/blocs/search/search_series_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'search_series_bloc_test.mocks.dart';

@GenerateMocks([SearchSeries])
void main() {
  late SearchSeriesBloc searchSeriesBloc;
  late MockSearchSeries mockSearchSeries;

  setUp(() {
    mockSearchSeries = MockSearchSeries();
    searchSeriesBloc = SearchSeriesBloc(mockSearchSeries);
  });

  test('initial state should be empty', () {
    expect(searchSeriesBloc.state, SearchSeriesInitial());
  });

  final tSeriesList = <Series>[tSeries];
  const tQuery = 'spiderman';

  blocTest<SearchSeriesBloc, SearchSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchSeries.execute(tQuery))
          .thenAnswer((_) async => Right(tSeriesList));
      return searchSeriesBloc;
    },
    act: (bloc) => bloc.add(const SearchSeriesOnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchSeriesLoading(),
      SearchSeriesHasData(tSeriesList),
    ],
    verify: (bloc) => verify(mockSearchSeries.execute(tQuery)),
  );

  blocTest<SearchSeriesBloc, SearchSeriesState>(
    'Should emit [Loading, Empty] when data is empty',
    build: () {
      when(mockSearchSeries.execute(tQuery))
          .thenAnswer((_) async => const Right([]));
      return searchSeriesBloc;
    },
    act: (bloc) => bloc.add(const SearchSeriesOnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchSeriesLoading(),
      SearchSeriesEmpty(),
    ],
    verify: (bloc) => verify(mockSearchSeries.execute(tQuery)),
  );

  blocTest<SearchSeriesBloc, SearchSeriesState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchSeries.execute(tQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return searchSeriesBloc;
    },
    act: (bloc) => bloc.add(const SearchSeriesOnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchSeriesLoading(),
      const SearchSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchSeries.execute(tQuery));
    },
  );
}
