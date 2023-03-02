import 'package:core/domain/entities/series_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series/domain/usecases/get_series_detail.dart';

part 'detail_series_event.dart';
part 'detail_series_state.dart';

class DetailSeriesBloc
    extends Bloc<DetailSeriesEvent, DetailSeriesState> {
  final GetSeriesDetail _getSeriesDetail;

  DetailSeriesBloc(
    this._getSeriesDetail,
  ) : super(DetailSeriesEmpty()) {
    on<FetchDetailSeries>((event, emit) async {
      emit(DetailSeriesLoading());

      final id = event.id;
      final result = await _getSeriesDetail.execute(id);

      result.fold(
        (failure) => emit(DetailSeriesError(failure.message)),
        (data) => emit(DetailSeriesHasData(data)),
      );
    });
  }
}
