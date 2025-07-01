// lib/screens/detail/widgets/center_panel.dart

import 'package:flutter/material.dart';
import 'package:gmgn_app/theme/app_colors.dart';
import 'package:gmgn_app/theme/app_text_styles.dart';
import 'package:gmgn_app/screens/detail/widgets/chart_widget.dart';

class CenterPanel extends StatefulWidget {
  const CenterPanel({super.key});

  @override
  State<CenterPanel> createState() => _CenterPanelState();
}

class _CenterPanelState extends State<CenterPanel> {
  double _topPanelHeight = 500.0;
  final double _minHeight = 300.0;
  final double _maxHeight = 700.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: _topPanelHeight,
          child: Column(
            children: [
              _buildTopPanelHeader(),
              Expanded(
                child: Row(
                  children: [
                    _buildChartLeftToolbar(),
                    const Expanded(child: ChartWidget()),
                  ],
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onVerticalDragUpdate: (details) {
            setState(() {
              final newHeight = _topPanelHeight + details.delta.dy;
              _topPanelHeight = newHeight.clamp(_minHeight, _maxHeight);
            });
          },
          child: MouseRegion(
            cursor: SystemMouseCursors.resizeUpDown,
            child: Container(
              height: 4,
              width: double.infinity,
              color: AppColors.border,
              child: const Center(),
            ),
          ),
        ),
        // **更新**: 这里替换为真实的活动列表UI
        Expanded(
          child: _buildBottomActivityPanel(),
        ),
      ],
    );
  }

  // --- **新增方法 START** ---

  // 构建底部活动面板
  Widget _buildBottomActivityPanel() {
    return Container(
      width: double.infinity,
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 第一行: 主功能标签页
          _buildActivityTabs(),
          // 第二行: 二级筛选标签
          _buildFilterPills(),
          // 第三行: 活动表格
          Expanded(child: _buildActivityTable()),
        ],
      ),
    );
  }

  // 构建主功能标签页
  // 构建主功能标签页
  Widget _buildActivityTabs() {
    return Container(
      height: 48,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border, width: 1.0)),
      ),
      // **更新**: Row 的内容已改变
      child: Row(
        children: [
          _buildMainTab("Activity", true),
          const SizedBox(width: 24),
          _buildMainTab("Positions", false),
          const SizedBox(width: 24),
          _buildMainTab("Holders 92", false),
          const SizedBox(width: 24),
          _buildMainTab("Traders", false),
          const SizedBox(width: 24),
          _buildMainTab("Tracking", false),
          const SizedBox(width: 24),
          _buildMainTab("Liquidity", false),
          const SizedBox(width: 24),
          _buildMainTab("Limit", false),
          const SizedBox(width: 24),
          _buildMainTab("Auto", false),
          const SizedBox(width: 24),
          _buildMainTab(
            "Dev Token",
            false,
            // 为 "Dev Token" 添加尾部图标
            trailingIcon: const Icon(Icons.arrow_upward, size: 14, color: AppColors.textSecondary),
          ),
          // "Instant trade" 按钮已根据新截图移除
        ],
      ),
    );
  }
  
  // **更新**: 完全重写此方法以匹配新样式
  Widget _buildMainTab(String text, bool isSelected, {Widget? trailingIcon}) {
    // 现在直接返回一个 TextButton，不再需要外部Container
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        // 移除按钮的默认内边距，以便我们可以精确控制
        padding: EdgeInsets.zero,
        minimumSize: const Size(50, 48), // 给按钮一个最小尺寸
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
              // 根据是否选中，改变颜色和字重
              color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
          if (trailingIcon != null) const SizedBox(width: 4),
          if (trailingIcon != null) trailingIcon,
        ],
      ),
    );
  }

  // 构建二级筛选标签
  Widget _buildFilterPills() {
    // **更新**: 将所有按钮包裹在一个带样式的Container中
    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: AppColors.cardBackground, // 深色背景
        borderRadius: BorderRadius.circular(12.0), // 圆角
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildPillButton("All", true),
            _buildPillButton("Smart", false),
            _buildPillButton("KOL/VC", false),
            _buildPillButton("Tracking", false),
            _buildPillButton("Remarks", false),
            _buildPillButton("DEV 1", false),
            _buildPillButton("Whale", false),
            _buildPillButton("Fresh 51", false),
            _buildPillButton("Snipers 17", false),
            _buildPillButton("Top 118", false),
            _buildPillButton("Insiders 1", false),
            _buildPillButton("Bundler 2", false),
          ],
        ),
      ),
    );
  }
  // **更新**: 完全重写此方法以匹配新样式
  Widget _buildPillButton(String text, bool isSelected) {
    // 使用 TextButton 以获得更灵活的样式控制
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        backgroundColor: isSelected ? AppColors.border.withOpacity(0.8) : Colors.transparent,
        foregroundColor: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: const TextStyle(fontWeight: FontWeight.w500)
      ),
      child: Text(text),
    );
  }
  // 构建活动表格
  Widget _buildActivityTable() {
    return Column(
      children: [
        _buildTableHeader(),
        Expanded(
          child: ListView.separated(
            itemCount: 20,
            itemBuilder: (context, index) => _buildTableRow(isSell: index.isEven),
            separatorBuilder: (context, index) => const Divider(color: AppColors.border, height: 1, thickness: 1),
          ),
        )
      ],
    );
  }

  Widget _buildTableHeader() {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildSortableHeaderItem("Age"),
          _buildSortableHeaderItem("Type"),
          _buildSortableHeaderItem("Total USD"),
          const Text("Amount", style: TextStyle(color: AppColors.textSecondary)),
          _buildSortableHeaderItem("Price"),
          _buildSortableHeaderItem("Maker"),
        ],
      ),
    );
  }

  Widget _buildSortableHeaderItem(String text) {
    return Row(
      children: [
        Text(text, style: const TextStyle(color: AppColors.textSecondary)),
        const SizedBox(width: 4),
        const Icon(Icons.filter_list, size: 14, color: AppColors.textSecondary)
      ],
    );
  }

  Widget _buildTableRow({required bool isSell}) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("6s", style: TextStyle(color: AppColors.textPrimary)),
          Text(isSell ? "Sell" : "Buy", style: TextStyle(color: isSell ? AppColors.downward : AppColors.pnlGreen)),
          const Text("\$6.27", style: TextStyle(color: AppColors.textPrimary)),
          const Text("1M", style: TextStyle(color: AppColors.textPrimary)),
          const Text("\$0.0,62361", style: TextStyle(color: AppColors.textPrimary)),
          const Row(
            children: [
              Text("5yBX...oGd", style: TextStyle(color: AppColors.textPrimary)),
              SizedBox(width: 8),
              Icon(Icons.person, size: 14, color: AppColors.textSecondary),
              Text("2", style: TextStyle(color: AppColors.textSecondary)),
            ],
          ),
        ],
      ),
    );
  }

  // --- **新增方法 END** ---

  // (文件其余部分代码保持不变...)
  Widget _buildTopPanelHeader() {
    return Container(height: 85.0, padding: const EdgeInsets.symmetric(horizontal: 16.0), decoration: const BoxDecoration(color: AppColors.background, border: Border(bottom: BorderSide(color: AppColors.border, width: 1.0))), child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [_buildHeaderLeft(), const Spacer(), _buildHeaderRight()]));
  }
  Widget _buildHeaderLeft() {
    return Row(children: [SizedBox(width: 48, height: 48, child: Stack(clipBehavior: Clip.none, children: [const Center(child: SizedBox(width: 48, height: 48, child: CircularProgressIndicator(value: 0.55, strokeWidth: 2, backgroundColor: AppColors.border, valueColor: AlwaysStoppedAnimation<Color>(AppColors.pnlGreen)))), const Center(child: CircleAvatar(radius: 20, backgroundColor: Colors.pink)), const Positioned(top: -2, left: -2, child: Icon(Icons.star, color: Colors.yellow, size: 16))])), const SizedBox(width: 12), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Text("FOREX", style: AppTextStyles.headline1.copyWith(fontSize: 20)), const SizedBox(width: 8), Text("FarmsStkhldrReturnsFVXoh...", style: AppTextStyles.listItemSubtitle)]), const SizedBox(height: 8), Row(children: [_buildSmallStat(Icons.person_outline, "55%"), const SizedBox(width: 8), _buildSmallStat(Icons.run_circle_outlined, "23m"), const SizedBox(width: 8), Text("Run 6FW...ump", style: AppTextStyles.listItemSubtitle), const SizedBox(width: 8), const Icon(Icons.copy, size: 14, color: AppColors.textSecondary), const SizedBox(width: 8)])])]);
  }
  Widget _buildHeaderRight() {
    return Row(children: [_buildDataPoint(value: "\$0.0,11825", label: "24h -128.25%", valueColor: AppColors.downward, prefixIcon: Icons.arrow_downward), const SizedBox(width: 24), _buildDataPoint(value: "6/70", label: "1.7 SOL", prefixIcon: Icons.shield_outlined, topLabel: "Snipers"), const SizedBox(width: 24), _buildDataPoint(topLabel: "Total Fees"), const SizedBox(width: 24), _buildDataPoint(value: "17%", topLabel: "Top 10"), const SizedBox(width: 24), _buildDataPoint(topLabel: "Audit", customValue: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: Colors.green.withOpacity(0.2), borderRadius: BorderRadius.circular(20)), child: const Text("✅ Safe: 4/4", style: TextStyle(color: AppColors.pnlGreen, fontSize: 12)))), const SizedBox(width: 24), _buildDataPoint(value: "Dex (1%)", topLabel: "Taxes")]);
  }
  Widget _buildSmallStat(IconData icon, String text) {
    return Row(children: [Icon(icon, size: 14, color: AppColors.textSecondary), const SizedBox(width: 4), Text(text, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13))]);
  }
  Widget _buildDataPoint({String? topLabel, String? value, String? label, Color? valueColor, IconData? prefixIcon, Widget? customValue}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [if (topLabel != null) Text(topLabel, style: AppTextStyles.listItemSubtitle), const SizedBox(height: 4), customValue ?? Row(children: [if (prefixIcon != null) Icon(prefixIcon, size: 16, color: valueColor ?? AppColors.textPrimary), if (prefixIcon != null && value != null) const SizedBox(width: 4), if (value != null) Text(value, style: TextStyle(color: valueColor ?? AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.bold))]), if (label != null) const SizedBox(height: 4), if (label != null) Text(label, style: TextStyle(color: valueColor ?? AppColors.textSecondary, fontSize: 13))]);
  }
  Widget _buildChartLeftToolbar() {
    return Container(width: 48, decoration: const BoxDecoration(border: Border(right: BorderSide(color: AppColors.border, width: 1.0))), child: ListView(children: [IconButton(onPressed: () {}, icon: const Icon(Icons.show_chart, color: AppColors.textSecondary, size: 20)), IconButton(onPressed: () {}, icon: const Icon(Icons.settings_input_svideo, color: AppColors.textSecondary, size: 20)), IconButton(onPressed: () {}, icon: const Icon(Icons.timeline, color: AppColors.textSecondary, size: 20)), IconButton(onPressed: () {}, icon: const Icon(Icons.text_fields, color: AppColors.textSecondary, size: 20)), IconButton(onPressed: () {}, icon: const Icon(Icons.gesture, color: AppColors.textSecondary, size: 20)), IconButton(onPressed: () {}, icon: const Icon(Icons.brush, color: AppColors.textSecondary, size: 20)), IconButton(onPressed: () {}, icon: const Icon(Icons.hexagon_outlined, color: AppColors.textSecondary, size: 20)), IconButton(onPressed: () {}, icon: const Icon(Icons.straighten_outlined, color: AppColors.textSecondary, size: 20)), IconButton(onPressed: () {}, icon: const Icon(Icons.calculate, color: AppColors.textSecondary, size: 20)), IconButton(onPressed: () {}, icon: const Icon(Icons.zoom_in, color: AppColors.textSecondary, size: 20)), IconButton(onPressed: () {}, icon: const Icon(Icons.visibility, color: AppColors.textSecondary, size: 20)), IconButton(onPressed: () {}, icon: const Icon(Icons.lock_outline, color: AppColors.textSecondary, size: 20)), IconButton(onPressed: () {}, icon: const Icon(Icons.delete_outline, color: AppColors.textSecondary, size: 20))]));
  }
  Widget _buildChartHeaderRow1() {
    return Container(height: 40, padding: const EdgeInsets.symmetric(horizontal: 8.0), decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border, width: 1.0))), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Row(children: [_buildTimeIntervalButton("1s", false), _buildTimeIntervalButton("30s", false), _buildTimeIntervalButton("1m", true), _buildTimeIntervalButton("4H", false), _buildTimeIntervalButton("1D", false), const Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary, size: 20), const VerticalDivider(color: AppColors.border, indent: 8, endIndent: 8), _buildChartControlButton(Icons.copy_all_outlined, "Multicharts"), const VerticalDivider(color: AppColors.border, indent: 8, endIndent: 8), _buildChartControlButton(Icons.functions, "fx"), const VerticalDivider(color: AppColors.border, indent: 8, endIndent: 8), _buildChartControlButton(Icons.flag_outlined, "Markers", showDropdown: true), const VerticalDivider(color: AppColors.border, indent: 8, endIndent: 8), const Text("Price / MC", style: TextStyle(color: AppColors.textSecondary, fontSize: 13)), const SizedBox(width: 16), const Text("USD / SOL", style: TextStyle(color: AppColors.textSecondary, fontSize: 13))]), Row(children: [IconButton(onPressed: () {}, icon: const Icon(Icons.camera_alt_outlined, color: AppColors.textSecondary, size: 18)), IconButton(onPressed: () {}, icon: const Icon(Icons.settings_outlined, color: AppColors.textSecondary, size: 18)), IconButton(onPressed: () {}, icon: const Icon(Icons.fullscreen, color: AppColors.textSecondary, size: 20))])]));
  }
  Widget _buildTimeIntervalButton(String text, bool isSelected) {
    return TextButton(onPressed: () {}, style: TextButton.styleFrom(backgroundColor: isSelected ? AppColors.cardBackground : Colors.transparent, foregroundColor: isSelected ? AppColors.textPrimary : AppColors.textSecondary, minimumSize: const Size(36, 30), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))), child: Text(text));
  }
  Widget _buildChartControlButton(IconData icon, String text, {bool showDropdown = false}) {
    return TextButton(onPressed: () {}, style: TextButton.styleFrom(foregroundColor: AppColors.textSecondary), child: Row(children: [Icon(icon, size: 16), const SizedBox(width: 8), Text(text), if (showDropdown) const SizedBox(width: 4), if (showDropdown) const Icon(Icons.keyboard_arrow_down, size: 20)]));
  }
}
