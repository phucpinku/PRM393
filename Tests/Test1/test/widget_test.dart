import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:messenger_clone/main.dart';

void main() {
  testWidgets('shows chat screen and navigates to people', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MessengerCloneApp());

    expect(find.text('Chats'), findsWidgets);
    expect(find.text('Search Messenger'), findsOneWidget);
    expect(find.text('Mai gap nhe! - 11:15'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.people_outline));
    await tester.pumpAndSettle();

    expect(find.text('People'), findsWidgets);
    expect(find.text('Active friends'), findsOneWidget);
    expect(find.text('Ngoc Anh'), findsWidgets);
    expect(find.text('Active now'), findsWidgets);
  });

  testWidgets('filters chat list when typing in search', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MessengerCloneApp());

    await tester.enterText(find.byType(TextField), 'Quan');
    await tester.pump();

    expect(find.text('Minh Quan'), findsWidgets);
    expect(find.text('Ngoc Anh'), findsNothing);
    expect(find.text('Gui minh file bai tap voi. - 10:42'), findsOneWidget);

    await tester.tap(find.byTooltip('Clear search'));
    await tester.pump();

    expect(find.text('Ngoc Anh'), findsWidgets);
    expect(find.text('Mai gap nhe! - 11:15'), findsOneWidget);
  });
}
