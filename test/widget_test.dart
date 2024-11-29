import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:truckcontrol/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('App initialization test', (WidgetTester tester) async {
    // Set up a fake SharedPreferences instance
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(prefs: prefs));

    // Verify that the app title is displayed
    expect(find.text('Controle de Viagens'), findsOneWidget);

    // Verify that the ResponsiveMenu is present
    expect(find.byType(PopupMenuButton), findsOneWidget);

    // Verify that the initial state shows Viagens and Gastos sections
    expect(find.text('Viagens'), findsOneWidget);
    expect(find.text('Gastos'), findsOneWidget);

    // Verify that the Resumo Mensal is displayed
    expect(find.text('Resumo Mensal'), findsOneWidget);
  });
}

