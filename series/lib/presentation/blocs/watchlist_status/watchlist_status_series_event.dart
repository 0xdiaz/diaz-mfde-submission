part of 'watchlist_status_series_bloc.dart';

abstract class WatchlistStatusSeriesEvent extends Equatable {
  const WatchlistStatusSeriesEvent();
  // coverage:ignore-start
  @override
  List<Object?> get props => [];
  // coverage:ignore-end
}

class AddWatchlistSeries extends WatchlistStatusSeriesEvent {
  final SeriesDetail seriesDetail;

  const AddWatchlistSeries(this.seriesDetail);
  // coverage:ignore-start
  @override
  List<Object?> get props => [seriesDetail];
  // coverage:ignore-end
}

class RemoveFromWatchlistSeries extends WatchlistStatusSeriesEvent {
  final SeriesDetail seriesDetail;

  const RemoveFromWatchlistSeries(this.seriesDetail);
  // coverage:ignore-start
  @override
  List<Object?> get props => [seriesDetail];
  // coverage:ignore-end
}

class LoadWatchlistStatusSeries extends WatchlistStatusSeriesEvent {
  final int id;

  const LoadWatchlistStatusSeries(this.id);
  // coverage:ignore-start
  @override
  List<Object?> get props => [id];
  // coverage:ignore-end
}
