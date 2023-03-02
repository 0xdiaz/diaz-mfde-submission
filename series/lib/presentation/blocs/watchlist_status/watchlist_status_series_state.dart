part of 'watchlist_status_series_bloc.dart';

class WatchlistStatusSeriesState extends Equatable {
  final bool isAddedToWatchlist;
  final String message;

  const WatchlistStatusSeriesState({
    required this.isAddedToWatchlist,
    required this.message,
  });

  @override
  List<Object?> get props => [isAddedToWatchlist, message];
}
