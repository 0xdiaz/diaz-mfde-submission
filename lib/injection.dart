import 'package:core/core.dart';
import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/movies/movie_local_data_source.dart';
import 'package:core/data/datasources/movies/movie_remote_data_source.dart';
import 'package:core/data/datasources/series/series_local_data_source.dart';
import 'package:core/data/datasources/series/series_remote_data_source.dart';
import 'package:core/data/repositories/movie_repository_impl.dart';
import 'package:core/data/repositories/series_repository_impl.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/repositories/series_repository.dart';
import 'package:movies/domain/usecases/get_movie_detail.dart';
import 'package:movies/domain/usecases/get_movie_recommendations.dart';
import 'package:movies/domain/usecases/get_now_playing_movies.dart';
import 'package:movies/domain/usecases/get_popular_movies.dart';
import 'package:movies/domain/usecases/get_top_rated_movies.dart';
import 'package:movies/domain/usecases/get_watchlist_movies.dart';
import 'package:movies/domain/usecases/get_watchlist_movies_status.dart';
import 'package:movies/domain/usecases/remove_watchlist_movies.dart';
import 'package:movies/domain/usecases/save_watchlist_movies.dart';
import 'package:movies/domain/usecases/search_movies.dart';
import 'package:movies/presentation/blocs/detail/detail_movie_bloc.dart';
import 'package:movies/presentation/blocs/now_playing/now_playing_movies_bloc.dart';
import 'package:movies/presentation/blocs/popular/popular_movies_bloc.dart';
import 'package:movies/presentation/blocs/search/search_movies_bloc.dart';
import 'package:movies/presentation/blocs/top_rated/top_rated_movies_bloc.dart';
import 'package:movies/presentation/blocs/watchlist/watchlist_movies_bloc.dart';
import 'package:series/domain/usecases/get_now_playing_series.dart';
import 'package:series/domain/usecases/get_popular_series.dart';
import 'package:series/domain/usecases/get_series_detail.dart';
import 'package:series/domain/usecases/get_series_recommendations.dart';
import 'package:series/domain/usecases/get_top_rated_series.dart';
import 'package:series/domain/usecases/get_watchlist_series.dart';
import 'package:series/domain/usecases/get_watchlist_series_status.dart';
import 'package:series/domain/usecases/remove_watchlist_series.dart';
import 'package:series/domain/usecases/save_watchlist_series.dart';
import 'package:series/domain/usecases/search_series.dart';
import 'package:series/presentation/blocs/detail/detail_series_bloc.dart';
import 'package:series/presentation/blocs/now_playing/now_playing_series_bloc.dart';
import 'package:series/presentation/blocs/popular/popular_series_bloc.dart';
import 'package:series/presentation/blocs/recommendation/recommendation_series_bloc.dart';
import 'package:series/presentation/blocs/search/search_series_bloc.dart';
import 'package:series/presentation/blocs/season_detail/season_detail_bloc.dart';
import 'package:series/presentation/blocs/top_rated/top_rated_series_bloc.dart';
import 'package:series/presentation/blocs/watchlist/watchlist_series_bloc.dart';
import 'package:series/presentation/blocs/watchlist_status/watchlist_status_series_bloc.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // movie bloc
  locator.registerFactory(() => NowPlayingMoviesBloc(locator()));
  locator.registerFactory(() => PopularMoviesBloc(locator()));
  locator.registerFactory(() => TopRatedMoviesBloc(locator()));
  locator.registerFactory(() => WatchlistMoviesBloc(locator()));
  locator.registerFactory(() => SearchMoviesBloc(locator()));
  locator.registerFactory(
        () => DetailMovieBloc(
      getDetailMovie: locator(),
      getRecommendationMovies: locator(),
      saveWatchlistMovie: locator(),
      removeWatchlistMovie: locator(),
      getWatchListStatusMovie: locator(),
    ),
  );

  // bloc tv series
  locator.registerFactory(() => NowPlayingSeriesBloc(locator()));
  locator.registerFactory(() => PopularSeriesBloc(locator()));
  locator.registerFactory(() => TopRatedSeriesBloc(locator()));
  locator.registerFactory(() => DetailSeriesBloc(locator()));
  locator.registerFactory(() => SeasonDetailBloc(locator()));
  locator.registerFactory(() => RecommendationSeriesBloc(locator()));
  locator.registerFactory(
        () => WatchlistStatusSeriesBloc(
      getWatchListStatusSeries: locator(),
      removeWatchlistSeries: locator(),
      saveWatchlistSeries: locator(),
    ),
  );
  locator.registerFactory(() => WatchlistSeriesBloc(locator()));
  locator.registerFactory(() => SearchSeriesBloc(locator()));

  // movie use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListMoviesStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlistMovies(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistMovies(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // series use case
  locator.registerLazySingleton(() => GetNowPlayingSeries(locator()));
  locator.registerLazySingleton(() => GetPopularSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedSeries(locator()));
  locator.registerLazySingleton(() => GetSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => SearchSeries(locator()));
  locator.registerLazySingleton(() => GetWatchListSeriesStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlistSeries(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistSeries(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<SeriesRepository>(
    () => SeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<SeriesRemoteDataSource>(
      () => SeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<SeriesLocalDataSource>(
      () => SeriesLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => HttpSSLPinning.client);
}
