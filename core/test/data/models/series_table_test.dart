import 'package:core/data/models/series/series_table.dart';
import 'package:core/domain/entities/series.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tSeriesTable = SeriesTable(
    id: 1,
    name: 'name',
    posterPath: 'posterPath',
    overview: 'overview',
  );

  const tSeriesWatchlist = Series.watchlist(
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
  );

  const tSeriesJson = {
    'id': 1,
    'name': 'name',
    'posterPath': 'posterPath',
    'overview': 'overview',
  };

  test('should be a subclass of SeriesTable entity', () async {
    final result = tSeriesTable.toEntity();
    expect(result, tSeriesWatchlist);
  });

  test('should be a subclass of SeriesTable json', () async {
    final result = tSeriesTable.toJson();
    expect(result, tSeriesJson);
  });
}
