import 'package:core/data/models/genre_model.dart';
import 'package:core/data/models/series/season_model.dart';
import 'package:core/data/models/series/series_detail_model.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/season.dart';
import 'package:core/domain/entities/series_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tSeriesDetailModel = SeriesDetailResponse(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genres: [
      GenreModel(
        id: 1,
        name: 'name',
      ),
    ],
    homepage: 'homepage',
    id: 1,
    lastAirDate: 'lastAirDate',
    name: 'name',
    numberOfEpisodes: 12,
    numberOfSeasons: 5,
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 2.3,
    posterPath: 'posterPath',
    seasons: [
      SeasonModel(
        airDate: 'airDate',
        episodeCount: 12,
        id: 1,
        name: 'name',
        overview: 'overview',
        posterPath: 'posterPath',
        seasonNumber: 1,
      ),
    ],
    status: 'status',
    tagline: 'tagline',
    type: 'type',
    voteAverage: 2.3,
    voteCount: 1500,
  );

  const tSeriesDetail = SeriesDetail(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genres: [
      Genre(
        id: 1,
        name: 'name',
      ),
    ],
    homepage: 'homepage',
    id: 1,
    lastAirDate: 'lastAirDate',
    name: 'name',
    numberOfEpisodes: 12,
    numberOfSeasons: 5,
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 2.3,
    posterPath: 'posterPath',
    seasons: [
      Season(
        airDate: 'airDate',
        episodeCount: 12,
        id: 1,
        name: 'name',
        overview: 'overview',
        posterPath: 'posterPath',
        seasonNumber: 1,
      ),
    ],
    status: 'status',
    tagline: 'tagline',
    type: 'type',
    voteAverage: 2.3,
    voteCount: 1500,
  );

  const tSeriesDetailJson = {
    'backdrop_path': 'backdropPath',
    'first_air_date': 'firstAirDate',
    'genres': [
      {
        'id': 1,
        'name': 'name',
      },
    ],
    'homepage': 'homepage',
    'id': 1,
    'in_production': true,
    'languages': ['en'],
    'last_air_date': 'lastAirDate',
    'name': 'name',
    'number_of_episodes': 12,
    'number_of_seasons': 5,
    'origin_country': ['en'],
    'original_language': 'originalLanguage',
    'original_name': 'originalName',
    'overview': 'overview',
    'popularity': 2.3,
    'poster_path': 'posterPath',
    'seasons': [
      {
        'air_date': 'airDate',
        'episode_count': 12,
        'id': 1,
        'name': 'name',
        'overview': 'overview',
        'poster_path': 'posterPath',
        'season_number': 1,
      },
    ],
    'status': 'status',
    'tagline': 'tagline',
    'type': 'type',
    'vote_average': 2.3,
    'vote_count': 1500,
  };

  test('should be a subclass of  Series Detail entity', () {
    final result = tSeriesDetailModel.toEntity();
    expect(result, tSeriesDetail);
  });

  test('should be a subclass of  Series Detail json', () {
    final result = tSeriesDetailModel.toJson();
    expect(result, tSeriesDetailJson);
  });
}
