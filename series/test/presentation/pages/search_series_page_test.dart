import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:series/presentation/blocs/search/search_series_bloc.dart';
import 'package:series/presentation/pages/search_series_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockSearchSeriesBloc
    extends MockBloc<SearchSeriesEvent, SearchSeriesState>
    implements SearchSeriesBloc {}

class FakeSearchSeriesEvent extends Fake implements SearchSeriesEvent {}

class FakeSearchSeriesState extends Fake implements SearchSeriesState {}

void main() {
  late MockSearchSeriesBloc mockSearchSeriesBloc;

  setUpAll(() {
    registerFallbackValue(FakeSearchSeriesEvent());
    registerFallbackValue(FakeSearchSeriesState());
  });

  setUp(() {
    mockSearchSeriesBloc = MockSearchSeriesBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<SearchSeriesBloc>.value(
      value: mockSearchSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockSearchSeriesBloc.state)
        .thenReturn(SearchSeriesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(makeTestableWidget(const SearchSeriesPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockSearchSeriesBloc.state)
        .thenReturn(const SearchSeriesHasData([tSeries]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const SearchSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockSearchSeriesBloc.state)
        .thenReturn(const SearchSeriesHasData([tSeries]));

    final formSearch = find.byType(TextField);
    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const SearchSeriesPage()));

    await tester.enterText(formSearch, 'spiderman');
    await tester.pump();

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display Text when data is empty',
      (WidgetTester tester) async {
    when(() => mockSearchSeriesBloc.state).thenReturn(SearchSeriesEmpty());

    final textErrorBarFinder = find.text('Search Not Found');

    await tester.pumpWidget(makeTestableWidget(const SearchSeriesPage()));

    expect(textErrorBarFinder, findsOneWidget);
  });

  testWidgets('Page should display when initial', (WidgetTester tester) async {
    when(() => mockSearchSeriesBloc.state)
        .thenReturn(SearchSeriesInitial());

    final textErrorBarFinder = find.byType(Container);

    await tester.pumpWidget(makeTestableWidget(const SearchSeriesPage()));

    expect(textErrorBarFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockSearchSeriesBloc.state)
        .thenReturn(const SearchSeriesError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const SearchSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
