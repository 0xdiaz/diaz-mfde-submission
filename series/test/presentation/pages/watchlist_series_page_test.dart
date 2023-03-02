import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:series/presentation/blocs/watchlist/watchlist_series_bloc.dart';
import 'package:series/presentation/pages/watchlist_series_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockWatchlistSeriesBloc
    extends MockBloc<WatchlistSeriesEvent, WatchlistSeriesState>
    implements WatchlistSeriesBloc {}

class FakeWatchlistSeriesEvent extends Fake
    implements WatchlistSeriesEvent {}

class FakeWatchlistSeriesState extends Fake
    implements WatchlistSeriesState {}

void main() {
  late MockWatchlistSeriesBloc mockWatchlistSeriesBloc;

  setUpAll(() {
    registerFallbackValue(FakeWatchlistSeriesEvent());
    registerFallbackValue(FakeWatchlistSeriesState());
  });

  setUp(() {
    mockWatchlistSeriesBloc = MockWatchlistSeriesBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistSeriesBloc>.value(
      value: mockWatchlistSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockWatchlistSeriesBloc.state)
        .thenReturn(WatchlistSeriesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const WatchlistSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockWatchlistSeriesBloc.state)
        .thenReturn(const WatchlistSeriesHasData([tSeries]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const WatchlistSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockWatchlistSeriesBloc.state)
        .thenReturn(const WatchlistSeriesError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const WatchlistSeriesPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display text when data is empty',
      (WidgetTester tester) async {
    when(() => mockWatchlistSeriesBloc.state)
        .thenReturn(WatchlistSeriesEmpty());

    final textErrorBarFinder = find.text('Empty Watchlist');

    await tester.pumpWidget(makeTestableWidget(const WatchlistSeriesPage()));

    expect(textErrorBarFinder, findsOneWidget);
  });
}
