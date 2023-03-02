import 'package:core/domain/entities/series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series/domain/usecases/get_series_recommendations.dart';

part 'recommendation_series_event.dart';
part 'recommendation_series_state.dart';

class RecommendationSeriesBloc
    extends Bloc<RecommendationSeriesEvent, RecommendationSeriesState> {
  final GetSeriesRecommendations _getSeriesRecommendations;

  RecommendationSeriesBloc(this._getSeriesRecommendations)
      : super(RecommendationSeriesEmpty()) {
    on<FetchRecommendationSeries>((event, emit) async {
      emit(RecommendationSeriesLoading());

      final id = event.id;
      final result = await _getSeriesRecommendations.execute(id);

      result.fold(
        (failure) => emit(RecommendationSeriesError(failure.message)),
        (data) {
          if (data.isEmpty) {
            emit(RecommendationSeriesEmpty());
          } else {
            emit(RecommendationSeriesHasData(data));
          }
        },
      );
    });
  }
}
