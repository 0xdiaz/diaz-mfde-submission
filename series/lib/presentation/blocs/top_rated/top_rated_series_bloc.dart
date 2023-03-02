import 'package:core/domain/entities/series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series/domain/usecases/get_top_rated_series.dart';

part 'top_rated_series_event.dart';
part 'top_rated_series_state.dart';

class TopRatedSeriesBloc
    extends Bloc<TopRatedSeriesEvent, TopRatedSeriesState> {
  final GetTopRatedSeries _getTopRatedSeries;

  TopRatedSeriesBloc(this._getTopRatedSeries)
      : super(TopRatedSeriesEmpty()) {
    on<FetchTopRatedSeries>((event, emit) async {
      emit(TopRatedSeriesLoading());

      final result = await _getTopRatedSeries.execute();

      result.fold(
        (failure) => emit(TopRatedSeriesError(failure.message)),
        (data) => emit(TopRatedSeriesHasData(data)),
      );
    });
  }
}
