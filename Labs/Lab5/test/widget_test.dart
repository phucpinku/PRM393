import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lab5_prm/main.dart';

void main() {
  testWidgets('home screen displays movies and ratings', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Movies'), findsOneWidget);
    expect(find.text('Dune: Part Two'), findsOneWidget);
    expect(find.text('Deadpool & Wolverine'), findsOneWidget);
    expect(find.textContaining('8.6'), findsOneWidget);
    expect(find.textContaining('8.3'), findsOneWidget);
  });

  testWidgets('movie card opens detail screen and back returns home', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Dune: Part Two').first);
    await tester.pumpAndSettle();

    expect(find.text('Sci-Fi'), findsOneWidget);
    expect(find.text('Adventure'), findsOneWidget);
    expect(find.text('Drama'), findsOneWidget);
    expect(
      find.textContaining('Paul Atreides unites with Chani'),
      findsOneWidget,
    );
    expect(find.text('Official Trailer #1'), findsOneWidget);
    expect(find.text('IMAX Sneak Peek'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(find.text('Movies'), findsOneWidget);
    expect(find.text('Deadpool & Wolverine'), findsOneWidget);
  });

  testWidgets('favorite action toggles local state', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Dune: Part Two').first);
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    expect(find.byIcon(Icons.favorite), findsNothing);

    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pump();

    expect(find.byIcon(Icons.favorite_border), findsNothing);
    expect(find.byIcon(Icons.favorite), findsOneWidget);
  });
}
