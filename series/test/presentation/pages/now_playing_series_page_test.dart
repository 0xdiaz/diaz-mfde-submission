import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:series/presentation/blocs/now_playing/now_playing_series_bloc.dart';
import 'package:series/presentation/pages/now_playing_series_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockNowPlayingSeriesBloc
    extends MockBloc<NowPlayingSeriesEvent, NowPlayingSeriesState>
    implements NowPlayingSeriesBloc {}

class FakeNowPlayingSeriesEvent extends Fake
    implements NowPlayingSeriesEvent {}

class FakeNowPlayingSeriesState extends Fake
    implements NowPlayingSeriesState {}

void main() {
  late MockNowPlayingSeriesBloc mockNowPlayingSeriesBloc;

  setUpAll(() {
    registerFallbackValue(FakeNowPlayingSeriesEvent());
    registerFallbackValue(FakeNowPlayingSeriesState());
  });

  setUp(() {
    mockNowPlayingSeriesBloc = MockNowPlayingSeriesBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<NowPlayingSeriesBloc>.value(
      value: mockNowPlayingSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockNowPlayingSeriesBloc.state)
        .thenReturn(NowPlayingSeriesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const NowPlayingSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockNowPlayingSeriesBloc.state)
        .thenReturn(const NowPlayingSeriesHasData([tSeries]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const NowPlayingSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockNowPlayingSeriesBloc.state)
        .thenReturn(const NowPlayingSeriesError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const NowPlayingSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
