import 'package:core/core.dart';
import 'package:core/domain/entities/season_detail.dart';
import 'package:core/domain/entities/series.dart';
import 'package:core/domain/entities/series_detail.dart';
import 'package:dartz/dartz.dart';

abstract class SeriesRepository {
  Future<Either<Failure, List<Series>>> getNowPlayingSeries();
  Future<Either<Failure, List<Series>>> getPopularSeries();
  Future<Either<Failure, List<Series>>> getTopRatedSeries();
  Future<Either<Failure, List<Series>>> searchSeries(String query);
  Future<Either<Failure, List<Series>>> getSeriesRecommendations(int id);
  Future<Either<Failure, SeriesDetail>> getSeriesDetail(int id);
  Future<Either<Failure, List<Series>>> getWatchlistSeries();
  Future<Either<Failure, String>> saveWatchlist(SeriesDetail series);
  Future<Either<Failure, String>> removeWatchlist(SeriesDetail series);
  Future<Either<Failure, SeasonDetail>> getSeasonDetail(
      int id,
      int seasonNumber,
      );
  Future<bool> isAddedToWatchlist(int id);
}
