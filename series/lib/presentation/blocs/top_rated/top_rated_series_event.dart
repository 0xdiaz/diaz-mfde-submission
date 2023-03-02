part of 'top_rated_series_bloc.dart';

abstract class TopRatedSeriesEvent extends Equatable {
  const TopRatedSeriesEvent();
  // coverage:ignore-start
  @override
  List<Object?> get props => [];
  // coverage:ignore-end
}

class FetchTopRatedSeries extends TopRatedSeriesEvent {}
