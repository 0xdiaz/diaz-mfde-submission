import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series/presentation/widget/series_card_list.dart';
import 'package:series/presentation/blocs/top_rated/top_rated_series_bloc.dart';

class TopRatedSeriesPage extends StatefulWidget {
  const TopRatedSeriesPage({super.key});


  @override
  State<TopRatedSeriesPage> createState() => _TopRatedSeriesPageState();
}

class _TopRatedSeriesPageState extends State<TopRatedSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<TopRatedSeriesBloc>().add(FetchTopRatedSeries()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedSeriesBloc, TopRatedSeriesState>(
          builder: (_, state) {
            if (state is TopRatedSeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedSeriesHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final series = state.result[index];
                  return SeriesCard(series: series);
                },
                itemCount: state.result.length,
              );
            } else if (state is TopRatedSeriesError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: Text('Error Get Top Rated TV Series'),
              );
            }
          },
        ),
      ),
    );
  }
}
