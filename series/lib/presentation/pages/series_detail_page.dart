import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/season.dart';
import 'package:core/domain/entities/series.dart';
import 'package:core/domain/entities/series_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:series/presentation/blocs/detail/detail_series_bloc.dart';
import 'package:series/presentation/blocs/recommendation/recommendation_series_bloc.dart';
import 'package:series/presentation/blocs/watchlist_status/watchlist_status_series_bloc.dart';

class SeriesDetailPage extends StatefulWidget {
  final int id;
  const SeriesDetailPage({super.key, required this.id});

  @override
  State<SeriesDetailPage> createState() => _SeriesDetailPageState();
}

class _SeriesDetailPageState extends State<SeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final id = widget.id;
      context.read<DetailSeriesBloc>().add(FetchDetailSeries(id));
      context.read<WatchlistStatusSeriesBloc>().add(LoadWatchlistStatusSeries(id));
      context.read<RecommendationSeriesBloc>().add(FetchRecommendationSeries(id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailSeriesBloc, DetailSeriesState>(
        builder: (_, state) {
          if (state is DetailSeriesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DetailSeriesHasData) {
            return SafeArea(
              child: DetailContent(state.result),
            );
          } else if (state is DetailSeriesError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final SeriesDetail seriesDetail;

  const DetailContent(this.seriesDetail, {super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: '$baseImageUrl${seriesDetail.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              seriesDetail.name,
                              style: kHeading5,
                            ),
                            BlocConsumer<WatchlistStatusSeriesBloc, WatchlistStatusSeriesState>(
                              listener: (context, state) {
                                if (state.message == WatchlistStatusSeriesBloc.watchlistAddSuccessMessage ||
                                    state.message == WatchlistStatusSeriesBloc.watchlistRemoveSuccessMessage) {
                                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(state.message)),
                                      );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Text(state.message),
                                      );
                                    },
                                  );
                                }
                              },
                              listenWhen: (oldState, newState)
                                  => oldState.message != newState.message && newState.message != '',
                              builder: (context, state) {
                                return ElevatedButton(
                                  key: const Key('watchlistButton'),
                                  onPressed: () async {
                                    if (!state.isAddedToWatchlist) {
                                      context
                                          .read<WatchlistStatusSeriesBloc>()
                                          .add(AddWatchlistSeries(seriesDetail));
                                    } else {
                                      context
                                          .read<WatchlistStatusSeriesBloc>()
                                          .add(RemoveFromWatchlistSeries(seriesDetail));
                                    }
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      state.isAddedToWatchlist
                                          ? const Icon(Icons.check)
                                          : const Icon(Icons.add),
                                      const Text('Watchlist'),
                                    ],
                                  ),
                                );
                              },
                            ),
                            Text(
                              _showGenres(seriesDetail.genres),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: seriesDetail.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${seriesDetail.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              seriesDetail.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Seasons',
                              style: kHeading6,
                            ),
                            SeriesSeasonList(
                              seasonId: seriesDetail.id,
                              seasons: seriesDetail.seasons,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<RecommendationSeriesBloc, RecommendationSeriesState>(
                              builder: (_, state) {
                                if (state is RecommendationSeriesLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is RecommendationSeriesHasData) {
                                  return SeriesRecommendationList(
                                    seriesList: state.result,
                                  );
                                } else if (state is RecommendationSeriesError) {
                                  return Center(
                                    child: Text(state.message),
                                  );
                                } else if (state is RecommendationSeriesEmpty) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[700],
                                      borderRadius: BorderRadius.circular(8)
                                    ),
                                    height: 160,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: const [
                                          Icon(Icons.tv_off),
                                          SizedBox(height: 4),
                                          Text('No Recommendations'),
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}

class SeriesRecommendationList extends StatelessWidget {
  final List<Series> seriesList;

  const SeriesRecommendationList({required this.seriesList, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final series = seriesList[index];
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(
                  context,
                  seriesDetailRoute,
                  arguments: series.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
                child: CachedNetworkImage(
                  imageUrl:
                  'https://image.tmdb.org/t/p/w500${series.posterPath}',
                  placeholder: (context, url) =>
                  const Center(
                    child:
                    CircularProgressIndicator(),
                  ),
                  errorWidget:
                      (context, url, error) =>
                  const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: seriesList.length,
      ),
    );
  }
}

class SeriesSeasonList extends StatelessWidget {
  final int seasonId;
  final List<Season> seasons;

  const SeriesSeasonList({
    required this.seasonId,
    required this.seasons,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final season = seasons[index];
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: InkWell(
              onTap: () => Navigator.pushNamed(
                context,
                seasonDetailRoute,
                arguments: {
                  'id': seasonId,
                  'seasonNumber': season.seasonNumber,
                },
              ),
              child: Container(
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Flexible(
                      flex: 3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: season.posterPath != null
                              ? '$baseImageUrl${season.posterPath}'
                              : 'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg',
                          width: 100,
                          fit: BoxFit.cover,
                          placeholder: (_, __) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                          errorWidget: (_, __, error) {
                            return Container(
                              color: Colors.black26,
                              child: const Center(
                                child: Text('No Image'),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Center(
                          child: Text(
                            season.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: seasons.length,
      ),
    );
  }
}