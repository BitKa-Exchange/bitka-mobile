import 'package:bitka/features/app_shell/app_shell_screen.dart';
import 'package:bitka/shared/widgets/migrate/coin_card.dart';
import 'package:bitka/shared/widgets/migrate/coin_list.dart';
import 'package:bitka/shared/widgets/migrate/icon_card.dart';
import 'package:bitka/shared/widgets/migrate/detailed_dropdown.dart';
import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';


// --- Performance Card Models (for Wallet Value Section) ---
class PerformanceData {
  final double percentage;
  final double value;
  final List<double> chartData;

  PerformanceData({
    required this.percentage,
    required this.value,
    required this.chartData,
  });
}


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 160), // Space for Bottom Nav Bar
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // A. Header/Profile
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
            child: _ProfileHeader(),
          ),
          
          const SizedBox(height: 24),
          
          // B. Wallet Value Card
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: _WalletValueSection(),
          ),
          
          const SizedBox(height: 24),

          // C. Transaction Buttons
          const _TransactionSection(),
          
          const SizedBox(height: 24),

          // D. Coins List Header
          const Padding(
            padding: EdgeInsets.only(left: 32, right: 32, bottom: 20),
            child: Text(
              'Coins',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 24,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          
          // E. Horizontal Coin List
          const _CoinListPlaceholder(), 
        ],
      ),
    );
  }
}

// -------------------------------------------------------------------
// 4. Individual Reusable Components (Widgets from previous steps)
// -------------------------------------------------------------------

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      // Use MainAxisAlignment.spaceBetween to push the two items to the edges
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // 1. Logo Placeholder (Fixed size: 65x65 in original design, 
        // using your 134x134 but placed in a constrained container for safety)
        Container(
          width: 65,
          height: 50,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            // color: AppColors.primaryPink,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset(
            'assets/logo.png',
            fit: BoxFit.cover, // Ensure the image fits the 65x65 box
          ),
        ),

        const SizedBox(width: 16), // Add horizontal spacing between elements

        // 2. User Info/Dropdown Header (Fixed Width to prevent crash)
        SizedBox( // Use a SizedBox to constrain the width
          width: 216, // Use the width specified in the original design
          child: DetailedDropDown(
            title: 'Nattan Niparnee',
            description: '123-XXXX-1234',
          ),
        ),
      ],
    );
  }
}

// --- 4.2. Wallet Value Section (Performance Card) ---
class _WalletValueSection extends StatelessWidget {
  const _WalletValueSection();

  @override
  Widget build(BuildContext context) {
    final negativeTrend = [25.0, 20.0, 15.0, 8.0, 12.0, 10.0, 18.0, 14.0];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Wallet Value',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 24,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        
        // Performance Card Widget (Defined below)
        _PerformanceCard(
          width: MediaQuery.of(context).size.width - 64,
          data: PerformanceData(
            percentage: -92.0,
            value: 10293.01,
            chartData: negativeTrend,
          ),
        ),
      ],
    );
  }
}

// --- 4.3. Transaction Section ---
class _TransactionSection extends StatelessWidget {
  const _TransactionSection();

  Widget _buildTransactionCardWrapper(String label, IconData icon) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5), 
        child: IconCard(
          icon: icon,
          label: label,
          backgroundColor: AppColors.backgroundGradient2,
          iconColor: AppColors.surfaceBorderPrimary,
          onTap: () { 
            debugPrint('$label tapped!');
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      // Use surfacePrimary (20161A) based on color palette
      decoration: const BoxDecoration(
        color: AppColors.surfacePrimary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Transaction',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Use the new reusable _buildTransactionCardWrapper
              _buildTransactionCardWrapper('Deposit', Icons.arrow_downward_rounded),
              _buildTransactionCardWrapper('Withdraw', Icons.arrow_upward_rounded),
              _buildTransactionCardWrapper('Transfer', Icons.send_rounded),
              _buildTransactionCardWrapper('Buy', Icons.shopping_bag_outlined),
            ],
          ),
        ],
      ),
    );
  }
}

// --- 4.5. Performance Card (The Chart Card) ---
class _PerformanceCard extends StatelessWidget {
  final PerformanceData data;
  final double width;
  final double height;

  const _PerformanceCard({
    required this.data,
    this.width = 339,
    this.height = 124,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPositive = data.percentage >= 0;
    final Color trendColor = isPositive ? AppColors.utilityGreen : AppColors.utilityRed;
    final String sign = isPositive ? '+' : '';
    
    final String percentageText = '$sign${data.percentage.abs().toStringAsFixed(0)}%';
    final String valueText = '${data.value.toStringAsFixed(2)} THB';

    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: AppColors.backgroundCardDefault, // 0xFF2C2C2C
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Stack(
        children: [
          // Background Gradient
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0.90, 0.12),
                  radius: 2.72,
                  colors: [Color(0xFF1E1E1E), Color(0x001E1E1E)],
                ),
              ),
            ),
          ),
          
          // Chart Placeholder (Custom Painter logic can be embedded here if needed)
          _ChartPlaceholder(data: data.chartData, color: trendColor),

          // Data Text Overlay
          Positioned(
            left: 24,
            top: 13,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowColor,
                    blurRadius: 18.70,
                    offset: Offset(0, 0),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 9,
                children: [
                  Text(
                    percentageText,
                    style: TextStyle(
                      color: trendColor,
                      fontSize: 24,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                      height: 0.92,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: Icon(
                      isPositive ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                      color: trendColor,
                      size: 28,
                    ),
                  ),
                  Text(
                    valueText,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 24,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w800,
                      height: 1.30,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Chart Placeholder implementation (simplified)
class _ChartPlaceholder extends StatelessWidget {
  final List<double> data;
  final Color color;

  const _ChartPlaceholder({required this.data, required this.color});

  @override
  Widget build(BuildContext context) {
    // Replace this with actual line chart library if needed (e.g., fl_chart)
    return CustomPaint(
      size: const Size(double.infinity, double.infinity),
      painter: _SparklinePainter(data: data, color: color),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  final List<double> data;
  final Color color;

  _SparklinePainter({required this.data, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    if (data.length < 2) return;

    final Paint linePaint = Paint()
      ..color = color.withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final Path linePath = Path();
    double xStep = size.width / (data.length - 1);
    final double maxVal = data.reduce((a, b) => a > b ? a : b);
    final double minVal = data.reduce((a, b) => a < b ? a : b);
    final double range = maxVal - minVal;

    for (int i = 0; i < data.length; i++) {
      double x = i * xStep;
      double y = range == 0 ? size.height / 2 : size.height * (1 - (data[i] - minVal) / range);
      
      if (i == 0) {
        linePath.moveTo(x, y);
      } else {
        linePath.lineTo(x, y);
      }
    }
    canvas.drawPath(linePath, linePaint);
  }

  @override
  bool shouldRepaint(covariant _SparklinePainter oldDelegate) {
    return oldDelegate.data != data || oldDelegate.color != color;
  }
}

// -------------------------------------------------------------------
// 5. Coin List Component (Updated to use the new CryptoListContainer)
// -------------------------------------------------------------------

class _CoinListPlaceholder extends StatelessWidget {
  const _CoinListPlaceholder();

  // Helper function to generate a list of CoinCard widgets
  List<CoinCard> _getMockCoinCards() {
    // Define the mock data directly as a list of arguments for CoinCard
    final List<Map<String, dynamic>> mockData = [
      {
        'title': 'BNB',
        'icon': Container(color: Colors.white),
        'price': 388.92,
        'quantity': 0.03,
        'percent': 2.20,
        'priceCurrency': 'USD',
        'quantityCurrency': 'BNB',
      },
      {
        'title': 'ETH',
        'icon': Container(color: Colors.white),
        'price': 2500.50,
        'quantity': 0.5,
        'percent': -1.50,
        'priceCurrency': 'USD',
        'quantityCurrency': 'ETH',
      },
      {
        'title': 'XRP',
        'icon': Container(color: Colors.white),
        'price': 0.55,
        'quantity': 1000.0,
        'percent': 0.1,
        'priceCurrency': 'USD',
        'quantityCurrency': 'XRP',
      },
      {
        'title': 'ADA',
        'icon': Container(color: Colors.white),
        'price': 0.8,
        'quantity': 500.0,
        'percent': 3.5,
        'priceCurrency': 'USD',
        'quantityCurrency': 'ADA',
      },
      {
        'title': 'SOL',
        'icon': Container(color: Colors.white),
        'price': 150.00,
        'quantity': 2.5,
        'percent': 5.10,
        'priceCurrency': 'USD',
        'quantityCurrency': 'SOL',
      },
      {
        'title': 'DOGE',
        'icon': Container(color: Colors.white),
        'price': 0.20,
        'quantity': 10000.0,
        'percent': -0.50,
        'priceCurrency': 'USD',
        'quantityCurrency': 'DOGE',
      },
    ];

    // Map the mock data to CoinCard widgets
    return mockData.map((data) {
      return CoinCard(
        title: data['title'] as String,
        icon: data['icon'] as Widget,
        price: data['price'] as double,
        quantity: data['quantity'] as double,
        percent: data['percent'] as double,
        priceCurrency: data['priceCurrency'] as String,
        quantityCurrency: data['quantityCurrency'] as String,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // Generate the list of CoinCard widgets
    final List<CoinCard> coinCards = _getMockCoinCards();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      // Use the CoinList widget and pass the generated CoinCard children
      child: CoinList(children: coinCards),
    );
  }
}