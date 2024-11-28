import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truckcontrol/main.dart';
import 'package:truckcontrol/shared_preferences_mock.mocks.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    final mockPrefs = MockSharedPreferences();

    // Configure o comportamento do mock
    when(mockPrefs.getString(any)).thenReturn('');

    await tester.pumpWidget(MyApp(prefs: mockPrefs));

    // Verifique o estado inicial do contador.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Simule o toque no botão "+".
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verifique se o contador foi incrementado.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
