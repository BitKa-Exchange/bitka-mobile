import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bitka/features/auth/login_screen.dart';
import 'package:bitka/features/auth/register_screen.dart';
//แก้ path
import 'package:bitka/features/info/disclaimer.dart';
import 'package:bitka/features/app_shell/app_shell_screen.dart';

Future<void> openRegister(WidgetTester tester) async {
  await tester.pumpWidget(const MaterialApp(home: LoginScreen()));
  await tester.pumpAndSettle();

  // เริ่มต้นต้องอยู่หน้า Login
  expect(find.byType(LoginScreen), findsOneWidget);

  // กดปุ่ม Register → ไปหน้า RegisterScreen
  final registerBtn = find.text('Register');
  await tester.ensureVisible(registerBtn);
  await tester.tap(registerBtn);
  await tester.pumpAndSettle();

  // อยู่หน้า Register เรียบร้อย
  expect(find.byType(RegisterScreen), findsOneWidget);
}

/// helper: ติ๊ก Terms & Privacy ให้ครบทั้งคู่
Future<void> tapAllAgreements(WidgetTester tester) async {
  final termsText = find.text('I agree to the Terms of Service');
  final privacyText = find.text('I agree to the Privacy Policy');

  await tester.ensureVisible(termsText);
  await tester.tap(termsText);
  await tester.pumpAndSettle();

  await tester.ensureVisible(privacyText);
  await tester.tap(privacyText);
  await tester.pumpAndSettle();
}

void main() {
  group('Register flow (จาก Excel REG-001 - REG-007)', () {
    // ----------------------------------------------------------
    // Helper 2: กรอกฟอร์ม Register ให้ "ครบ + ถูกต้อง" แล้วกด Register
    // ----------------------------------------------------------
    Future<void> fillValidRegisterAndSubmit(WidgetTester tester) async {
      await openRegister(tester);

      final registerScreenFinder = find.byType(RegisterScreen);

      // หา TextFormField ทั้งหมดในหน้า Register
      final textFields = find.descendant(
        of: registerScreenFinder,
        matching: find.byType(TextFormField),
      );

      // ตามลำดับใน RegisterScreen: Username, Email, Password, Confirm-Password
      final usernameField = textFields.at(0);
      final emailField = textFields.at(1);
      final passwordField = textFields.at(2);
      final confirmField = textFields.at(3);

      // กรอกข้อมูลครบและถูกต้อง (ตาม Testcase: TestQA1)
      await tester.enterText(usernameField, 'TestQA1');
      await tester.enterText(emailField, 'TestQA1@gmail.com');
      await tester.enterText(passwordField, '@Passwordqa1');
      await tester.enterText(confirmField, '@Passwordqa1');

      // ✅ ติ๊ก Terms & Privacy ทั้งหมด
      await tapAllAgreements(tester);

      // กดปุ่ม Register (ตัวที่ 2 = ปุ่ม, ตัวที่ 1 = title)
      final registerTexts = find.descendant(
        of: registerScreenFinder,
        matching: find.text('Register'),
      );
      final registerButtonOnRegister = registerTexts.at(1);

      await tester.ensureVisible(registerButtonOnRegister);
      await tester.tap(registerButtonOnRegister);
      await tester.pumpAndSettle();
    }

    // ----------------------------------------------------------
    // REG-001: เปิด app เจอปุ่ม Register
    // ----------------------------------------------------------
    testWidgets('REG-001: เปิด app แล้วต้องเจอปุ่ม Register บนหน้า Login', (
      tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: LoginScreen()));
      await tester.pumpAndSettle();

      // Expected: มีปุ่ม "Register" ให้กด
      expect(find.text('Register'), findsOneWidget);
    });

    // ----------------------------------------------------------
    // REG-002: Create Account -> Disclaimer (Pass)
    // ----------------------------------------------------------
    testWidgets('REG-002: Create Account -> ไปหน้า Disclaimer (Pass)', (
      tester,
    ) async {
      await fillValidRegisterAndSubmit(tester);

      // Expected 1: ไม่มีข้อความ error validation ใด ๆ
      expect(find.text('Username is required.'), findsNothing);
      expect(find.text('Email is required.'), findsNothing);
      expect(find.text('Enter a valid email address.'), findsNothing);
      expect(
        find.text('Password must be at least 6 characters.'),
        findsNothing,
      );
      expect(find.text('Please confirm your password.'), findsNothing);
      expect(find.text('Passwords do not match.'), findsNothing);

      // Expected 2: ไปหน้า Disclaimer
      expect(find.byType(DisclaimerScreen), findsOneWidget);
    });

    // ----------------------------------------------------------
    // REG-003: Disclaimer (Pass)
    // ----------------------------------------------------------
    testWidgets('REG-003: Disclaimer (Pass) → กด Proceed แล้วไปหน้า Home', (
      tester,
    ) async {
      // Precondition จาก REG-002: ต้องมาถึงหน้า Disclaimer แล้ว
      await fillValidRegisterAndSubmit(tester);
      expect(find.byType(DisclaimerScreen), findsOneWidget);

      // กดปุ่ม Proceed
      final proceedButton = find.text('Proceed');
      await tester.ensureVisible(proceedButton);
      await tester.tap(proceedButton);
      await tester.pumpAndSettle();

      // Expected: ไปหน้า Home (AppShellScreen)
      expect(find.byType(AppShellScreen), findsOneWidget);
    });

    // ----------------------------------------------------------
    // REG-004: ขาด Username
    // ----------------------------------------------------------
    testWidgets('REG-004: ขาด Username → แสดง error "Username is required."', (
      tester,
    ) async {
      await openRegister(tester);

      final registerScreenFinder = find.byType(RegisterScreen);
      final textFields = find.descendant(
        of: registerScreenFinder,
        matching: find.byType(TextFormField),
      );

      final emailField = textFields.at(1);
      final passwordField = textFields.at(2);
      final confirmField = textFields.at(3);

      await tester.enterText(emailField, 'TestQA2@gmail.com');
      await tester.enterText(passwordField, '@Passwordqa2');
      await tester.enterText(confirmField, '@Passwordqa2');

      // ✅ ติ๊ก Terms & Privacy ทั้งหมด
      await tapAllAgreements(tester);

      // กดปุ่ม Register
      final registerTexts = find.descendant(
        of: registerScreenFinder,
        matching: find.text('Register'),
      );
      final registerButton = registerTexts.at(1);

      await tester.ensureVisible(registerButton);
      await tester.tap(registerButton);
      await tester.pumpAndSettle();

      // Expected: ขึ้นข้อความเตือน + ยังอยู่หน้า Register (ไม่สามารถไปต่อได้)
      expect(find.text('Username is required.'), findsOneWidget);
      expect(find.byType(RegisterScreen), findsOneWidget);
    });

    // ----------------------------------------------------------
    // REG-005: ขาด Email
    // ----------------------------------------------------------
    testWidgets('REG-005: ขาด Email → แสดง error "Email is required."', (
      tester,
    ) async {
      await openRegister(tester);

      final registerScreenFinder = find.byType(RegisterScreen);
      final textFields = find.descendant(
        of: registerScreenFinder,
        matching: find.byType(TextFormField),
      );

      final usernameField = textFields.at(0);
      // ข้าม emailField
      final passwordField = textFields.at(2);
      final confirmField = textFields.at(3);

      await tester.enterText(usernameField, 'TestQA3');
      await tester.enterText(passwordField, '@Passwordqa3');
      await tester.enterText(confirmField, '@Passwordqa3');

      // ✅ ติ๊ก Terms & Privacy ทั้งหมด
      await tapAllAgreements(tester);

      // กดปุ่ม Register
      final registerTexts = find.descendant(
        of: registerScreenFinder,
        matching: find.text('Register'),
      );
      final registerButton = registerTexts.at(1);

      await tester.ensureVisible(registerButton);
      await tester.tap(registerButton);
      await tester.pumpAndSettle();

      // Expected: error + ยังอยู่หน้า Register
      expect(find.text('Email is required.'), findsOneWidget);
      expect(find.byType(RegisterScreen), findsOneWidget);
    });

    // ----------------------------------------------------------
    // REG-006: ขาด Password
    // ----------------------------------------------------------
    testWidgets(
      'REG-006: ขาด Password → แสดง error "Password must be at least 6 characters."',
      (tester) async {
        await openRegister(tester);

        final registerScreenFinder = find.byType(RegisterScreen);
        final textFields = find.descendant(
          of: registerScreenFinder,
          matching: find.byType(TextFormField),
        );

        final usernameField = textFields.at(0);
        final emailField = textFields.at(1);
        final passwordField = textFields.at(2);
        final confirmField = textFields.at(3);

        await tester.enterText(usernameField, 'TestQA4');
        await tester.enterText(emailField, 'TestQA4@gmail.com');

        // ปล่อย password/confirm เป็นค่าว่าง
        await tester.enterText(passwordField, '');
        await tester.enterText(confirmField, '');

        // ✅ ติ๊ก Terms & Privacy ทั้งหมด
        await tapAllAgreements(tester);

        // กดปุ่ม Register
        final registerTexts = find.descendant(
          of: registerScreenFinder,
          matching: find.text('Register'),
        );
        final registerButton = registerTexts.at(1);

        await tester.ensureVisible(registerButton);
        await tester.tap(registerButton);
        await tester.pumpAndSettle();

        expect(
          find.text('Password must be at least 6 characters.'),
          findsOneWidget,
        );
        expect(find.byType(RegisterScreen), findsOneWidget);
      },
    );

    // ----------------------------------------------------------
    // REG-007: ขาด Confirm-Password
    // ----------------------------------------------------------
    testWidgets(
      'REG-007: ขาด Confirm-Password → แสดง error "Please confirm your password."',
      (tester) async {
        await openRegister(tester);

        final registerScreenFinder = find.byType(RegisterScreen);
        final textFields = find.descendant(
          of: registerScreenFinder,
          matching: find.byType(TextFormField),
        );

        final usernameField = textFields.at(0);
        final emailField = textFields.at(1);
        final passwordField = textFields.at(2);
        final confirmField = textFields.at(3);

        await tester.enterText(usernameField, 'TestQA5');
        await tester.enterText(emailField, 'TestQA5@gmail.com');
        await tester.enterText(passwordField, '@Passwordqa5');

        // ไม่กรอก confirm password
        await tester.enterText(confirmField, '');

        // ✅ ติ๊ก Terms & Privacy ทั้งหมด
        await tapAllAgreements(tester);

        // กดปุ่ม Register
        final registerTexts = find.descendant(
          of: registerScreenFinder,
          matching: find.text('Register'),
        );
        final registerButton = registerTexts.at(1);

        await tester.ensureVisible(registerButton);
        await tester.tap(registerButton);
        await tester.pumpAndSettle();

        expect(find.text('Please confirm your password.'), findsOneWidget);
        expect(find.byType(RegisterScreen), findsOneWidget);
      },
    );
  });

  // กลุ่ม REG-008 ขึ้นไป
  group('Register flow (จาก Excel REG-008 - REG-011)', () {
    // ----------------------------------------------------------
    // REG-008: ไม่ติ๊ก Terms
    // ----------------------------------------------------------
    testWidgets(
      'REG-008: ขาด Agree Term&Condition → debugPrint แจ้งว่าให้ยอมรับทุกเงื่อนไข',
      (tester) async {
        // Hook debugPrint ไว้เก็บ log
        final List<String> logs = [];
        final originalDebugPrint = debugPrint;
        addTearDown(() {
          debugPrint = originalDebugPrint;
        });
        debugPrint = (String? message, {int? wrapWidth}) {
          if (message != null) logs.add(message);
        };

        await openRegister(tester);

        final registerScreenFinder = find.byType(RegisterScreen);

        // หา TextFormField ทั้งหมดในหน้า Register
        final textFields = find.descendant(
          of: registerScreenFinder,
          matching: find.byType(TextFormField),
        );

        // Username, Email, Password, Confirm-Password
        final usernameField = textFields.at(0);
        final emailField = textFields.at(1);
        final passwordField = textFields.at(2);
        final confirmField = textFields.at(3);

        // กรอกข้อมูลครบและถูกต้อง
        await tester.enterText(usernameField, 'TestQA6');
        await tester.enterText(emailField, 'TestQA6@gmail.com');
        await tester.enterText(passwordField, '@Passwordqa6');
        await tester.enterText(confirmField, '@Passwordqa6');

        // ✅ ติ๊กเฉพาะ Privacy เท่านั้น (ไม่ติ๊ก Terms)
        final privacyText = find.text('I agree to the Privacy Policy');
        await tester.ensureVisible(privacyText);
        await tester.tap(privacyText);
        await tester.pumpAndSettle();

        // กดปุ่ม Register
        final registerTexts = find.descendant(
          of: registerScreenFinder,
          matching: find.text('Register'),
        );
        final registerButtonOnRegister = registerTexts.at(1);

        await tester.ensureVisible(registerButtonOnRegister);
        await tester.tap(registerButtonOnRegister);
        await tester.pumpAndSettle();

        // Expected 1: ไม่มี error จาก field validation ใดๆ
        expect(find.text('Username is required.'), findsNothing);
        expect(find.text('Email is required.'), findsNothing);
        expect(find.text('Enter a valid email address.'), findsNothing);
        expect(
          find.text('Password must be at least 6 characters.'),
          findsNothing,
        );
        expect(find.text('Please confirm your password.'), findsNothing);
        expect(find.text('Passwords do not match.'), findsNothing);

        // Expected 2: debugPrint เรื่อง agreement
        expect(
          logs.any(
            (m) => m.contains('Please agree to all terms and policies.'),
          ),
          isTrue,
          reason: 'ควรมี debugPrint: "Please agree to all terms and policies."',
        );

        expect(
          logs.any((m) => m.contains('Registration successful!')),
          isFalse,
          reason: 'ไม่ควรขึ้น Registration successful ในกรณีไม่ติ๊ก Terms',
        );
      },
    );

    // ----------------------------------------------------------
    // REG-009: ไม่ติ๊ก Privacy
    // ----------------------------------------------------------
    testWidgets(
      'REG-009: ขาด Agree Privacy → debugPrint แจ้งว่าให้ยอมรับทุกเงื่อนไข',
      (tester) async {
        final List<String> logs = [];
        final originalDebugPrint = debugPrint;
        addTearDown(() {
          debugPrint = originalDebugPrint;
        });
        debugPrint = (String? message, {int? wrapWidth}) {
          if (message != null) logs.add(message);
        };

        await openRegister(tester);

        final registerScreenFinder = find.byType(RegisterScreen);

        final textFields = find.descendant(
          of: registerScreenFinder,
          matching: find.byType(TextFormField),
        );

        final usernameField = textFields.at(0);
        final emailField = textFields.at(1);
        final passwordField = textFields.at(2);
        final confirmField = textFields.at(3);

        await tester.enterText(usernameField, 'TestQA7');
        await tester.enterText(emailField, 'TestQA7@gmail.com');
        await tester.enterText(passwordField, '@Passwordqa7');
        await tester.enterText(confirmField, '@Passwordqa7');

        // ✅ ติ๊กเฉพาะ Terms เท่านั้น (ไม่ติ๊ก Privacy)
        final termsText = find.text('I agree to the Terms of Service');
        await tester.ensureVisible(termsText);
        await tester.tap(termsText);
        await tester.pumpAndSettle();

        final registerTexts = find.descendant(
          of: registerScreenFinder,
          matching: find.text('Register'),
        );
        final registerButtonOnRegister = registerTexts.at(1);

        await tester.ensureVisible(registerButtonOnRegister);
        await tester.tap(registerButtonOnRegister);
        await tester.pumpAndSettle();

        // ไม่มี error จาก field validation
        expect(find.text('Username is required.'), findsNothing);
        expect(find.text('Email is required.'), findsNothing);
        expect(find.text('Enter a valid email address.'), findsNothing);
        expect(
          find.text('Password must be at least 6 characters.'),
          findsNothing,
        );
        expect(find.text('Please confirm your password.'), findsNothing);
        expect(find.text('Passwords do not match.'), findsNothing);

        // ควรเจอ debugPrint เรื่อง agreement
        expect(
          logs.any(
            (m) => m.contains('Please agree to all terms and policies.'),
          ),
          isTrue,
          reason: 'ควรมี debugPrint: "Please agree to all terms and policies."',
        );
        expect(
          logs.any((m) => m.contains('Registration successful!')),
          isFalse,
        );
      },
    );

    // ----------------------------------------------------------
    // REG-010: SKIP
    // ----------------------------------------------------------
    testWidgets(
      'REG-010: (SKIP) Create Account (Pass) พร้อม Referral Code ถูกต้อง',
      (tester) async {},
      skip: true,
    );

    // ----------------------------------------------------------
    // REG-011: SKIP
    // ----------------------------------------------------------
    testWidgets(
      'REG-011: (SKIP) Create Account (Fail) เมื่อ Referral Code ไม่ถูกต้อง',
      (tester) async {},
      skip: true,
    );
  });
}
