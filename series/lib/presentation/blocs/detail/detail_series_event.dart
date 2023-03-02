part of 'detail_series_bloc.dart';

abstract class DetailSeriesEvent extends Equatable {
  const DetailSeriesEvent();

  @override
  List<Object?> get props => [];
}

class FetchDetailSeries extends DetailSeriesEvent {
  final int id;

  const FetchDetailSeries(this.id);

  @override
  List<Object?> get props => [id];
}
