import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:utsmobilepalupi/main.dart';

void main() {
  testWidgets('menu can be viewed and a validated menu can be added',
      (WidgetTester tester) async {
    await tester.pumpWidget(const CanteenMenuApp());
    await tester.pumpAndSettle();

    expect(find.text('Nasi Goreng Spesial'), findsOneWidget);
    expect(find.text('Rp 18.000'), findsOneWidget);

    await tester.tap(find.text('Nasi Goreng Spesial'));
    await tester.pumpAndSettle();
    expect(find.text('Detail Menu'), findsOneWidget);
    expect(find.text('Rp 18.000'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Tambah menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Simpan Menu'));
    await tester.pumpAndSettle();
    expect(find.text('Nama menu tidak boleh kosong'), findsOneWidget);
    expect(find.text('Harga tidak boleh kosong'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(0), 'Bakso Kuah');
    await tester.enterText(find.byType(TextFormField).at(1), '16000');
    await tester.tap(find.text('Simpan Menu'));
    await tester.pumpAndSettle();

    expect(find.text('Bakso Kuah'), findsOneWidget);
    expect(find.text('Rp 16.000'), findsOneWidget);
    expect(find.text('Nasi Goreng Spesial'), findsOneWidget);
  });
}
