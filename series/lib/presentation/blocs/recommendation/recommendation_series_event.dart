part of 'recommendation_series_bloc.dart';

abstract class RecommendationSeriesEvent extends Equatable {
  const RecommendationSeriesEvent();
  // coverage:ignore-start
  @override
  List<Object?> get props => [];
  // coverage:ignore-end
}

class FetchRecommendationSeries extends RecommendationSeriesEvent {
  final int id;

  const FetchRecommendationSeries(this.id);
  // coverage:ignore-start
  @override
  List<Object?> get props => [id];
  // coverage:ignore-end
}
