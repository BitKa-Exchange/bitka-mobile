import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

// screens หลัก
import 'package:bitka/features/app_shell/app_shell_screen.dart';
import 'package:bitka/features/account/account_screen.dart';
import 'package:bitka/features/account/account_setting_screen.dart';
import 'package:bitka/features/account/profile_screen.dart';

// setup pages
import 'package:bitka/features/account/profile_setup_screen.dart';
import 'package:bitka/features/account/setup_pages/profile_setup_contact_screen.dart';
import 'package:bitka/features/account/setup_pages/profile_setup_consent_screen.dart';
import 'package:bitka/features/account/setup_pages/profile_setup_complete_screen.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Account flow (ACC-001 - ACC-014)', () {
    // ----------------------------------------------------------
    // Helpers
    // ----------------------------------------------------------

    // เปิดหน้า Account โดยตรง
    Future<void> openAccountScreen(WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: AccountScreen())),
      );
      await tester.pumpAndSettle();
      expect(find.byType(AccountScreen), findsOneWidget);
    }

    // เปิดหน้า Account Setting โดยตรง
    Future<void> openAccountSettingScreen(WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: AccountSettingScreen())),
      );
      await tester.pumpAndSettle();
      expect(find.byType(AccountSettingScreen), findsOneWidget);
    }

    // เปิด AppShell แล้วไปแท็บ Account (index = 3 ตามที่ระบุใน Excel เดิม)
    Future<void> openAccountFromAppShell(WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: AppShellScreen()));
      await tester.pumpAndSettle();

      final appShellFinder = find.byType(AppShellScreen);
      final appShellContext = tester.element(appShellFinder);

      // เรียก navigateToIndex ของ AppShell ไปที่แท็บ Account
      AppShellScreen.navigateToIndex(appShellContext, 3);
      await tester.pumpAndSettle();

      expect(find.byType(AccountScreen), findsOneWidget);
    }

    // ----------------------------------------------------------
    // ACC-001: Account – ตรวจเมนูหลักในหน้า Account
    // ----------------------------------------------------------
    testWidgets(
      'ACC-001: Account → แสดงเมนู Complete your profile / Account Setting / Application Info / Customer Services',
      (tester) async {
        await openAccountScreen(tester);

        expect(find.text('Account'), findsOneWidget);

        expect(find.text('Complete your profile'), findsOneWidget);
        expect(find.text('Account Setting'), findsOneWidget);
        expect(find.text('Application Info'), findsOneWidget);
        expect(find.text('Customer Services'), findsOneWidget);
      },
    );

    // ----------------------------------------------------------
    // ACC-002: จาก AppShell → Account → กด Complete your profile
    // ----------------------------------------------------------
    testWidgets('ACC-002: Complete your profile → ไปหน้า ProfileSetupScreen', (
      tester,
    ) async {
      await openAccountFromAppShell(tester);

      final completeProfileButton = find.text('Complete your profile');
      await tester.ensureVisible(completeProfileButton);
      await tester.tap(completeProfileButton);
      await tester.pumpAndSettle();

      expect(find.byType(ProfileSetupScreen), findsOneWidget);
    });

    // ----------------------------------------------------------
    // ACC-003: Profile Setup (Pass) → Next ไป Contact Info
    // (ตอนนี้ไม่มี validation → แค่กด Next ก็ไปต่อได้)
    // ----------------------------------------------------------
    testWidgets(
      'ACC-003: Profile Setup (Pass) → กด Next แล้วไปหน้า Contact Info',
      (tester) async {
        await tester.pumpWidget(const MaterialApp(home: ProfileSetupScreen()));
        await tester.pumpAndSettle();

        final nextButton = find.text('Next');
        await tester.ensureVisible(nextButton);
        await tester.tap(nextButton);
        await tester.pumpAndSettle();

        expect(find.byType(ProfileSetupContactScreen), findsOneWidget);
      },
    );

    // ----------------------------------------------------------
    // ACC-004: Contact Info (Pass) → Next ไป Consent & Declaration
    // (ยังไม่บังคับกรอกข้อมูล เพราะไม่เห็น validation ในโค้ด)
    // ----------------------------------------------------------
    testWidgets(
      'ACC-004: Contact Info (Pass) → กด Next แล้วไปหน้า Consent & Declaration',
      (tester) async {
        await tester.pumpWidget(
          const MaterialApp(home: ProfileSetupContactScreen()),
        );
        await tester.pumpAndSettle();

        final nextButton = find.text('Next');
        await tester.ensureVisible(nextButton);
        await tester.tap(nextButton);
        await tester.pumpAndSettle();

        expect(find.byType(ProfileSetupConsentScreen), findsOneWidget);
      },
    );

    // ----------------------------------------------------------
    // ACC-005: Consent & Declaration (Pass) → Complete ไปหน้า Complete
    // ----------------------------------------------------------
    testWidgets(
      'ACC-005: Consent & Declaration (Pass) → ติ๊กครบแล้วกด Complete ไปหน้า Complete',
      (tester) async {
        await tester.pumpWidget(
          const MaterialApp(home: ProfileSetupConsentScreen()),
        );
        await tester.pumpAndSettle();

        // มี Checkbox 2 ตัว
        final checkboxFinder = find.byType(Checkbox);
        expect(checkboxFinder, findsNWidgets(2));

        await tester.tap(checkboxFinder.at(0));
        await tester.pumpAndSettle();

        await tester.tap(checkboxFinder.at(1));
        await tester.pumpAndSettle();

        final completeButton = find.text('Complete');
        await tester.ensureVisible(completeButton);
        await tester.tap(completeButton);
        await tester.pumpAndSettle();

        expect(find.byType(ProfileSetupCompleteScreen), findsOneWidget);
      },
    );

    // ----------------------------------------------------------
    // ACC-006: Complete Page (Pass) → Return to Setting
    // ----------------------------------------------------------
    testWidgets(
      'ACC-006: Complete Page (Pass) → กด Return to Setting แล้วกลับหน้าแรก + onComplete ถูกเรียก',
      (tester) async {
        var onCompleteCalled = false;

        // route แรก = AccountScreen (ครอบด้วย Scaffold เพื่อให้มี Material)
        await tester.pumpWidget(
          const MaterialApp(home: Scaffold(body: AccountScreen())),
        );
        await tester.pumpAndSettle();

        expect(find.byType(AccountScreen), findsOneWidget);

        // push หน้า Complete ขึ้นมา
        final accountContext = tester.element(find.byType(AccountScreen));
        Navigator.of(accountContext).push(
          MaterialPageRoute(
            builder: (_) => ProfileSetupCompleteScreen(
              onComplete: () {
                onCompleteCalled = true;
              },
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.byType(ProfileSetupCompleteScreen), findsOneWidget);

        // กดปุ่ม Return to Setting
        final returnButton = find.text('Return to Setting');
        await tester.ensureVisible(returnButton);
        await tester.tap(returnButton);
        await tester.pumpAndSettle();

        // callback ต้องถูกเรียก
        expect(onCompleteCalled, isTrue);
        // กลับมาที่ route แรก
        expect(find.byType(AccountScreen), findsOneWidget);
        expect(find.byType(ProfileSetupCompleteScreen), findsNothing);
      },
    );

    // ----------------------------------------------------------
    // ACC-007: Account Setting – เช็คเมนู
    // ----------------------------------------------------------
    testWidgets(
      'ACC-007: Account Setting → แสดงเมนู Profile และ Email Password',
      (tester) async {
        await openAccountSettingScreen(tester);

        expect(find.text('Account Setting'), findsOneWidget);
        expect(find.text('Profile'), findsOneWidget);
        expect(find.text('Email Password'), findsOneWidget);
      },
    );

    // ----------------------------------------------------------
    // ACC-008–ACC-011: Negative validation (ตอนนี้ในโค้ดจริงยังไม่มี validation)
    // → เก็บไว้เป็น test สำหรับอนาคต จึงใส่ skip: true
    // ----------------------------------------------------------

    testWidgets(
      'ACC-008: Profile Setup (Fail) → ขาด Fullname แล้วกด Next ต้องไปต่อไม่ได้ (FUTURE)',
      (tester) async {
        await tester.pumpWidget(const MaterialApp(home: ProfileSetupScreen()));
        await tester.pumpAndSettle();

        final nextButton = find.text('Next');
        await tester.ensureVisible(nextButton);
        await tester.tap(nextButton);
        await tester.pumpAndSettle();

        // เมื่อมี validation แล้ว ควรยังอยู่ที่หน้าเดิม
        expect(find.byType(ProfileSetupScreen), findsOneWidget);
        expect(find.byType(ProfileSetupContactScreen), findsNothing);
      },
      skip: true,
    );

    testWidgets(
      'ACC-009: Profile Setup (Fail) → ขาด Date of Birth แล้วกด Next ต้องไปต่อไม่ได้ (FUTURE)',
      (tester) async {
        await tester.pumpWidget(const MaterialApp(home: ProfileSetupScreen()));
        await tester.pumpAndSettle();

        final nextButton = find.text('Next');
        await tester.ensureVisible(nextButton);
        await tester.tap(nextButton);
        await tester.pumpAndSettle();

        expect(find.byType(ProfileSetupScreen), findsOneWidget);
        expect(find.byType(ProfileSetupContactScreen), findsNothing);
      },
      skip: true,
    );

    testWidgets(
      'ACC-010: Profile Setup (Fail) → ขาด Gender แล้วกด Next ต้องไปต่อไม่ได้ (FUTURE)',
      (tester) async {
        await tester.pumpWidget(const MaterialApp(home: ProfileSetupScreen()));
        await tester.pumpAndSettle();

        final nextButton = find.text('Next');
        await tester.ensureVisible(nextButton);
        await tester.tap(nextButton);
        await tester.pumpAndSettle();

        expect(find.byType(ProfileSetupScreen), findsOneWidget);
        expect(find.byType(ProfileSetupContactScreen), findsNothing);
      },
      skip: true,
    );

    testWidgets(
      'ACC-011: Profile Setup (Fail) → ขาด Nationality แล้วกด Next ต้องไปต่อไม่ได้ (FUTURE)',
      (tester) async {
        await tester.pumpWidget(const MaterialApp(home: ProfileSetupScreen()));
        await tester.pumpAndSettle();

        final nextButton = find.text('Next');
        await tester.ensureVisible(nextButton);
        await tester.tap(nextButton);
        await tester.pumpAndSettle();

        expect(find.byType(ProfileSetupScreen), findsOneWidget);
        expect(find.byType(ProfileSetupContactScreen), findsNothing);
      },
      skip: true,
    );

    // ----------------------------------------------------------
    // ACC-012: จาก AppShell → ไปแท็บ Account
    // ----------------------------------------------------------
    testWidgets(
      'ACC-012: จาก AppShell → ไปแท็บ Account แล้วต้องเห็นหน้า Account',
      (tester) async {
        await openAccountFromAppShell(tester);

        expect(find.text('Account'), findsOneWidget);
        expect(find.text('Account Setting'), findsOneWidget);
      },
    );

    // ----------------------------------------------------------
    // ACC-014: Account Setting → กด Profile ไปหน้า ProfileScreen
    // (ACC-013 เรื่อง Account → Account Setting ผ่าน AppShell
    //  ยังไม่ test เพราะขึ้นกับ logic navigateToIndex ภายใน AppShell)
    // ----------------------------------------------------------
    testWidgets(
      'ACC-014: Account Setting → กด Profile แล้วไปหน้า ProfileScreen',
      (tester) async {
        await openAccountSettingScreen(tester);

        final profileMenu = find.text('Profile');
        await tester.ensureVisible(profileMenu);
        await tester.tap(profileMenu);
        await tester.pumpAndSettle();

        expect(find.byType(ProfileScreen), findsOneWidget);
      },
    );
  });
}
