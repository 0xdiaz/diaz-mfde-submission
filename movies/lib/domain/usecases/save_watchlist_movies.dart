import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/repositories/movie_repository.dart';

class SaveWatchlistMovies {
  final MovieRepository repository;

  SaveWatchlistMovies(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.saveWatchlist(movie);
  }
}
