import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series/domain/usecases/get_season_detail.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockSeriesRepository mockTvSeriesRepository;
  late GetSeasonDetail usecase;

  setUp(() {
    mockTvSeriesRepository = MockSeriesRepository();
    usecase = GetSeasonDetail(mockTvSeriesRepository);
  });

  const tId = 1;
  const tSeasonNumber = 1;

  test('should get list of now playing tv series from the repository',
      () async {
    // arrange
    when(mockTvSeriesRepository.getSeasonDetail(tId, tSeasonNumber))
        .thenAnswer((_) async => const Right(tSeasonDetail));
    // act
    final result = await usecase.execute(tId, tSeasonNumber);
    // assert
    expect(result, const Right(tSeasonDetail));
  });
}
