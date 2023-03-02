import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/series.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series/presentation/blocs/now_playing/now_playing_series_bloc.dart';
import 'package:series/presentation/blocs/popular/popular_series_bloc.dart';
import 'package:series/presentation/blocs/top_rated/top_rated_series_bloc.dart';

class SeriesListPage extends StatefulWidget {
  const SeriesListPage({super.key});

  @override
  State<SeriesListPage> createState() => _SeriesListPageState();
}

class _SeriesListPageState extends State<SeriesListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NowPlayingSeriesBloc>().add(FetchNowPlayingSeries());
      context.read<PopularSeriesBloc>().add(FetchPopularSeries());
      context.read<TopRatedSeriesBloc>().add(FetchTopRatedSeries());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text('Movies'),
              onTap: () {
                Navigator.pushNamed(context, movieListRoute);
              },
            ),
            ListTile(
              leading: const Icon(Icons.live_tv),
              title: const Text('Series'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, watchlistRoute);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
              onTap: () {
                Navigator.pushNamed(context, aboutRoute);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('TV Series Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, searchSeriesRoute);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'Now Playing',
                onTap: () {
                  Navigator.pushNamed(context, nowPlayingSeriesRoute);
                },
              ),
              BlocBuilder<NowPlayingSeriesBloc, NowPlayingSeriesState>(
                builder: (_, state) {
                  if (state is NowPlayingSeriesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is NowPlayingSeriesHasData) {
                    return SeriesList(state.result);
                  } else {
                    return const Center(
                      child: Text('Failed'),
                    );
                  }
                }
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(context, popularSeriesRoute),
              ),
              BlocBuilder<PopularSeriesBloc, PopularSeriesState>(
                builder: (_, state) {
                  if (state is PopularSeriesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PopularSeriesHasData) {
                    return SeriesList(state.result);
                  } else {
                    return const Center(
                      child: Text('Failed'),
                    );
                  }
                }
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, topRatedSeriesRoute),
              ),
              BlocBuilder<TopRatedSeriesBloc, TopRatedSeriesState>(
                builder: (_, state) {
                  if (state is TopRatedSeriesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopRatedSeriesHasData) {
                    return SeriesList(state.result);
                  } else {
                    return const Center(
                      child: Text('Failed'),
                    );
                  }
                }
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class SeriesList extends StatelessWidget {
  final List<Series> series;

  const SeriesList(this.series, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final item = series[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  seriesDetailRoute,
                  arguments: item.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${item.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: series.length,
      ),
    );
  }
}
