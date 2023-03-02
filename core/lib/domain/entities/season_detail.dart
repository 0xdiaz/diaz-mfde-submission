import 'package:core/domain/entities/episode.dart';
import 'package:equatable/equatable.dart';

class SeasonDetail extends Equatable {
  final String? airDate;
  final List<Episode> episodes;
  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;

  const SeasonDetail({
    required this.airDate,
    required this.episodes,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  @override
  List<Object?> get props {
    return [
      airDate,
      episodes,
      id,
      name,
      overview,
      posterPath,
      seasonNumber,
    ];
  }
}
