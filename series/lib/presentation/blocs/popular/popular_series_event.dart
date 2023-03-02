part of 'popular_series_bloc.dart';

abstract class PopularSeriesEvent extends Equatable {
  const PopularSeriesEvent();
  // coverage:ignore-start
  @override
  List<Object?> get props => [];
  // coverage:ignore-end
}

class FetchPopularSeries extends PopularSeriesEvent {}
