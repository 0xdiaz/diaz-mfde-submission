import 'package:core/core.dart';
import 'package:about/about.dart';
import 'package:core/presentation/pages/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/presentation/blocs/detail/detail_movie_bloc.dart';
import 'package:movies/presentation/blocs/now_playing/now_playing_movies_bloc.dart';
import 'package:movies/presentation/blocs/popular/popular_movies_bloc.dart';
import 'package:movies/presentation/blocs/search/search_movies_bloc.dart';
import 'package:movies/presentation/blocs/top_rated/top_rated_movies_bloc.dart';
import 'package:movies/presentation/blocs/watchlist/watchlist_movies_bloc.dart';
import 'package:movies/presentation/pages/movie_detail_page.dart';
import 'package:movies/presentation/pages/movie_list_page.dart';
import 'package:movies/presentation/pages/popular_movies_page.dart';
import 'package:movies/presentation/pages/search_movies_page.dart';
import 'package:movies/presentation/pages/top_rated_movies_page.dart';
import 'package:movies/presentation/pages/watchlist_movies_page.dart';
import 'package:series/presentation/blocs/detail/detail_series_bloc.dart';
import 'package:series/presentation/blocs/now_playing/now_playing_series_bloc.dart';
import 'package:series/presentation/blocs/popular/popular_series_bloc.dart';
import 'package:series/presentation/blocs/recommendation/recommendation_series_bloc.dart';
import 'package:series/presentation/blocs/search/search_series_bloc.dart';
import 'package:series/presentation/blocs/season_detail/season_detail_bloc.dart';
import 'package:series/presentation/blocs/top_rated/top_rated_series_bloc.dart';
import 'package:series/presentation/blocs/watchlist/watchlist_series_bloc.dart';
import 'package:series/presentation/blocs/watchlist_status/watchlist_status_series_bloc.dart';
import 'package:series/presentation/pages/now_playing_series_page.dart';
import 'package:series/presentation/pages/popular_series_page.dart';
import 'package:series/presentation/pages/search_series_page.dart';
import 'package:series/presentation/pages/season_detail_page.dart';
import 'package:series/presentation/pages/series_detail_page.dart';
import 'package:series/presentation/pages/series_list_page.dart';
import 'package:series/presentation/pages/top_rated_series_page.dart';
import 'package:series/presentation/pages/watchlist_series_page.dart';
import 'package:core/presentation/pages/watchlist_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HttpSSLPinning.init();

  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<NowPlayingMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<DetailMovieBloc>(),
        ),

        BlocProvider(
          create: (_) => di.locator<NowPlayingSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<DetailSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<RecommendationSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistStatusSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SeasonDetailBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => MovieListPage());
            case movieListRoute:
              return MaterialPageRoute(builder: (_) => MovieListPage());
            case popularMoviesRoute:
              return MaterialPageRoute(builder: (_) => PopularMoviesPage());
            case topRatedMoviesRoute:
              return MaterialPageRoute(builder: (_) => TopRatedMoviesPage());
            case searchMoviesRoute:
              return MaterialPageRoute(builder: (_) => SearchMoviesPage());
            case watchlistMoviesRoute:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case movieDetailRoute:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case seriesListRoute:
              return MaterialPageRoute(builder: (_) => SeriesListPage());
            case nowPlayingSeriesRoute:
              return MaterialPageRoute(builder: (_) => NowPlayingSeriesPage());
            case popularSeriesRoute:
              return MaterialPageRoute(builder: (_) => PopularSeriesPage());
            case topRatedSeriesRoute:
              return MaterialPageRoute(builder: (_) => TopRatedSeriesPage());
            case searchSeriesRoute:
              return MaterialPageRoute(builder: (_) => SearchSeriesPage());
            case watchlistSeriesRoute:
              return MaterialPageRoute(builder: (_) => WatchlistSeriesPage());
            case seriesDetailRoute:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => SeriesDetailPage(id: id),
                settings: settings,
              );
            case watchlistRoute:
              return MaterialPageRoute(builder: (_) => WatchlistPage());
            case seasonDetailRoute:
              final args = settings.arguments as Map;
              return MaterialPageRoute(
                builder: (_) => SeasonDetailPage(
                  id: args['id'],
                  seasonNumber: args['seasonNumber'],
                ),
                settings: settings,
              );
            case aboutRoute:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
