import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series/presentation/blocs/popular/popular_series_bloc.dart';
import 'package:series/presentation/widget/series_card_list.dart';

class PopularSeriesPage extends StatefulWidget {
  const PopularSeriesPage({super.key});

  @override
  State<PopularSeriesPage> createState() => _PopularSeriesPageState();
}

class _PopularSeriesPageState extends State<PopularSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<PopularSeriesBloc>().add(FetchPopularSeries()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularSeriesBloc, PopularSeriesState>(
          builder: (_, state) {
            if (state is PopularSeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularSeriesHasData) {
              return ListView.builder(
                itemBuilder: (_, index) {
                  final series = state.result[index];
                  return SeriesCard(series: series);
                },
                itemCount: state.result.length,
              );
            } else if (state is PopularSeriesError){
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: Text('Error Get Popular TV Series'),
              );
            }
          },
        ),
      ),
    );
  }
}
