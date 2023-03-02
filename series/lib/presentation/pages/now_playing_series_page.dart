import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series/presentation/blocs/now_playing/now_playing_series_bloc.dart';
import 'package:series/presentation/widget/series_card_list.dart';

class NowPlayingSeriesPage extends StatefulWidget {
  const NowPlayingSeriesPage({super.key});

  @override
  State<NowPlayingSeriesPage> createState() => _NowPlayingSeriesPageState();
}

class _NowPlayingSeriesPageState extends State<NowPlayingSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<NowPlayingSeriesBloc>().add(FetchNowPlayingSeries()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<NowPlayingSeriesBloc, NowPlayingSeriesState>(
          builder: (_, state) {
            if (state is NowPlayingSeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NowPlayingSeriesHasData) {
              return ListView.builder(
                itemBuilder: (_, index) {
                  final series = state.result[index];
                  return SeriesCard(series: series);
                },
                itemCount: state.result.length,
              );
            } else if (state is NowPlayingSeriesError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: Text('Error Get Now Playing TV Series'),
              );
            }
          },
        ),
      ),
    );
  }
}
