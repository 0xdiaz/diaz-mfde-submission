import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:series/presentation/blocs/detail/detail_series_bloc.dart';
import 'package:series/presentation/blocs/recommendation/recommendation_series_bloc.dart';
import 'package:series/presentation/blocs/watchlist_status/watchlist_status_series_bloc.dart';
import 'package:series/presentation/pages/series_detail_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockDetailSeriesBloc
    extends MockBloc<DetailSeriesEvent, DetailSeriesState>
    implements DetailSeriesBloc {}

class FakeDetailSeriesEvent extends Fake implements DetailSeriesEvent {}

class FakeDetailSeriesState extends Fake implements DetailSeriesState {}

class MockRecommendationSeriesBloc
    extends MockBloc<RecommendationSeriesEvent, RecommendationSeriesState>
    implements RecommendationSeriesBloc {}

class FakeRecommendationSeriesEvent extends Fake
    implements RecommendationSeriesEvent {}

class FakeRecommendationSeriesState extends Fake
    implements RecommendationSeriesState {}

class MockWatchlistStatusSeriesBloc
    extends MockBloc<WatchlistStatusSeriesEvent, WatchlistStatusSeriesState>
    implements WatchlistStatusSeriesBloc {}

class FakeWatchlistStatusSeriesEvent extends Fake
    implements WatchlistStatusSeriesEvent {}

class FakeWatchlistStatusSeriesState extends Fake
    implements WatchlistStatusSeriesState {}

void main() {
  late MockDetailSeriesBloc mockDetailSeriesBloc;
  late MockRecommendationSeriesBloc mockRecommendationSeriesBloc;
  late MockWatchlistStatusSeriesBloc mockWatchlistStatusSeriesBloc;

  setUpAll(() {
    registerFallbackValue(FakeDetailSeriesEvent());
    registerFallbackValue(FakeDetailSeriesState());
    registerFallbackValue(FakeRecommendationSeriesEvent());
    registerFallbackValue(FakeRecommendationSeriesState());
    registerFallbackValue(FakeWatchlistStatusSeriesEvent());
    registerFallbackValue(FakeWatchlistStatusSeriesState());
  });

  setUp(() {
    mockDetailSeriesBloc = MockDetailSeriesBloc();
    mockRecommendationSeriesBloc = MockRecommendationSeriesBloc();
    mockWatchlistStatusSeriesBloc = MockWatchlistStatusSeriesBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailSeriesBloc>.value(value: mockDetailSeriesBloc),
        BlocProvider<RecommendationSeriesBloc>.value(
          value: mockRecommendationSeriesBloc,
        ),
        BlocProvider<WatchlistStatusSeriesBloc>.value(
          value: mockWatchlistStatusSeriesBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  const tId = 1;

  testWidgets(
      'Watchlist button should display add icon when  series not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockDetailSeriesBloc.state)
        .thenReturn(const DetailSeriesHasData(tSeriesDetail));
    when(() => mockRecommendationSeriesBloc.state)
        .thenReturn(const RecommendationSeriesHasData([tSeries]));
    when(() => mockWatchlistStatusSeriesBloc.state).thenReturn(
        const WatchlistStatusSeriesState(
            isAddedToWatchlist: false, message: ''));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester
        .pumpWidget(makeTestableWidget(const SeriesDetailPage(id: tId)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when  series is added to watchlist',
      (WidgetTester tester) async {
    when(() => mockDetailSeriesBloc.state)
        .thenReturn(const DetailSeriesHasData(tSeriesDetail));
    when(() => mockRecommendationSeriesBloc.state)
        .thenReturn(const RecommendationSeriesHasData([tSeries]));
    when(() => mockWatchlistStatusSeriesBloc.state).thenReturn(
        const WatchlistStatusSeriesState(
            isAddedToWatchlist: true, message: ''));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester
        .pumpWidget(makeTestableWidget(const SeriesDetailPage(id: tId)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => mockDetailSeriesBloc.state)
        .thenReturn(const DetailSeriesHasData(tSeriesDetail));
    when(() => mockRecommendationSeriesBloc.state)
        .thenReturn(const RecommendationSeriesHasData([tSeries]));

    whenListen(
      mockWatchlistStatusSeriesBloc,
      Stream.fromIterable([
        const WatchlistStatusSeriesState(
          isAddedToWatchlist: true,
          message: 'Added to Watchlist',
        ),
      ]),
      initialState: const WatchlistStatusSeriesState(
        isAddedToWatchlist: false,
        message: '',
      ),
    );

    final watchlistButton = find.byType(ElevatedButton);
    final watchlistButtonIconAdd = find.byIcon(Icons.add);
    final watchlistButtonIconCheck = find.byIcon(Icons.check);
    final snackbar = find.byType(SnackBar);
    final textMessage = find.text('Added to Watchlist');

    await tester
        .pumpWidget(makeTestableWidget(const SeriesDetailPage(id: tId)));

    expect(watchlistButtonIconAdd, findsOneWidget);
    expect(snackbar, findsNothing);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(watchlistButtonIconCheck, findsOneWidget);
    expect(snackbar, findsOneWidget);
    expect(textMessage, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when removed from watchlist',
      (WidgetTester tester) async {
    when(() => mockDetailSeriesBloc.state)
        .thenReturn(const DetailSeriesHasData(tSeriesDetail));
    when(() => mockRecommendationSeriesBloc.state)
        .thenReturn(const RecommendationSeriesHasData([tSeries]));

    whenListen(
      mockWatchlistStatusSeriesBloc,
      Stream.fromIterable([
        const WatchlistStatusSeriesState(
          isAddedToWatchlist: false,
          message: 'Removed from Watchlist',
        ),
      ]),
      initialState: const WatchlistStatusSeriesState(
        isAddedToWatchlist: true,
        message: '',
      ),
    );

    final watchlistButton = find.byType(ElevatedButton);
    final watchlistButtonIconAdd = find.byIcon(Icons.add);
    final watchlistButtonIconCheck = find.byIcon(Icons.check);
    final snackbar = find.byType(SnackBar);
    final textMessage = find.text('Removed from Watchlist');

    await tester
        .pumpWidget(makeTestableWidget(const SeriesDetailPage(id: tId)));

    expect(watchlistButtonIconCheck, findsOneWidget);
    expect(snackbar, findsNothing);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(watchlistButtonIconAdd, findsOneWidget);
    expect(snackbar, findsOneWidget);
    expect(textMessage, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(() => mockDetailSeriesBloc.state)
        .thenReturn(const DetailSeriesHasData(tSeriesDetail));
    when(() => mockRecommendationSeriesBloc.state)
        .thenReturn(const RecommendationSeriesHasData([tSeries]));

    whenListen(
      mockWatchlistStatusSeriesBloc,
      Stream.fromIterable([
        const WatchlistStatusSeriesState(
          isAddedToWatchlist: false,
          message: 'Failed Add to Watchlist',
        ),
      ]),
      initialState: const WatchlistStatusSeriesState(
        isAddedToWatchlist: false,
        message: '',
      ),
    );

    final watchlistButton = find.byType(ElevatedButton);
    final watchlistButtonIconAdd = find.byIcon(Icons.add);
    final alertDialog = find.byType(AlertDialog);
    final textMessage = find.text('Failed Add to Watchlist');

    await tester
        .pumpWidget(makeTestableWidget(const SeriesDetailPage(id: tId)));

    expect(watchlistButtonIconAdd, findsOneWidget);
    expect(alertDialog, findsNothing);

    await tester.tap(watchlistButton, warnIfMissed: false);
    await tester.pump();

    expect(alertDialog, findsOneWidget);
    expect(textMessage, findsOneWidget);
  });

  testWidgets(' Series should display message error when no internet network',
      (WidgetTester tester) async {
    when(() => mockDetailSeriesBloc.state).thenReturn(
        const DetailSeriesError('Failed to connect to the network'));

    final textErrorBarFinder = find.text('Failed to connect to the network');

    await tester
        .pumpWidget(makeTestableWidget(const SeriesDetailPage(id: tId)));

    expect(textErrorBarFinder, findsOneWidget);
  });

  testWidgets(
    'Recommendations  Series should display text when data is empty',
    (WidgetTester tester) async {
      when(() => mockDetailSeriesBloc.state)
          .thenReturn(const DetailSeriesHasData(tSeriesDetail));
      when(() => mockRecommendationSeriesBloc.state)
          .thenReturn(RecommendationSeriesEmpty());
      when(() => mockWatchlistStatusSeriesBloc.state).thenReturn(
        const WatchlistStatusSeriesState(
          isAddedToWatchlist: false,
          message: '',
        ),
      );

      final textErrorBarFinder = find.text('No Recommendations');

      await tester
          .pumpWidget(makeTestableWidget(const SeriesDetailPage(id: tId)));

      expect(textErrorBarFinder, findsOneWidget);
    },
  );

  testWidgets(
      'Recommendations  Series should display message error when error',
      (WidgetTester tester) async {
    when(() => mockDetailSeriesBloc.state)
        .thenReturn(const DetailSeriesHasData(tSeriesDetail));
    when(() => mockRecommendationSeriesBloc.state)
        .thenReturn(const RecommendationSeriesError('Error'));
    when(() => mockWatchlistStatusSeriesBloc.state).thenReturn(
      const WatchlistStatusSeriesState(
        isAddedToWatchlist: false,
        message: '',
      ),
    );

    final textErrorBarFinder = find.text('Error');

    await tester
        .pumpWidget(makeTestableWidget(const SeriesDetailPage(id: tId)));

    expect(textErrorBarFinder, findsOneWidget);
  });
}
