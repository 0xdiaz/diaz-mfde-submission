part of 'detail_series_bloc.dart';

abstract class DetailSeriesState extends Equatable {
  const DetailSeriesState();

  @override
  List<Object?> get props => [];
}

class DetailSeriesEmpty extends DetailSeriesState {}

class DetailSeriesLoading extends DetailSeriesState {}

class DetailSeriesError extends DetailSeriesState {
  final String message;

  const DetailSeriesError(this.message);

  @override
  List<Object?> get props => [message];
}

class DetailSeriesHasData extends DetailSeriesState {
  final SeriesDetail result;

  const DetailSeriesHasData(this.result);

  @override
  List<Object?> get props => [result];
}
