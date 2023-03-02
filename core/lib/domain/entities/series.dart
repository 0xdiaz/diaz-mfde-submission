import 'package:equatable/equatable.dart';

class Series extends Equatable {
  const Series({
    required this.backdropPath,
    required this.firstAirDate,
    required this.genreIds,
    required this.id,
    required this.name,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  const Series.watchlist({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    this.backdropPath,
    this.firstAirDate,
    this.genreIds,
    this.originalLanguage,
    this.originalName,
    this.popularity,
    this.voteAverage,
    this.voteCount,
  });

  final String? backdropPath;
  final String? firstAirDate;
  final List<int>? genreIds;
  final int id;
  final String? name;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final double? voteAverage;
  final int? voteCount;

  @override
  List<Object?> get props => [
        backdropPath,
        firstAirDate,
        genreIds,
        id,
        name,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        voteAverage,
        voteCount,
      ];
}
