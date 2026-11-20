import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_tracker/main.dart';

void main() {
  testWidgets('Mini Task Tracker test - render, add, toggle, and delete', (WidgetTester tester) async {
    // 1. Render aplikasi
    await tester.pumpWidget(const MyApp());
    expect(find.text('Mini Task Tracker'), findsOneWidget);

    // 2. Input tugas baru
    await tester.enterText(find.byType(TextField), 'Tugas Uji Coba Baru');
    await tester.tap(find.text('Simpan'));
    await tester.pumpAndSettle();

    // Verifikasi tugas baru muncul di daftar
    expect(find.text('Tugas Uji Coba Baru'), findsOneWidget);

    // 3. Toggle centang selesai
    final checkboxes = find.byType(Checkbox);
    expect(checkboxes, findsWidgets);
    await tester.tap(checkboxes.last);
    await tester.pumpAndSettle();

    // 4. Hapus tugas
    final deleteButtons = find.byIcon(Icons.delete);
    expect(deleteButtons, findsWidgets);
    await tester.tap(deleteButtons.last);
    await tester.pumpAndSettle();

    // Verifikasi tugas terhapus
    expect(find.text('Tugas Uji Coba Baru'), findsNothing);
  });
}
