part of 'recommendation_series_bloc.dart';

abstract class RecommendationSeriesState extends Equatable {
  const RecommendationSeriesState();

  @override
  List<Object?> get props => [];
}

class RecommendationSeriesEmpty extends RecommendationSeriesState {}

class RecommendationSeriesLoading extends RecommendationSeriesState {}

class RecommendationSeriesError extends RecommendationSeriesState {
  final String message;

  const RecommendationSeriesError(this.message);

  @override
  List<Object?> get props => [message];
}

class RecommendationSeriesHasData extends RecommendationSeriesState {
  final List<Series> result;

  const RecommendationSeriesHasData(this.result);

  @override
  List<Object?> get props => [result];
}
