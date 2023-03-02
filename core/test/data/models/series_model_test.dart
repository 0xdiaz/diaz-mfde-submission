import 'package:core/data/models/series/series_model.dart';
import 'package:core/domain/entities/series.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tSeriesModel = SeriesModel(
    posterPath: 'posterPath',
    popularity: 2.3,
    id: 1,
    backdropPath: 'backdropPath',
    voteAverage: 8.1,
    overview: 'overview',
    firstAirDate: 'firstAirDate',
    genreIds: [1, 2, 3],
    originalLanguage: 'originalLanguage',
    voteCount: 123,
    name: 'name',
    originalName: 'originalName',
  );

  const tSeries = Series(
    posterPath: 'posterPath',
    popularity: 2.3,
    id: 1,
    backdropPath: 'backdropPath',
    voteAverage: 8.1,
    overview: 'overview',
    firstAirDate: 'firstAirDate',
    genreIds: [1, 2, 3],
    originalLanguage: 'originalLanguage',
    voteCount: 123,
    name: 'name',
    originalName: 'originalName',
  );

  test('should be a subclass of  Series entity', () {
    final result = tSeriesModel.toEntity();
    expect(result, tSeries);
  });
}
