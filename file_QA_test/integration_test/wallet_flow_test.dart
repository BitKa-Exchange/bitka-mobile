import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

// Screens
import 'package:bitka/features/app_shell/app_shell_screen.dart';
import 'package:bitka/features/wallet/wallet_screen.dart';
import 'package:bitka/features/wallet/deposit_screen.dart';
import 'package:bitka/features/wallet/withdraw_screen.dart';
import 'package:bitka/features/wallet/transfer_screen.dart';
import 'package:bitka/features/wallet/order_confirm_screen.dart';
import 'package:bitka/features/wallet/order_succeed_screen.dart';

// Shared widgets (ตาม path ในโปรเจกต์จริง)
import 'package:bitka/shared/widgets/performance_card.dart';
import 'package:bitka/shared/widgets/coin_list_mock.dart';
import 'package:bitka/shared/widgets/page_selector/wallet_history_control.dart';
import 'package:bitka/shared/widgets/custom_chip.dart';

// สำหรับเช็ค QR บน DepositScreen
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // -------------------------- Helpers --------------------------

  Future<void> pumpAppShell(WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: AppShellScreen()));
    await tester.pumpAndSettle();
    expect(find.byType(AppShellScreen), findsOneWidget);
  }

  Future<void> goToWalletTab(WidgetTester tester) async {
    final shellFinder = find.byType(AppShellScreen);
    final shellContext = tester.element(shellFinder);

    // ใน AppShellScreen: _pages[1] = WalletScreen
    AppShellScreen.navigateToIndex(shellContext, 1);
    await tester.pumpAndSettle();

    expect(find.byType(WalletScreen), findsOneWidget);
  }

  /// เปลี่ยนจาก History → Wallet view ผ่าน callback ของ WalletHistoryControl
  Future<void> switchToWalletView(WidgetTester tester) async {
    final control = tester.widget<WalletHistoryControl>(
      find.byType(WalletHistoryControl),
    );

    control.onSelectionChanged(SegmentedControlOption.wallet);
    await tester.pumpAndSettle();
  }

  OrderConfirmScreen buildSampleOrderConfirm() {
    return OrderConfirmScreen(
      transferorName: 'Nattan Niparnee',
      transferorId: '123-XXXX-1234',
      transferredTitle: 'BTC',
      transferredCurrency: 'BTC',
      transferredAmount: 0.12,
      transferredValue: 8000,
      valueCurrency: 'THB',
      namedReceiver: (name: 'TestQA7', id: '987-XXXX-0000'),
    );
  }

  OrderSucceedScreen buildSampleOrderSucceed() {
    return OrderSucceedScreen(
      transferorName: 'Nattan Niparnee',
      transferorId: '123-XXXX-1234',
      transferredTitle: 'BTC',
      transferredCurrency: 'BTC',
      transferredAmount: 0.12,
      valueAmount: 8000,
      valueCurrency: 'THB',
      feeAmount: 0.001,
      feeCurrency: 'BTC',
      feeValueAmount: 100,
      feeValueCurrency: 'THB',
      transactionId: 'TX123456789',
      datetime: DateTime.utc(2025, 11, 16, 10, 30, 0),
      namedReceiver: (name: 'TestQA7', id: '987-XXXX-0000'),
    );
  }

  // ----------------------- WAL Testcases -----------------------

  group('Wallet flow (WAL-001 – WAL-019)', () {
    // WAL-001: Basic Wallet UI
    testWidgets(
      'WAL-001: เปิดแท็บ Wallet จาก AppShell → เห็นหัวข้อ Transaction และ Wallet Value card',
      (tester) async {
        await pumpAppShell(tester);
        await goToWalletTab(tester);

        expect(find.text('Transaction'), findsOneWidget);
        expect(find.byType(PerformanceCard), findsOneWidget);
      },
    );

    // WAL-002: Wallet -> Deposit
    testWidgets(
      'WAL-002: บนหน้า Wallet กดปุ่ม Deposit แล้วไปหน้า DepositScreen',
      (tester) async {
        await pumpAppShell(tester);
        await goToWalletTab(tester);

        final depositButton = find.text('Deposit');
        expect(depositButton, findsOneWidget);

        await tester.tap(depositButton);
        await tester.pumpAndSettle();

        expect(find.byType(DepositScreen), findsOneWidget);
      },
    );

    // WAL-003: Wallet -> Withdraw
    testWidgets(
      'WAL-003: บนหน้า Wallet กดปุ่ม Withdraw แล้วไปหน้า WithdrawScreen',
      (tester) async {
        await pumpAppShell(tester);
        await goToWalletTab(tester);

        final withdrawButton = find.text('Withdraw');
        expect(withdrawButton, findsOneWidget);

        await tester.tap(withdrawButton);
        await tester.pumpAndSettle();

        expect(find.byType(WithdrawScreen), findsOneWidget);
      },
    );

    // WAL-004: Wallet -> Transfer
    testWidgets(
      'WAL-004: บนหน้า Wallet กดปุ่ม Transfer แล้วไปหน้า TransferScreen',
      (tester) async {
        await pumpAppShell(tester);
        await goToWalletTab(tester);

        final transferButton = find.text('Transfer');
        expect(transferButton, findsOneWidget);

        await tester.tap(transferButton);
        await tester.pumpAndSettle();

        expect(find.byType(TransferScreen), findsOneWidget);
      },
    );

    // WAL-005: Wallet -> Buy (ยังไม่มี flow จริง)
    testWidgets(
      'WAL-005: บนหน้า Wallet กดปุ่ม Buy (ตอนนี้ยังไม่มี navigation) → ยังอยู่หน้า Wallet',
      (tester) async {
        await pumpAppShell(tester);
        await goToWalletTab(tester);

        final buyButton = find.text('Buy');
        expect(buyButton, findsOneWidget);

        await tester.tap(buyButton);
        await tester.pumpAndSettle();

        expect(find.byType(WalletScreen), findsOneWidget);
      },
    );

    // WAL-006: Deposit Screen – แสดง QR และ Address
    testWidgets(
      'WAL-006: Deposit Screen → มี QR Code และช่อง Address ให้ copy ได้',
      (tester) async {
        await tester.pumpWidget(const MaterialApp(home: DepositScreen()));
        await tester.pumpAndSettle();

        // QR code แสดงด้วย QrImageView
        expect(find.byType(QrImageView), findsOneWidget);

        // มีหัวข้อ Address + ไอคอน copy
        expect(find.text('Address'), findsOneWidget);
        expect(find.byIcon(Icons.copy), findsOneWidget);
      },
    );

    // WAL-007: Withdraw Screen – ป้อนข้อมูล + Next กลับ AppShell
    testWidgets(
      'WAL-007: Withdraw Screen → กดปุ่ม Next แล้วไปหน้า AppShellScreen',
      (tester) async {
        await tester.pumpWidget(const MaterialApp(home: WithdrawScreen()));
        await tester.pumpAndSettle();

        // เช็คว่ามีหัวข้อหลัก ๆ
        expect(find.text('Withdraw'), findsOneWidget);
        expect(find.text('Receiver'), findsOneWidget);
        expect(find.text('Equivalent to'), findsOneWidget);

        final nextButton = find.text('Next');
        expect(nextButton, findsOneWidget);

        await tester.tap(nextButton);
        await tester.pumpAndSettle();

        // ตามโค้ดปัจจุบัน Next → AppShellScreen
        expect(find.byType(AppShellScreen), findsOneWidget);
      },
    );

    // WAL-008: Transfer Screen – ป้อน Address แล้ว Next กลับ AppShell
    testWidgets(
      'WAL-008: Transfer Screen → กดปุ่ม Next แล้วไปหน้า AppShellScreen',
      (tester) async {
        await tester.pumpWidget(const MaterialApp(home: TransferScreen()));
        await tester.pumpAndSettle();

        // UI หลัก
        expect(find.text('Transfer'), findsOneWidget);
        expect(find.text('Transferor'), findsOneWidget);
        expect(find.text('Receiver'), findsOneWidget);
        expect(find.text('Amount'), findsOneWidget);
        expect(find.text('Address'), findsOneWidget);

        final nextButton = find.text('Next');
        expect(nextButton, findsOneWidget);

        await tester.tap(nextButton);
        await tester.pumpAndSettle();

        expect(find.byType(AppShellScreen), findsOneWidget);
      },
    );

    // WAL-009: ฟีเจอร์เชิง validation/QR (ยังไม่ implement) → ทำ skeleton + skip
    testWidgets(
      'WAL-009: (SKIP) Validation/QR บน Transfer/Withdraw/Deposit (Amount, Address ผิดเงื่อนไข)',
      (tester) async {
        // TODO: เติม test เมื่อมี rule validation ชัดเจน
        // เช่น กรอก Amount = 0 หรือปล่อย Address ว่าง แล้วแสดง error / ปุ่มกดไม่ได้
      },
      skip: true,
    );

    // WAL-010: Order Confirmation – basic UI
    testWidgets(
      'WAL-010: Order Confirmation → แสดง Transferor / Receiver / ปุ่ม Confirm / Cancel / Edit',
      (tester) async {
        await tester.pumpWidget(MaterialApp(home: buildSampleOrderConfirm()));
        await tester.pumpAndSettle();

        expect(find.text('Order Confirmation'), findsOneWidget);
        expect(find.text('Transferor'), findsOneWidget);
        expect(find.text('Receiver'), findsOneWidget);
        expect(find.text('Confirm Transfer'), findsOneWidget);
        expect(find.text('Cancel Order'), findsOneWidget);
        expect(find.text('Edit Order'), findsOneWidget);
      },
    );

    // WAL-011: Confirm Transfer → ตาม Excel น่าจะต้องไปหน้า Order Succeed
    // แต่โค้ดตอนนี้ยังไม่ได้ทำ navigation → ถือว่ายังไม่สมบูรณ์ → skip ไว้ก่อน
    testWidgets(
      'WAL-011: (SKIP) กด Confirm Transfer แล้วไปหน้า Order SucceedScreen',
      (tester) async {
        // TODO: เมื่อปุ่ม Confirm Transfer มี onPressed แล้ว push ไป OrderSucceedScreen
      },
      skip: true,
    );

    // WAL-012: Order Succeed – แสดงข้อมูลธุรกรรม
    testWidgets(
      'WAL-012: Order Succeed → แสดง Transferor / Amount / Withdraw Fee / Transaction ID / Date',
      (tester) async {
        await tester.pumpWidget(MaterialApp(home: buildSampleOrderSucceed()));
        await tester.pumpAndSettle();

        // title appbar
        expect(find.text('Order Confirmation'), findsOneWidget);

        expect(find.text('Transferor'), findsOneWidget);
        expect(find.text('Amount'), findsOneWidget);
        expect(find.text('Withdraw Fee'), findsOneWidget);
        expect(find.text('Transaction ID '), findsOneWidget);
        expect(find.text('Save Picture'), findsOneWidget);
        expect(find.text('Return'), findsOneWidget);
      },
    );

    // WAL-013: Return จาก Order Succeed → pop กลับหน้าก่อน
    testWidgets('WAL-013: Order Succeed → กดปุ่ม Return แล้วกลับหน้าก่อนหน้า', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              return Scaffold(
                body: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => buildSampleOrderSucceed(),
                        ),
                      );
                    },
                    child: const Text('Go to Succeed'),
                  ),
                ),
              );
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      // ไปหน้า OrderSucceed ก่อน
      await tester.tap(find.text('Go to Succeed'));
      await tester.pumpAndSettle();
      expect(find.byType(OrderSucceedScreen), findsOneWidget);

      // กด Return
      final returnBtn = find.text('Return');
      await tester.tap(returnBtn);
      await tester.pumpAndSettle();

      expect(find.text('Go to Succeed'), findsOneWidget);
      expect(find.byType(OrderSucceedScreen), findsNothing);
    });

    // WAL-014: Cancel Order (Excel น่าจะให้ pop กลับ/เปลี่ยนหน้า) – โค้ดยังไม่ทำ → skip
    testWidgets(
      'WAL-014: (SKIP) Order Confirmation → กด Cancel Order แล้วกลับหน้าก่อนหน้า/ยกเลิกคำสั่ง',
      (tester) async {
        // TODO: เมื่อมี onPressed ของ Cancel Order ชัดเจนว่าต้อง pop หรือไปหน้าไหน
      },
      skip: true,
    );

    // WAL-015: Edit Order – น่าจะกลับไปแก้ข้อมูล Transfer → โค้ดตอนนี้ยังไม่ทำ → skip
    testWidgets(
      'WAL-015: (SKIP) Order Confirmation → กด Edit Order แล้วกลับไปหน้าแก้ Transaction',
      (tester) async {
        // TODO: เมื่อมีหน้า/flow สำหรับ Edit Order จริง
      },
      skip: true,
    );

    // WAL-016: Edit Order -> Confirm (flow วนกลับมาหน้า Order Confirm) → ยังไม่ implement
    testWidgets(
      'WAL-016: (SKIP) จากหน้า Edit Order → กลับมาหน้า Order Confirmation อีกครั้ง',
      (tester) async {
        // TODO: เมื่อมีหน้า Edit Order แยก และ flow กลับมาหน้า Order Confirm
      },
      skip: true,
    );

    // WAL-017: History view (default)
    testWidgets(
      'WAL-017: เปิดหน้า Wallet ครั้งแรก → โหมด History, มี filter และ Transaction ตามวันที่',
      (tester) async {
        await pumpAppShell(tester);
        await goToWalletTab(tester);

        expect(find.byType(WalletHistoryControl), findsOneWidget);

        // filter chips
        expect(find.text('This month'), findsOneWidget);
        expect(find.text('All network'), findsOneWidget);
        expect(find.byType(CustomChip), findsWidgets);

        // mock data ใน WalletScreen
        expect(find.text('16 November 2025'), findsOneWidget);

        // History view ยังไม่แสดง PerformanceCard ของ wallet
        expect(find.byType(PerformanceCard), findsNothing);
      },
    );

    // WAL-018: Wallet view
    testWidgets(
      'WAL-018: สลับจาก History → Wallet view แล้วเห็น Wallet Value card + Coins + ปุ่ม Transaction',
      (tester) async {
        await pumpAppShell(tester);
        await goToWalletTab(tester);

        await switchToWalletView(tester);

        expect(find.byType(PerformanceCard), findsOneWidget);
        expect(find.text('Transaction'), findsOneWidget);
        expect(find.text('Coins'), findsOneWidget);
        expect(find.byType(CoinListMock), findsOneWidget);

        expect(find.text('This month'), findsNothing);
        expect(find.text('All network'), findsNothing);
      },
    );

    // WAL-019: เดิม Excel เป็นฟอร์ม Transfer ใน Wallet (Amount/Address + Next)
    testWidgets(
      'WAL-019: (SKIP) ฟอร์ม Transfer ภายใน Wallet (Amount / Address / Next ภายใน WalletScreen)',
      (tester) async {
        // TODO: เพิ่มใหม่ถ้าในอนาคตมีฟอร์ม Transfer อยู่ใน WalletScreen อีกครั้ง
      },
      skip: true,
    );
  });
}
