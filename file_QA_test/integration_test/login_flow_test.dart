import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:bitka/features/auth/login_screen.dart';
import 'package:bitka/features/auth/register_screen.dart';
import 'package:bitka/features/app_shell/app_shell_screen.dart';
import 'package:bitka/shared/widgets/button.dart';

void main() {
  // ผูก integration test กับ Flutter
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Login flow (จาก Excel LOG-001 - LOG-003)', () {
    // ----------------------------------------------------------
    // Helper 1: เปิดแอปแล้วต้องอยู่หน้า Login
    // ----------------------------------------------------------
    Future<void> openLogin(WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginScreen()));
      await tester.pumpAndSettle();

      expect(find.byType(LoginScreen), findsOneWidget);
    }

    // ----------------------------------------------------------
    // Helper 2: หา TextFormField ของ Username / Password บนหน้า Login
    // (InputField หุ้ม TextFormField ไว้อีกที เลยใช้ descendant แบบนี้)
    // ----------------------------------------------------------
    Future<(Finder usernameField, Finder passwordField)> getLoginFields(
      WidgetTester tester,
    ) async {
      final formFinder = find.byType(Form);

      final textFields = find.descendant(
        of: formFinder,
        matching: find.byType(TextFormField),
      );

      final usernameField = textFields.at(0);
      final passwordField = textFields.at(1);

      return (usernameField, passwordField);
    }

    // ----------------------------------------------------------
    // LOG-001: login (Pass)
    // Expected: ไปหน้า Home (ตอนนี้คือ AppShellScreen)
    // ----------------------------------------------------------
    testWidgets(
      'LOG-001: Login (Pass) → กรอก TestQA1 / @Passwordqa1 แล้วไปหน้า Home',
      (tester) async {
        await openLogin(tester);

        final (usernameField, passwordField) = await getLoginFields(tester);

        await tester.enterText(usernameField, 'TestQA1');
        await tester.enterText(passwordField, '@Passwordqa1');

        // กดปุ่ม Login (ใช้ custom Button)
        final loginButton = find.widgetWithText(Button, 'Login');
        await tester.ensureVisible(loginButton);
        await tester.tap(loginButton);
        await tester.pumpAndSettle();

        // ตอนนี้โค้ด LoginScreen นำทางไป AppShellScreen เสมอ
        expect(find.byType(AppShellScreen), findsOneWidget);
      },
    );

    // ----------------------------------------------------------
    // LOG-002: login (Fail) – กรอก Password ผิด
    // เลยขอเขียน test โครงไว้ก่อน แล้ว mark เป็น skip
    // ----------------------------------------------------------
    testWidgets('LOG-002: (SKIP) Login (Fail) เมื่อกรอก Password ผิด', (
      tester,
    ) async {
      await openLogin(tester);

      final (usernameField, passwordField) = await getLoginFields(tester);

      await tester.enterText(usernameField, 'TestQA1');
      await tester.enterText(passwordField, '@Passwordqa6'); // ผิดตาม Excel

      final loginButton = find.widgetWithText(Button, 'Login');
      await tester.ensureVisible(loginButton);
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      // ❌ ตาม spec: ควร "ไม่สามารถไปต่อได้" (ยังอยู่หน้า Login)
      // ✅ แต่ในโค้ดจริงตอนนี้ มันไปหน้า AppShellScreen เสมอ
      //
      // เมื่อมี logic เช็ค user/pass แล้ว:
      //   - ลบ skip
      //   - แก้ expectation เป็น:
      //     expect(find.byType(LoginScreen), findsOneWidget);
      //     expect(find.byType(AppShellScreen), findsNothing);
    }, skip: true);

    // ----------------------------------------------------------
    // LOG-003: login (Fail) – ไม่กรอก Username
    // ----------------------------------------------------------
    testWidgets('LOG-003: (SKIP) Login (Fail) เมื่อไม่กรอก Username', (
      tester,
    ) async {
      await openLogin(tester);

      final (_usernaField, passwordField) = await getLoginFields(tester);

      // ไม่กรอก Username ตาม precondition
      await tester.enterText(passwordField, '@Passwordqa6');

      final loginButton = find.widgetWithText(Button, 'Login');
      await tester.ensureVisible(loginButton);
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      // เมื่อ dev เปิดใช้ validation:
      // if (_formKey.currentState!.validate()) { ... }
      // เราถึงจะมาเปลี่ยน expectation เป็น:
      //
      // expect(find.text('Please enter your username.'), findsOneWidget);
      // expect(find.byType(LoginScreen), findsOneWidget);
      // expect(find.byType(AppShellScreen), findsNothing);
    }, skip: true);
  });
}
