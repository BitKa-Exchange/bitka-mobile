import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:bitka/core/theme/app_colors.dart';

// --- 1. Data Model for the Card (Unchanged) ---
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

// --- 2. The Reusable Chart Card Component (PerformanceCard) ---
class PerformanceCard extends StatelessWidget {
  final PerformanceData data;

  const PerformanceCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final double cardWidth = MediaQuery.of(context).size.width - 64; 
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: cardWidth,
          height: 120, // Fixed height for the card
          // Removed padding here to prevent extra space around the chart component,
          // though we still need space for the header.
          decoration: BoxDecoration(
            color: AppColors.backgroundCardDefault, 
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header needs its own padding
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                child: _buildHeader(context),
              ),
              const SizedBox(height: 8),
              
              // Chart area takes up the rest of the vertical space
              Expanded(
                // Use horizontal padding only for the chart line itself, 
                // which helps prevent the line cap from being clipped.
                child: _buildLineChart(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    final bool isPositive = data.percentage >= 0;
    final Color trendColor = isPositive ? AppColors.utilityGreen : AppColors.utilityRed;
    final String percentageText = '${isPositive ? '+' : ''}${data.percentage.toStringAsFixed(0)}%';
    final String valueText = '${data.value.toStringAsFixed(2)} THB';

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          percentageText,
          style: TextStyle(
            color: trendColor,
            fontSize: 20,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(width: 8),
        Icon(
          isPositive ? Icons.arrow_drop_up : Icons.arrow_drop_down,
          color: trendColor,
          size: 30,
        ),
        Text(
          valueText,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

// Helper method to build the LineChart using fl_chart
  Widget _buildLineChart() {
    final bool isPositive = data.percentage >= 0;
    final Color trendColor = isPositive ? AppColors.utilityGreen : AppColors.utilityRed;

    if (data.chartData.isEmpty) {
      return Container();
    }
    
    // Normalize data points
    final double minVal = data.chartData.reduce((a, b) => a < b ? a : b);
    final double maxVal = data.chartData.reduce((a, b) => a > b ? a : b);

    List<FlSpot> spots = data.chartData
        .asMap()
        .entries
        .map((entry) => FlSpot(entry.key.toDouble(), entry.value))
        .toList();
    
    // Set minX and maxX to exactly match the start (0) and end index of the data.
    // This tells fl_chart that the chart area spans exactly these bounds, 
    // eliminating implicit side padding.
    final double minX = 0;
    final double maxX = (data.chartData.length - 1).toDouble();

    return LineChart(
      LineChartData(
        // --- X-AXIS BOUNDS FOR EDGE-TO-EDGE COVERAGE ---
        minX: minX,
        maxX: maxX,
        minY: minVal * 0.95, 
        maxY: maxVal * 1.05, 
        
        gridData: const FlGridData(show: false),
        
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          
          // Reserved size must be zero to eliminate title padding
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false, reservedSize: 0.0),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false, reservedSize: 0.0),
          ),
        ),
        
        borderData: FlBorderData(show: false),
        
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true, 
            color: trendColor,
            barWidth: 3,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: trendColor.withOpacity(0.2), 
              gradient: LinearGradient(
                colors: [
                  trendColor.withOpacity(0.3),
                  trendColor.withOpacity(0.0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
        
        lineTouchData: const LineTouchData(enabled: false),
        
        // --- IMPORTANT: Set baseline padding to zero ---
        // This is often the final piece needed to make it truly edge-to-edge.
        extraLinesData: const ExtraLinesData(
          horizontalLines: [],
          verticalLines: [],
        ),
      ),
    );
  }
}
