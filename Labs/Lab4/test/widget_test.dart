import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lab4_prm/main.dart';

void main() {
  testWidgets('home menu shows all lab exercises', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Lab 4 - Flutter UI Fundamentals'), findsOneWidget);
    expect(find.text('Exercise 1 - Core Widgets\nDemo'), findsOneWidget);
    expect(find.text('Exercise 2 - Input Controls\nDemo'), findsOneWidget);
    expect(find.text('Exercise 3 - Layout Demo'), findsOneWidget);
    expect(find.text('Exercise 4 - App Structure &\nTheme'), findsOneWidget);
    expect(find.text('Exercise 5 - Common UI\nFixes'), findsOneWidget);
  });

  testWidgets('exercise 1 renders core display widgets', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Exercise 1 - Core Widgets\nDemo'));
    await tester.pumpAndSettle();

    expect(find.text('Welcome to Flutter UI'), findsOneWidget);
    expect(find.byIcon(Icons.movie), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
    expect(find.text('Movie Item'), findsOneWidget);
  });

  testWidgets('exercise 2 renders input controls', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Exercise 2 - Input Controls\nDemo'));
    await tester.pumpAndSettle();

    expect(find.byType(Slider), findsOneWidget);
    expect(find.byType(SwitchListTile), findsOneWidget);
    expect(find.byType(RadioListTile<String>), findsNWidgets(2));
    expect(find.text('Current value: 50'), findsOneWidget);
    expect(find.text('Selected genre: None'), findsOneWidget);
    expect(find.text('Open Date Picker'), findsOneWidget);
  });

  testWidgets('exercise 3 renders layout list', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Exercise 3 - Layout Demo'));
    await tester.pumpAndSettle();

    expect(find.text('Now Playing'), findsOneWidget);
    expect(find.text('Avatar'), findsOneWidget);
    expect(find.text('Inception'), findsOneWidget);
    expect(find.text('Interstellar'), findsOneWidget);
    expect(find.text('Joker'), findsOneWidget);
  });

  testWidgets('exercise 4 renders theme switch and FAB', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Exercise 4 - App Structure &\nTheme'));
    await tester.pumpAndSettle();

    expect(find.text('Dark'), findsOneWidget);
    expect(find.byType(Switch), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(materialApp.themeMode, ThemeMode.dark);
  });

  testWidgets('exercise 5 renders fixed ListView inside Column', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Exercise 5 - Common UI\nFixes'));
    await tester.pumpAndSettle();

    expect(
      find.text('Correct ListView inside Column using\nExpanded'),
      findsOneWidget,
    );
    expect(find.text('Movie A'), findsOneWidget);
    expect(find.text('Movie B'), findsOneWidget);
    expect(find.text('Movie C'), findsOneWidget);
    expect(find.text('Movie D'), findsOneWidget);
  });
}
