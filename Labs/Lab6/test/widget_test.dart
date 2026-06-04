import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lab6_responsive_ui/main.dart';

void main() {
  Future<void> pumpMovieApp(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1000, 1200);
    tester.view.devicePixelRatio = 1;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const ResponsiveMovieApp());
  }

  testWidgets('renders the movie browsing screen', (tester) async {
    await pumpMovieApp(tester);

    expect(find.text('Find a Movie'), findsOneWidget);
    expect(find.text('Search movies'), findsOneWidget);
    expect(find.text('Stellar Horizon'), findsOneWidget);
  });

  testWidgets('search filters movies by title', (tester) async {
    await pumpMovieApp(tester);

    await tester.enterText(find.byType(TextField), 'neon');
    await tester.pump();

    expect(find.text('Neon Chase'), findsOneWidget);
    expect(find.text('Stellar Horizon'), findsNothing);
  });

  testWidgets('genre chips filter visible movies', (tester) async {
    await pumpMovieApp(tester);

    await tester.tap(find.text('Animation'));
    await tester.pump();

    expect(find.text('Pixel Kingdom'), findsOneWidget);
    expect(find.text('Silent Harbor'), findsNothing);
    expect(find.text('1 selected'), findsOneWidget);
  });

  testWidgets('sort dropdown changes movie ordering', (tester) async {
    await pumpMovieApp(tester);

    await tester.tap(find.text('Sort: A-Z'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sort: Rating').last);
    await tester.pumpAndSettle();

    final stellarTop = tester.getTopLeft(find.text('Stellar Horizon')).dy;
    final laughTop = tester.getTopLeft(find.text('Laugh Track')).dy;

    expect(stellarTop, lessThan(laughTop));
  });
}
