import 'package:core/domain/entities/series_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series/domain/usecases/get_watchlist_series_status.dart';
import 'package:series/domain/usecases/remove_watchlist_series.dart';
import 'package:series/domain/usecases/save_watchlist_series.dart';

part 'watchlist_status_series_event.dart';
part 'watchlist_status_series_state.dart';

class WatchlistStatusSeriesBloc
    extends Bloc<WatchlistStatusSeriesEvent, WatchlistStatusSeriesState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetWatchListSeriesStatus getWatchListStatusSeries;
  final SaveWatchlistSeries saveWatchlistSeries;
  final RemoveWatchlistSeries removeWatchlistSeries;

  WatchlistStatusSeriesBloc({
    required this.getWatchListStatusSeries,
    required this.saveWatchlistSeries,
    required this.removeWatchlistSeries,
  }) : super(const WatchlistStatusSeriesState(
            isAddedToWatchlist: false, message: '')) {
    on<AddWatchlistSeries>((event, emit) async {
      final seriesDetail = event.seriesDetail;
      final id = seriesDetail.id;

      final result = await saveWatchlistSeries.execute(seriesDetail);
      final status = await getWatchListStatusSeries.execute(id);

      result.fold(
        (failure) {
          emit(WatchlistStatusSeriesState(
            isAddedToWatchlist: status,
            message: failure.message,
          ));
        },
        (successMessage) {
          emit(WatchlistStatusSeriesState(
            isAddedToWatchlist: status,
            message: successMessage,
          ));
        },
      );
    });

    on<RemoveFromWatchlistSeries>((event, emit) async {
      final seriesDetail = event.seriesDetail;
      final id = seriesDetail.id;

      final result = await removeWatchlistSeries.execute(seriesDetail);
      final status = await getWatchListStatusSeries.execute(id);

      result.fold(
        (failure) {
          emit(WatchlistStatusSeriesState(
            isAddedToWatchlist: status,
            message: failure.message,
          ));
        },
        (successMessage) {
          emit(WatchlistStatusSeriesState(
            isAddedToWatchlist: status,
            message: successMessage,
          ));
        },
      );
    });

    on<LoadWatchlistStatusSeries>((event, emit) async {
      final id = event.id;
      final status = await getWatchListStatusSeries.execute(id);

      emit(WatchlistStatusSeriesState(
        isAddedToWatchlist: status,
        message: '',
      ));
    });
  }
}
