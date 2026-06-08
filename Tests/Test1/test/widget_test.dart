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
}
