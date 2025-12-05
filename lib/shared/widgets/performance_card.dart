import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

// 1. Data Model for the Card
class PerformanceData {
  final double percentage; // e.g., 67.0 or -92.0
  final double value; // e.g., 10293.01
  final List<double> chartData; // List of data points for the sparkline
  
  PerformanceData({
    required this.percentage,
    required this.value,
    required this.chartData,
  });
}

class PerformanceCard extends StatelessWidget {
  final PerformanceData data;
  final double width;
  final double height;

  const PerformanceCard({
    super.key,
    required this.data,
    this.width = 339,
    this.height = 124,
  });

  @override
  Widget build(BuildContext context) {
    // Determine the color based on the percentage sign
    final bool isPositive = data.percentage >= 0;
    final Color trendColor = isPositive ? AppColors.utilityGreen : AppColors.utilityRed;
    final String sign = isPositive ? '+' : '';
    
    // Format the text content
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
          // 2. Background Gradient (from original code, used as a subtle overlay)
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                // Use the RadialGradient provided in the original code
                gradient: RadialGradient(
                  center: Alignment(0.90, 0.12),
                  radius: 2.72,
                  colors: [Color(0xFF1E1E1E), Color(0x001E1E1E)],
                ),
              ),
            ),
          ),
          
          // 3. The Sparkline Chart (Mock element)
          // This positioned widget simulates the area where the actual line chart would sit.
          _ChartPlaceholder(
            data: data.chartData,
            color: trendColor,
          ),

          // 4. Data Text Overlay
          Positioned(
            left: 24, // Adjusted from 47 to give proper left padding
            top: 13,
            child: Container(
              // Using a Container to apply the shadow effect as in the original code
              decoration: BoxDecoration(
                boxShadow: [
                  const BoxShadow(
                    color: AppColors.shadowColor, // 0xFF000000 with 3F alpha
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
                  // Percentage Text
                  Text(
                    percentageText,
                    style: TextStyle(
                      color: trendColor, // Green or Red
                      fontSize: 24,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                      height: 0.92,
                    ),
                  ),
                  
                  // Trend Arrow Icon (Placeholder)
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: Icon(
                      isPositive ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                      color: trendColor,
                      size: 28, // Make the arrow look prominent
                    ),
                  ),
                  
                  // Total Value Text
                  Text(
                    valueText,
                    style: const TextStyle(
                      color: AppColors.textPrimary, // 0xFFF2F2F2
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

// --- Mock Chart Widget ---
// This is a simple visual representation of the line chart using a custom painter
class _ChartPlaceholder extends StatelessWidget {
  final List<double> data;
  final Color color;

  const _ChartPlaceholder({required this.data, required this.color});

  @override
  Widget build(BuildContext context) {
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

    final Paint fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [color.withOpacity(0.3), color.withOpacity(0.0)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final double maxVal = data.reduce((a, b) => a > b ? a : b);
    final double minVal = data.reduce((a, b) => a < b ? a : b);
    final double range = maxVal - minVal;
    
    // Create Path for the line
    final Path linePath = Path();
    // Create Path for the fill area
    final Path fillPath = Path();

    // Mapping logic
    double xStep = size.width / (data.length - 1);

    for (int i = 0; i < data.length; i++) {
      double x = i * xStep;
      // Map data value to vertical position (y-axis)
      // We reserve some vertical padding (e.g., 20 pixels)
      double y;
      if (range == 0) {
        y = size.height / 2;
      } else {
        y = size.height * (1 - (data[i] - minVal) / range);
      }
      
      if (i == 0) {
        linePath.moveTo(x, y);
        fillPath.moveTo(x, y);
      } else {
        linePath.lineTo(x, y);
        fillPath.lineTo(x, y);
      }
    }
    
    // Close the fill path at the bottom edge
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(linePath, linePaint);
  }

  @override
  bool shouldRepaint(covariant _SparklinePainter oldDelegate) {
    return oldDelegate.data != data || oldDelegate.color != color;
  }
}