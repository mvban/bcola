import 'package:flutter_test/flutter_test.dart';
import 'package:briscola_trattoria/main.dart';

void main() {
  testWidgets('App launches smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const BriscolaApp());
    await tester.pumpAndSettle();
    expect(find.byType(BriscolaApp), findsOneWidget);
  });
}
