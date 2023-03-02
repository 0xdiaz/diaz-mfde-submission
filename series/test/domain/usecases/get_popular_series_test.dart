import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/series.dart';
import 'package:series/domain/usecases/get_popular_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockSeriesRepository mockSeriesRepository;
  late GetPopularSeries usecase;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = GetPopularSeries(mockSeriesRepository);
  });

  final tSeries = <Series>[];

  test('should get list of popular tv series from the repository', () async {
    // arrange
    when(mockSeriesRepository.getPopularSeries())
        .thenAnswer((_) async => Right(tSeries));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tSeries));
  });
}
