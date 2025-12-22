import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// ---------------------- Import Widgets ตาม Path จริง ----------------------
import 'package:bitka/features/home/home_screen.dart';
import 'package:bitka/features/app_shell/app_shell_screen.dart';

import 'package:bitka/features/wallet/deposit_screen.dart';
import 'package:bitka/features/wallet/withdraw_screen.dart';
import 'package:bitka/features/wallet/transfer_screen.dart';
import 'package:bitka/features/wallet/wallet_screen.dart';

import 'package:bitka/shared/widgets/detailed_dropdown.dart';
import 'package:bitka/shared/widgets/performance_card.dart';
import 'package:bitka/shared/widgets/coin_list_mock.dart';
import 'package:bitka/shared/widgets/icon_card.dart';

void main() {
  // HOM-001 skip
  group("HOM-002 PerformanceCard Test", () {
    testWidgets('HOM-002: Page Wallet → กด icon wallet → ไปหน้า Wallet', (
      tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
      await tester.pumpAndSettle();

      final walletIcon = find.byIcon(Icons.wallet);
      await tester.tap(walletIcon);
      await tester.pumpAndSettle();

      expect(find.byType(WalletScreen), findsOneWidget);
    });
  });

  // -------------------------------------------------------------------------

  group("HOM-003 CoinListMock Test", () {
    testWidgets('CoinListMock loads 6 mock coins', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: CoinListMock()));

      const coins = ["BNB", "ETH", "XRP", "ADA", "SOL", "DOGE"];

      for (final name in coins) {
        expect(find.text(name), findsOneWidget);
      }
    });
  });

  // -------------------------------------------------------------------------

  group("HOM-004 to HOM-007 BottomNav Navigation", () {
    Future<void> openShell(WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: AppShellScreen()));
      await tester.pumpAndSettle();
    }

    testWidgets('HOM-002 -> Navigate to Wallet', (tester) async {
      await openShell(tester);

      await tester.tap(find.byIcon(Icons.wallet));
      await tester.pumpAndSettle();

      expect(find.byType(WalletScreen), findsOneWidget);
    });

    testWidgets('HOM-003 -> Navigate to Trade (Center page)', (tester) async {
      await openShell(tester);

      await tester.tap(find.byIcon(Icons.currency_exchange));
      await tester.pumpAndSettle();

      expect(find.text("Trade Screen"), findsOneWidget);
    });

    testWidgets('HOM-004 -> Navigate to Account', (tester) async {
      await openShell(tester);

      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      expect(find.text("Account"), findsWidgets);
    });
  });

  // -------------------------------------------------------------------------

  group("HOM-006 Navigation to Withdraw", () {
    testWidgets('Tap Withdraw navigates to WithdrawScreen', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
      await tester.pumpAndSettle();

      await tester.tap(find.text("Withdraw"));
      await tester.pumpAndSettle();

      expect(find.byType(WithdrawScreen), findsOneWidget);
    });
  });

  // -------------------------------------------------------------------------

  group("HOM-007 Navigation to Transfer", () {
    testWidgets('Tap Transfer navigates to TransferScreen', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
      await tester.pumpAndSettle();

      await tester.tap(find.text("Transfer"));
      await tester.pumpAndSettle();

      expect(find.byType(TransferScreen), findsOneWidget);
    });
  });
}
