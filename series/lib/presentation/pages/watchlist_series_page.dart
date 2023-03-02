import 'package:core/core.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series/presentation/widget/series_card_list.dart';
import 'package:series/presentation/blocs/watchlist/watchlist_series_bloc.dart';

class WatchlistSeriesPage extends StatefulWidget {
  const WatchlistSeriesPage({super.key});


  @override
  State<WatchlistSeriesPage> createState() => _WatchlistSeriesPageState();
}

class _WatchlistSeriesPageState extends State<WatchlistSeriesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<WatchlistSeriesBloc>().add(FetchWatchlistSeries()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistSeriesBloc>().add(FetchWatchlistSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistSeriesBloc, WatchlistSeriesState>(
          builder: (_, state) {
            if (state is WatchlistSeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistSeriesHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final series = state.result[index];
                  return SeriesCard(series: series);
                },
                itemCount: state.result.length,
              );
            } else if (state is WatchlistSeriesError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.visibility_off,
                      size: 36,
                    ),
                    SizedBox(height: 4),
                    Text('Empty Watchlist'),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
