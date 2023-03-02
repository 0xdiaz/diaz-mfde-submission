part of 'watchlist_series_bloc.dart';

abstract class WatchlistSeriesEvent extends Equatable {
  const WatchlistSeriesEvent();
  // coverage:ignore-start
  @override
  List<Object?> get props => [];
  // coverage:ignore-end
}

class FetchWatchlistSeries extends WatchlistSeriesEvent {}
