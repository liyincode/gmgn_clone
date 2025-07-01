// lib/screens/detail/widgets/chart_widget.dart

import 'package:flutter/material.dart';
import 'package:gmgn_app/data/mock_data.dart';
import 'package:gmgn_app/theme/app_colors.dart';
import 'package:k_chart/flutter_k_chart.dart';

class ChartWidget extends StatefulWidget {
  const ChartWidget({super.key});

  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  List<KLineEntity>? _chartData;

  @override
  void initState() {
    super.initState();
    _chartData = MockData.getKLineData();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (_chartData != null)
          KChartWidget(
            _chartData!,
            ChartStyle(),
            ChartColors()
              ..upColor = AppColors.pnlGreen
              ..dnColor = AppColors.downward
              ..maxColor = Colors.white
              ..minColor = Colors.white
              ..kLineColor = Colors.white
              ..crossTextColor = Colors.white
              ..gridColor = AppColors.border
              ..lineFillColor = AppColors.primary.withOpacity(0.1)
              ..bgColor = [AppColors.background, AppColors.background],
            isLine: false,
            mainState: MainState.MA,
            secondaryState: SecondaryState.MACD,
            isTrendLine: false, 
          ),
        
        _buildChartOverlayInfo(),
      ],
    );
  }

  Widget _buildChartOverlayInfo() {
    return Positioned(
      top: 8,
      left: 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "FOREX/USD · 1 · GMGN.AI O:0.0,13268 H:0.0,13764 L:0.0,12526 C:0.0,12526 -0.0,74246 (-5.60%)",
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Text(
                "Volume",
                style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
              ),
              const SizedBox(width: 4),
              const Text(
                "576",
                style: TextStyle(color: AppColors.textPrimary, fontSize: 13),
              ),
              Container(
                margin: const EdgeInsets.only(left: 4),
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(4)
                ),
                child: const Icon(Icons.keyboard_arrow_down, size: 14, color: AppColors.textSecondary),
              )
            ],
          ),
        ],
      ),
    );
  }
}
