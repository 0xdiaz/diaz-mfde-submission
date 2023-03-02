part of 'search_series_bloc.dart';

abstract class SearchSeriesEvent extends Equatable {
  const SearchSeriesEvent();
  // coverage:ignore-start
  @override
  List<Object?> get props => [];
  // coverage:ignore-end
}

class SearchSeriesOnQueryChanged extends SearchSeriesEvent {
  final String query;

  const SearchSeriesOnQueryChanged(this.query);
  // coverage:ignore-start
  @override
  List<Object?> get props => [query];
  // coverage:ignore-end
}
