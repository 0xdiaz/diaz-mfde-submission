import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:series/presentation/blocs/popular/popular_series_bloc.dart';
import 'package:series/presentation/pages/popular_series_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockPopularSeriesBloc
    extends MockBloc<PopularSeriesEvent, PopularSeriesState>
    implements PopularSeriesBloc {}

class FakePopularSeriesEvent extends Fake implements PopularSeriesEvent {}

class FakePopularSeriesState extends Fake implements PopularSeriesState {}

void main() {
  late MockPopularSeriesBloc mockPopularSeriesBloc;

  setUpAll(() {
    registerFallbackValue(FakePopularSeriesEvent());
    registerFallbackValue(FakePopularSeriesState());
  });

  setUp(() {
    mockPopularSeriesBloc = MockPopularSeriesBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<PopularSeriesBloc>.value(
      value: mockPopularSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockPopularSeriesBloc.state)
        .thenReturn(PopularSeriesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const PopularSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockPopularSeriesBloc.state)
        .thenReturn(const PopularSeriesHasData([tSeries]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const PopularSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockPopularSeriesBloc.state)
        .thenReturn(const PopularSeriesError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const PopularSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
