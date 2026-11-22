import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/main.dart';

Finder formField(String name) => find.byKey(ValueKey('experience-$name'));
Finder educationField(String name) => find.byKey(ValueKey('education-$name'));

Future<void> openExperienceFromHome(WidgetTester tester) async {
  await tester.pumpWidget(const MyApp());
  await tester.pumpAndSettle();
  final experienceAction = find.text('Tambah Pengalaman');
  await tester.ensureVisible(experienceAction);
  await tester.tap(experienceAction);
  await tester.pumpAndSettle();
}

Future<void> openEducationFromHome(WidgetTester tester) async {
  await tester.pumpWidget(const MyApp());
  await tester.pumpAndSettle();
  final educationAction = find.text('Tambah Pendidikan');
  await tester.ensureVisible(educationAction);
  await tester.tap(educationAction);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('experience form is reachable from the home action card', (
    tester,
  ) async {
    await openExperienceFromHome(tester);

    expect(find.text('Pengalaman Baru'), findsOneWidget);
    expect(formField('title'), findsOneWidget);
    expect(formField('start-date'), findsOneWidget);
  });

  testWidgets('drawer opens experience form and Home returns to main page', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add Experience'));
    await tester.pumpAndSettle();

    expect(find.text('Pengalaman Baru'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();

    expect(find.text('Selamat datang di MyPortfolio Mobile!'), findsOneWidget);
  });

  testWidgets('experience form validates required inputs', (tester) async {
    await openExperienceFromHome(tester);

    final saveButton = formField('save');
    await tester.ensureVisible(saveButton);
    await tester.tap(saveButton);
    await tester.pumpAndSettle();

    expect(find.text('Judul pengalaman tidak boleh kosong.'), findsOneWidget);
    expect(find.text('Organisasi tidak boleh kosong.'), findsOneWidget);
    expect(find.text('Deskripsi tidak boleh kosong.'), findsOneWidget);
    expect(find.text('Tanggal mulai harus dipilih.'), findsOneWidget);
    expect(find.text('Ringkasan Pengalaman'), findsNothing);
  });

  testWidgets('valid experience input appears in summary dialog', (
    tester,
  ) async {
    await openExperienceFromHome(tester);

    await tester.enterText(formField('title'), 'Flutter Developer');
    await tester.enterText(formField('organization'), 'Open Source Community');
    await tester.enterText(
      formField('description'),
      'Membangun aplikasi portofolio lintas platform.',
    );
    await tester.enterText(
      formField('image-url'),
      'https://example.com/experience.png',
    );

    await tester.ensureVisible(formField('start-date'));
    await tester.tap(formField('start-date'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    final saveButton = formField('save');
    await tester.ensureVisible(saveButton);
    await tester.tap(saveButton);
    await tester.pumpAndSettle();

    expect(find.text('Ringkasan Pengalaman'), findsOneWidget);
    expect(find.text('Judul'), findsOneWidget);
    expect(find.text('Organisasi'), findsNWidgets(2));
    expect(find.text('Flutter Developer'), findsNWidgets(2));
    expect(find.text('Open Source Community'), findsNWidgets(2));
    expect(find.text('Masih berlangsung'), findsOneWidget);
    expect(find.text('https://example.com/experience.png'), findsNWidgets(2));

    await tester.tap(find.text('Tutup'));
    await tester.pumpAndSettle();
    expect(find.text('Ringkasan Pengalaman'), findsNothing);
  });

  testWidgets('education form is reachable from the home action card', (
    tester,
  ) async {
    await openEducationFromHome(tester);

    expect(find.text('Pendidikan Baru'), findsOneWidget);
    expect(educationField('organization'), findsOneWidget);
    expect(educationField('field-of-study'), findsOneWidget);
    expect(educationField('start-date'), findsOneWidget);
  });

  testWidgets('drawer opens education form and Home returns to main page', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add Education'));
    await tester.pumpAndSettle();

    expect(find.text('Pendidikan Baru'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();

    expect(find.text('Selamat datang di MyPortfolio Mobile!'), findsOneWidget);
  });

  testWidgets('education form validates required inputs', (tester) async {
    await openEducationFromHome(tester);

    final saveButton = educationField('save');
    await tester.ensureVisible(saveButton);
    await tester.tap(saveButton);
    await tester.pumpAndSettle();

    expect(
      find.text('Institusi pendidikan tidak boleh kosong.'),
      findsOneWidget,
    );
    expect(find.text('Bidang studi tidak boleh kosong.'), findsOneWidget);
    expect(find.text('Deskripsi tidak boleh kosong.'), findsOneWidget);
    expect(find.text('Tanggal mulai harus dipilih.'), findsOneWidget);
    expect(find.text('Ringkasan Pendidikan'), findsNothing);
  });

  testWidgets('valid education input appears in summary dialog', (
    tester,
  ) async {
    await openEducationFromHome(tester);

    await tester.enterText(
      educationField('organization'),
      'Universitas Indonesia',
    );
    await tester.enterText(
      educationField('field-of-study'),
      'Sistem Informasi',
    );
    await tester.enterText(
      educationField('description'),
      'Mempelajari pengembangan perangkat lunak dan proses bisnis.',
    );
    await tester.enterText(
      educationField('image-url'),
      'https://example.com/campus.png',
    );

    await tester.ensureVisible(educationField('start-date'));
    await tester.tap(educationField('start-date'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    final saveButton = educationField('save');
    await tester.ensureVisible(saveButton);
    await tester.tap(saveButton);
    await tester.pumpAndSettle();

    expect(find.text('Ringkasan Pendidikan'), findsOneWidget);
    expect(find.text('Institusi'), findsOneWidget);
    expect(find.text('Bidang studi'), findsOneWidget);
    expect(find.text('Universitas Indonesia'), findsNWidgets(2));
    expect(find.text('Sistem Informasi'), findsNWidgets(2));
    expect(find.text('Masih berlangsung'), findsOneWidget);
    expect(find.text('https://example.com/campus.png'), findsNWidgets(2));

    await tester.tap(find.text('Tutup'));
    await tester.pumpAndSettle();
    expect(find.text('Ringkasan Pendidikan'), findsNothing);
  });
}
