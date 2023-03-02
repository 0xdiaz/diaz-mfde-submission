part of 'now_playing_series_bloc.dart';

abstract class NowPlayingSeriesEvent extends Equatable {
  const NowPlayingSeriesEvent();
  // coverage:ignore-start
  @override
  List<Object?> get props => [];
  // coverage:ignore-end
}

class FetchNowPlayingSeries extends NowPlayingSeriesEvent {}
