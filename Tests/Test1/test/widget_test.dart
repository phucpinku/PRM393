import 'package:flutter_test/flutter_test.dart';

import 'package:messenger_clone/main.dart';

void main() {
  testWidgets('shows chat screen and navigates to people', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MessengerCloneApp());

    expect(find.text('Chats'), findsWidgets);
    expect(find.text('Search'), findsOneWidget);
    expect(find.text('Mai gap nhe! - 11:15'), findsOneWidget);

    await tester.tap(find.text('People'));
    await tester.pumpAndSettle();

    expect(find.text('People'), findsWidgets);
    expect(find.text('Phuong Linh'), findsOneWidget);
    expect(find.text('Active now'), findsWidgets);
  });
}
