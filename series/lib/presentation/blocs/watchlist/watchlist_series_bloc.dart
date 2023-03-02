import 'package:core/domain/entities/series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series/domain/usecases/get_watchlist_series.dart';

part 'watchlist_series_event.dart';
part 'watchlist_series_state.dart';

class WatchlistSeriesBloc
    extends Bloc<WatchlistSeriesEvent, WatchlistSeriesState> {
  final GetWatchlistSeries _getWatchlistSeries;

  WatchlistSeriesBloc(this._getWatchlistSeries)
      : super(WatchlistSeriesEmpty()) {
    on<FetchWatchlistSeries>((_, emit) async {
      emit(WatchlistSeriesLoading());

      final result = await _getWatchlistSeries.execute();

      result.fold(
        (failure) => emit(WatchlistSeriesError(failure.message)),
        (data) {
          if (data.isEmpty) {
            emit(WatchlistSeriesEmpty());
          } else {
            emit(WatchlistSeriesHasData(data));
          }
        },
      );
    });
  }
}
