part of 'watchlist_series_bloc.dart';

abstract class WatchlistSeriesState extends Equatable {
  const WatchlistSeriesState();

  @override
  List<Object?> get props => [];
}

class WatchlistSeriesEmpty extends WatchlistSeriesState {}

class WatchlistSeriesLoading extends WatchlistSeriesState {}

class WatchlistSeriesError extends WatchlistSeriesState {
  final String message;

  const WatchlistSeriesError(this.message);

  @override
  List<Object?> get props => [message];
}

class WatchlistSeriesHasData extends WatchlistSeriesState {
  final List<Series> result;

  const WatchlistSeriesHasData(this.result);

  @override
  List<Object?> get props => [result];
}
