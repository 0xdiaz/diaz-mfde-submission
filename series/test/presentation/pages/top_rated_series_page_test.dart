import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:series/presentation/blocs/top_rated/top_rated_series_bloc.dart';
import 'package:series/presentation/pages/top_rated_series_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTopRatedSeriesBloc
    extends MockBloc<TopRatedSeriesEvent, TopRatedSeriesState>
    implements TopRatedSeriesBloc {}

class FakeTopRatedSeriesEvent extends Fake implements TopRatedSeriesEvent {}

class FakeTopRatedSeriesState extends Fake implements TopRatedSeriesState {}

void main() {
  late MockTopRatedSeriesBloc mockTopRatedSeriesBloc;

  setUpAll(() {
    registerFallbackValue(FakeTopRatedSeriesEvent());
    registerFallbackValue(FakeTopRatedSeriesState());
  });

  setUp(() {
    mockTopRatedSeriesBloc = MockTopRatedSeriesBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedSeriesBloc>.value(
      value: mockTopRatedSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTopRatedSeriesBloc.state)
        .thenReturn(TopRatedSeriesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const TopRatedSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTopRatedSeriesBloc.state)
        .thenReturn(const TopRatedSeriesHasData([tSeries]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const TopRatedSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTopRatedSeriesBloc.state)
        .thenReturn(const TopRatedSeriesError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const TopRatedSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
