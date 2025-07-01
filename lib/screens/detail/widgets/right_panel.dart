// lib/screens/detail/widgets/right_panel.dart

import 'package:flutter/material.dart';
import 'package:gmgn_app/theme/app_colors.dart';
import 'package:gmgn_app/theme/app_text_styles.dart';
import 'package:gmgn_app/widgets/styled_text_field.dart';

class RightPanel extends StatelessWidget {
  const RightPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 6,
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return _buildFirstRowContent();
          case 1:
            return _buildSecondRowContent();
          case 2:
            return _buildThirdRowContent();
          case 3:
            return _buildFourthRowContent();
          case 4:
            return _buildFifthRowContent();
          case 5:
            // **更新**: 返回第六行的真实UI
            return _buildSixthRowContent();
          default:
            return const SizedBox.shrink(); // 不应该发生
        }
      },
      separatorBuilder: (context, index) {
        return const Divider(color: AppColors.border, height: 1, thickness: 1);
      },
    );
  }

  Widget _buildSixthRowContent() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          // 标题行
          Row(
            children: [
              Text(
                "Same Name Tokens",
                style: AppTextStyles.listItemTitle.copyWith(fontSize: 14),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.keyboard_arrow_up,
                color: AppColors.textSecondary,
              ),
              const Spacer(),
              const Text(
                "MC",
                style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.swap_horiz,
                color: AppColors.textSecondary,
                size: 18,
              ),
            ],
          ),
          const SizedBox(height: 16),
          // 代币信息卡片
          _buildSameNameTokenCard(),
          // 如果有更多同名Token，可以在这里继续添加
        ],
      ),
    );
  }

  // 辅助方法，创建同名Token信息卡片
  Widget _buildSameNameTokenCard() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          radius: 18,
          backgroundColor: Colors.blueAccent,
          child: Icon(Icons.query_stats, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("ForexLens", style: AppTextStyles.listItemTitle),
                      Text("Forex Lens", style: AppTextStyles.listItemSubtitle),
                    ],
                  ),
                  const Text(
                    "183d",
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                      children: const [
                        TextSpan(text: "TX: "),
                        TextSpan(
                          text: "1h",
                          style: TextStyle(color: AppColors.pnlGreen),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    "\$52.2K",
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- **新增**: 构建第四行内容的完整方法 ---
  Widget _buildFourthRowContent() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          // 标题行
          Row(
            children: [
              RichText(
                text: TextSpan(
                  style: const TextStyle(fontFamily: 'Inter'), // 确保字体一致
                  children: [
                    TextSpan(
                      text: "PUMP",
                      // 1. PUMP 字体大小为 14px
                      style: AppTextStyles.listItemTitle.copyWith(fontSize: 14),
                    ),
                    TextSpan(
                      text: " Pool info",
                      style: AppTextStyles.listItemTitle.copyWith(fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.keyboard_arrow_up,
                color: AppColors.textSecondary,
              ),
              const Spacer(),
              const Icon(Icons.sync_alt, color: AppColors.textSecondary),
            ],
          ),
          const SizedBox(height: 16),
          // 信息行
          _buildInfoRow(
            "Total liq",
            "\$799.65(2.68 SOL)",
            trailingWidget: const Icon(
              Icons.lock_outline,
              size: 14,
              color: AppColors.infoValue,
            ),
          ),
          _buildInfoRow("Market cap", "\$4.96K"),
          _buildInfoRow("Holders", "70"),
          _buildInfoRow("Total supply", "1000M"),
          _buildInfoRow(
            "Pair",
            "BzXP7...cxX",
            trailingWidget: const Icon(
              Icons.copy,
              size: 14,
              color: AppColors.infoValue,
            ),
          ),
          _buildInfoRow(
            "Token creator",
            "AJdav...e1s(169.86 SOL)",
            trailingWidget: const Icon(
              Icons.copy,
              size: 14,
              color: AppColors.infoValue,
            ),
          ),
          _buildInfoRow("Pool created", "07/01/2025 15:04:04"),
        ],
      ),
    );
  }

   Widget _buildPresetTabButton(String text, bool isSelected) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        backgroundColor: isSelected ? AppColors.border : Colors.transparent,
        foregroundColor: isSelected ? AppColors.tabActiveText : AppColors.textSecondary,
        // 1. 调小内边距，让按钮更紧凑
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        // 2. 设置字体大小为12px，并保持粗体
        textStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      // 注意: Text组件不再需要独立的style，因为它会继承父级Button的样式
      child: Text(text),
    );
  }


  Widget _buildFifthRowContent() {
    // 绿色的对勾图标，可以复用
    final checkIcon = Icon(
      Icons.check_circle,
      size: 14,
      color: AppColors.pnlGreen,
    );

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          // 标题行
          Row(
            children: [
              Text(
                "Degen Audit",
                style: AppTextStyles.listItemTitle.copyWith(fontSize: 14),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.keyboard_arrow_up,
                color: AppColors.textSecondary,
              ),
            ],
          ),
          const SizedBox(height: 16),
          // 信息行
          _buildInfoRow("NoMint", "Yes", trailingWidget: checkIcon),
          _buildInfoRow("Blacklist", "No", trailingWidget: checkIcon),
          _buildInfoRow("Burnt", "Yes", trailingWidget: checkIcon),
          _buildInfoRow("Top 10", "5%", trailingWidget: checkIcon),
          const SizedBox(height: 24),
          // GoPlus Logo
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shield, color: AppColors.pnlGreen, size: 20),
              const SizedBox(width: 8),
              Text(
                "GoPlus",
                style: AppTextStyles.listItemTitle.copyWith(fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 辅助方法，创建 "标签+值" 的信息行
  Widget _buildInfoRow(String label, String value, {Widget? trailingWidget}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          // 2. 左边title 字体大小为 12px，颜色为#7b8385
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: AppColors.infoLabel),
          ),
          const Spacer(),
          // 3. 右边字体大小为 13px，颜色为 #c4cccc
          Text(
            value,
            style: const TextStyle(fontSize: 13, color: AppColors.infoValue),
          ),
          if (trailingWidget != null) const SizedBox(width: 4),
          if (trailingWidget != null) trailingWidget,
        ],
      ),
    );
  }

  Widget _buildSmallStat(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppColors.textSecondary),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
        ),
      ],
    );
  }

  // (文件其余部分代码保持不变, 为了简洁省略)
  Widget _buildFirstRowContent() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatColumn("MKT Cap", "\$5.07K"),
              _buildStatColumn("Liq", "\$911.46"),
              _buildStatColumn("24h Vol", "\$136.3K"),
              _buildStatColumn("Holders", "77"),
            ],
          ),
          const SizedBox(height: 16),
          _buildPairInfoTable(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatColumn(
                "NoMint",
                "Yes",
                suffixIcon: Icons.check_circle,
                iconColor: AppColors.pnlGreen,
              ),
              _buildStatColumn(
                "Blacklist",
                "No",
                suffixIcon: Icons.check_circle,
                iconColor: AppColors.pnlGreen,
              ),
              _buildStatColumn(
                "Burnt",
                "100%",
                suffixIcon: Icons.local_fire_department,
                iconColor: Colors.orange,
              ),
              _buildStatColumn(
                "Top 10",
                "6.7%",
                suffixIcon: Icons.check_circle,
                iconColor: AppColors.pnlGreen,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatColumn("Insiders", "0%"),
              _buildStatColumn("Phishing", "0.1%"),
              _buildStatColumn("Bundler", "0%"),
              _buildStatColumn("BlueChip", "3.9%"),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.rugBackground,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.run_circle_outlined,
                  color: AppColors.downward,
                ),
                const SizedBox(width: 8),
                const Text(
                  "Rug",
                  style: TextStyle(color: AppColors.textPrimary),
                ),
                const Spacer(),
                const Text(
                  "99.3%(136)",
                  style: TextStyle(color: AppColors.downward),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: AppColors.downward,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(
    String label,
    String value, {
    IconData? suffixIcon,
    Color? iconColor,
    Widget? customValueWidget,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.listItemSubtitle.copyWith(fontSize: 12),
        ),
        const SizedBox(height: 4),
        customValueWidget ??
            Row(
              children: [
                Text(
                  value,
                  style: AppTextStyles.listItemTitle.copyWith(fontSize: 13),
                ),
                if (suffixIcon != null) const SizedBox(width: 4),
                if (suffixIcon != null)
                  Icon(
                    suffixIcon,
                    size: 14,
                    color: iconColor ?? AppColors.textSecondary,
                  ),
              ],
            ),
      ],
    );
  }

  Widget _buildPairInfoTable() {
    final headerStyle = AppTextStyles.listItemSubtitle.copyWith(fontSize: 12);
    final valueStyle = const TextStyle(
      color: AppColors.textPrimary,
      fontSize: 13,
      height: 1.5,
    );
    Widget buildTableRow({
      required String col1,
      required Widget col2,
      required String col3,
      TextStyle? style,
    }) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 2, child: Text(col1, style: style ?? valueStyle)),
          Expanded(flex: 5, child: col2),
          Expanded(
            flex: 3,
            child: Text(
              col3,
              style: style ?? valueStyle,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        buildTableRow(
          col1: "Pair",
          col2: Text("Liq/Initial", style: headerStyle),
          col3: "Value",
          style: headerStyle,
        ),
        const SizedBox(height: 8),
        buildTableRow(
          col1: "FOREX",
          col2: Text("899.5M/1B(100%)", style: valueStyle),
          col3: "\$4,563.36",
        ),
        buildTableRow(
          col1: "SOL",
          col2: RichText(
            text: TextSpan(
              style: valueStyle,
              children: const [
                TextSpan(text: "3.05/0.015 "),
                TextSpan(
                  text: "(+20K%)",
                  style: TextStyle(color: AppColors.pnlGreen),
                ),
              ],
            ),
          ),
          col3: "\$455.58",
        ),
      ],
    );
  }

  Widget _buildSecondRowContent() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildPresetsSection(),
          const SizedBox(height: 8),
          _buildDropdownInputRow(),
          const SizedBox(height: 8),
          _buildBuySellToggle(),
          const SizedBox(height: 16),
          _buildMarketLimitToggle(),
          const SizedBox(height: 12),
          const StyledTextField(hintText: 'Amount', suffixText: "SOL"),
          const SizedBox(height: 12),
          _buildAmountSection(),
          const SizedBox(height: 16),
          const Text(
            "1 SOL ≈ 29.7M FOREX",
            style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 12),
          _buildCheckboxesRow(),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.cardBackground,
              foregroundColor: AppColors.textPrimary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text("Buy"),
          ),
          const SizedBox(height: 12),
          _buildBottomInfoRow(),
        ],
      ),
    );
  }

    Widget _buildAmountSection() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardHoverBackground, 
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border), // 给整个容器一个边框
      ),
      // 使用 ClipRRect 来确保子组件的圆角与父容器一致
      child: ClipRRect(
        borderRadius: BorderRadius.circular(11), // 比父容器小1px以显示边框
        child: Column(
          children: [
            const StyledTextField(
              hintText: 'Amount',
              suffixText: "SOL",
              hasBorder: false, // 内部不需要边框
              fillColor: Colors.transparent, // 内部背景透明
            ),
            const Divider(color: AppColors.border, height: 1, thickness: 1),
            // **更新**: 移除VerticalDivider，使用SizedBox创建间隙
            Row(
              children: [
                _buildQuickAmountButton("0.01"),
                const SizedBox(width: 2, child: ColoredBox(color: AppColors.border)),
                _buildQuickAmountButton("0.1"),
                const SizedBox(width: 1, child: ColoredBox(color: AppColors.border)),
                _buildQuickAmountButton("0.5"),
                const SizedBox(width: 1, child: ColoredBox(color: AppColors.border)),
                _buildQuickAmountButton("1"),
              ],
            )
          ],
        ),
      ),
    );
  }

    // **新增**: 构建快捷金额按钮
  Widget _buildQuickAmountButton(String amount) {
    return Expanded(
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          foregroundColor: AppColors.textSecondary,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero), // 直角
          padding: const EdgeInsets.symmetric(vertical: 12)
        ),
        // 2. 字体大小为 12px
        child: Text(amount, style: const TextStyle(fontSize: 12)),
      ),
    );
  }

    Widget _buildPresetsSection() {
    return Column(
      children: [
        // 第一行: Presets 标签 + 齿轮图标
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Presets", style: TextStyle(color: AppColors.infoLabel, fontSize: 12)),
            const Icon(Icons.settings_outlined, color: AppColors.textSecondary),
          ],
        ),
        const SizedBox(height: 8), // 两行之间的间距
        // 第二行: P1, P2, P3 按钮
        Row(
          children: [
            _buildPresetTabButton("P1", true),
            _buildPresetTabButton("P2", false),
            _buildPresetTabButton("P3", false),
          ],
        ),
      ],
    );
  }

  Widget _buildPillButton(String text, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(right: 2.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: isSelected
              ? AppColors.cardBackground
              : Colors.transparent,
          foregroundColor: isSelected
              ? AppColors.textPrimary
              : AppColors.textSecondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: isSelected
                ? BorderSide.none
                : const BorderSide(color: AppColors.border),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        ),
        child: Text(
          text,
          style: AppTextStyles.listItemTitle.copyWith(fontSize: 12),
        ),
      ),
    );
  }

  Widget _buildDropdownInputRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.calendar_today_outlined,
            size: 16,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: 8),
          const Text("1", style: TextStyle(color: AppColors.textPrimary)),
          const Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
          const Spacer(),
          const Icon(
            Icons.filter_list,
            color: AppColors.textSecondary,
            size: 20,
          ),
          const SizedBox(width: 8),
          const Text("0", style: TextStyle(color: AppColors.textPrimary)),
          const SizedBox(width: 8),
          const Icon(Icons.refresh, color: AppColors.textSecondary, size: 20),
        ],
      ),
    );
  }

 Widget _buildBuySellToggle() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: AppColors.cardBackground, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          // **更新**: 为Buy按钮传递新的亮绿色
          Expanded(child: _buildToggleItem("Buy", true, color: AppColors.buyButtonGreen)),
          Expanded(child: _buildToggleItem("Sell", false, color: AppColors.downward)),
          Expanded(child: _buildToggleItem("Auto", false, trailingDot: true)),
        ],
      ),
    );
  }

  Widget _buildToggleItem(String text, bool isSelected, {Color? color, bool trailingDot = false}) {
    // **已修正**: 
    // 1. backgroundColor 始终透明
    // 2. foregroundColor (文字颜色) 根据是否选中而改变
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: Colors.transparent, // 背景始终透明
        foregroundColor: isSelected ? color : AppColors.textPrimary, // 激活时使用传入的颜色，否则为默认白色
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        textStyle: const TextStyle(
          fontSize: 14,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text),
          if (trailingDot) const SizedBox(width: 4),
          if (trailingDot) Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle)),
        ],
      ),
    );
  }



  Widget _buildMarketLimitToggle() {
    return Row(
      children: [
        Text(
          "Market",
          style: AppTextStyles.listItemTitle.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 14),
        const Text("Limit", style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
        const Spacer(),
        const Text(
          "Bal: 0 SOL",
          style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildQuickAmountButtons() {
    return Row(
      children: [
        Expanded(child: _buildPillButton("0.01", false)),
        Expanded(child: _buildPillButton("0.1", false)),
        Expanded(child: _buildPillButton("0.5", false)),
        Expanded(child: _buildPillButton("1", false)),
      ],
    );
  }

  Widget _buildCheckboxesRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildCheckboxWithLabel("TP&SL"),
          const SizedBox(width: 16),
          _buildCheckboxWithLabel("Migrated Sell 100%"),
          const SizedBox(width: 16),
          _buildCheckboxWithLabel("Dev Sell 100%"),
        ],
      ),
    );
  }

  Widget _buildCheckboxWithLabel(String label) {
    return Row(
      children: [
        Checkbox(
          value: false,
          onChanged: (v) {},
          visualDensity: VisualDensity.compact,
        ),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textSecondary,
            decoration: TextDecoration.underline,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomInfoRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            _buildSmallStat(Icons.directions_run, "Auto(30.0%)"),
            const SizedBox(width: 12),
            _buildSmallStat(Icons.person_outline, "0.005"),
            const SizedBox(width: 12),
            _buildSmallStat(Icons.fastfood_outlined, "OFF"),
          ],
        ),
        const Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
      ],
    );
  }

  Widget _buildThirdRowContent() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          _buildTimeframeToggles(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatColumn("Vol", "\$30.88"),
              _buildStatColumn("Buys", "1/\$10.23"),
              _buildStatColumn(
                "Sells",
                "",
                customValueWidget: Text(
                  "3/\$20.64",
                  style: AppTextStyles.listItemTitle.copyWith(
                    fontSize: 13,
                    color: AppColors.downward,
                  ),
                ),
              ),
              _buildStatColumn("Net Buy", "--"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeframeToggles() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          _buildTimeframeButton("1m", "-0.05%", false),
          _buildTimeframeButton("5m", "-0.33%", true),
          _buildTimeframeButton("1h", "-71.41%", false),
          _buildTimeframeButton("24h", "-4.54%", false),
        ],
      ),
    );
  }

  Widget _buildTimeframeButton(
    String time,
    String percentage,
    bool isSelected,
  ) {
    return Expanded(
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          backgroundColor: isSelected
              ? AppColors.border.withOpacity(0.8)
              : Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          padding: const EdgeInsets.symmetric(vertical: 8),
        ),
        child: Column(
          children: [
            Text(
              time,
              style: TextStyle(
                color: isSelected
                    ? AppColors.textPrimary
                    : AppColors.textSecondary,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              percentage,
              style: const TextStyle(
                color: AppColors.downward,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRowPlaceholder(int rowNumber) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      height: 80,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardBackground.withOpacity(0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            'Row $rowNumber Placeholder',
            style: const TextStyle(color: Colors.white54),
          ),
        ),
      ),
    );
  }
}
