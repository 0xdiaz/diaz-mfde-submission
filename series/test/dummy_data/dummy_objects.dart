import 'package:core/data/models/series/episode_model.dart';
import 'package:core/data/models/genre_model.dart';
import 'package:core/data/models/series/season_detail_model.dart';
import 'package:core/data/models/series/season_model.dart';
import 'package:core/data/models/series/series_detail_model.dart';
import 'package:core/data/models/series/series_model.dart';
import 'package:core/data/models/series/series_table.dart';
import 'package:core/domain/entities/episode.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/season.dart';
import 'package:core/domain/entities/season_detail.dart';
import 'package:core/domain/entities/series.dart';
import 'package:core/domain/entities/series_detail.dart';

const tSeriesModel = SeriesModel(
  backdropPath: '/mUkuc2wyV9dHLG0D0Loaw5pO2s8.jpg',
  firstAirDate: '2011-04-17',
  genreIds: [10765, 10759, 18],
  id: 1399,
  name: 'Game of Thrones',
  originalLanguage: 'en',
  originalName: 'Game of Thrones',
  overview:
  'Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night\'s Watch, is all that stands between the realms of men and icy horrors beyond.',
  popularity: 29.780826,
  posterPath: '/jIhL6mlT7AblhbHJgEoiBIOUVl1.jpg',
  voteAverage: 7.91,
  voteCount: 1172,
);

const tSeries = Series(
  backdropPath: '/mUkuc2wyV9dHLG0D0Loaw5pO2s8.jpg',
  firstAirDate: '2011-04-17',
  genreIds: [10765, 10759, 18],
  id: 1399,
  name: 'Game of Thrones',
  overview:
      'Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night\'s Watch, is all that stands between the realms of men and icy horrors beyond.',
  originalLanguage: 'en',
  originalName: 'Game of Thrones',
  popularity: 29.780826,
  posterPath: '/jIhL6mlT7AblhbHJgEoiBIOUVl1.jpg',
  voteAverage: 7.91,
  voteCount: 1172,
);

const tSeriesResponse = SeriesDetailResponse(
  backdropPath: 'backdropPath',
  firstAirDate: '2022-10-10',
  genres: [GenreModel(id: 1, name: 'Drama')],
  homepage: 'https://google.com',
  id: 1,
  lastAirDate: '2022-10-10',
  name: 'name',
  numberOfEpisodes: 12,
  numberOfSeasons: 6,
  originalLanguage: 'originalLanguage',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 369.0,
  posterPath: 'posterPath',
  seasons: [
    SeasonModel(
      airDate: '2022-10-10',
      episodeCount: 15,
      id: 1,
      name: 'name',
      overview: 'overview',
      posterPath: 'posterPath',
      seasonNumber: 10,
    ),
  ],
  status: 'status',
  tagline: 'tagline',
  type: 'type',
  voteAverage: 8.3,
  voteCount: 1200,
);

const tSeriesDetail = SeriesDetail(
  backdropPath: 'backdropPath',
  firstAirDate: '2022-10-10',
  genres: [Genre(id: 1, name: 'Drama')],
  homepage: 'https://google.com',
  id: 1,
  lastAirDate: '2022-10-10',
  name: 'name',
  numberOfEpisodes: 12,
  numberOfSeasons: 6,
  originalLanguage: 'originalLanguage',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 369,
  posterPath: 'posterPath',
  seasons: [
    Season(
      airDate: '2022-10-10',
      episodeCount: 15,
      id: 1,
      name: 'name',
      overview: 'overview',
      posterPath: 'posterPath',
      seasonNumber: 10,
    ),
  ],
  status: 'status',
  tagline: 'tagline',
  type: 'type',
  voteAverage: 8.3,
  voteCount: 1200,
);

const tSeriesTable = SeriesTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

const tWatchlistSeries = Series.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

const tSeasonDetailResponse = SeasonDetailResponse(
  id: 1,
  airDate: '2020-10-10',
  episodes: [
    EpisodeModel(
      airDate: '2020-10-10',
      episodeNumber: 1,
      id: 1,
      name: 'name',
      overview: 'overview',
      productionCode: 'productionCode',
      seasonNumber: 1,
      stillPath: 'stillPath',
      voteAverage: 8.3,
      voteCount: 1500,
    )
  ],
  name: 'name',
  overview: 'overview',
  posterPath: 'posterPath',
  seasonNumber: 1,
);

const tSeasonDetail = SeasonDetail(
  id: 1,
  airDate: '2020-10-10',
  episodes: [
    Episode(
      airDate: '2020-10-10',
      episodeNumber: 1,
      id: 1,
      name: 'name',
      overview: 'overview',
      productionCode: 'productionCode',
      seasonNumber: 1,
      stillPath: 'stillPath',
      voteAverage: 8.3,
      voteCount: 1500,
    )
  ],
  name: 'name',
  overview: 'overview',
  posterPath: 'posterPath',
  seasonNumber: 1,
);
