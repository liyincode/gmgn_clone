// lib/screens/detail/widgets/left_panel.dart

import 'package:flutter/material.dart';
import 'package:gmgn_app/theme/app_colors.dart';
import 'package:gmgn_app/theme/app_text_styles.dart';
import 'package:gmgn_app/widgets/styled_text_field.dart';

class LeftPanel extends StatelessWidget {
  const LeftPanel({super.key});

  @override
  Widget build(BuildContext context) {
    // **已更新**: 使用 ListView 作为根组件，使其成为一个统一的滚动列表
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // --- Watchlist Section ---
        Text(
          'Watchlist',
          style: AppTextStyles.headline1.copyWith(fontSize: 12),
        ),
        const SizedBox(height: 8),
        StyledTextField(
          hintText: 'Search Token',
          prefixIcon: const Icon(
            Icons.search,
            size: 20,
            color: AppColors.textSecondary,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 12,
          ),
        ),
        const SizedBox(height: 8),
        _buildFilterTabs(),
        const SizedBox(height: 24),
        _buildListHeader(),
        const SizedBox(height: 8),
        _buildWatchlistCard(
          name: 'FOREX',
          value: 2091,
          price: '\$0.0,43949',
          change: '-15.6%',
          isPositive: false,
        ),
        _buildWatchlistCard(
          name: 'Gay',
          value: 599,
          price: '\$0.0,41620',
          change: '-9.17%',
          isPositive: false,
        ),
        const SizedBox(height: 24),
        const Divider(color: AppColors.border, thickness: 1),
        const SizedBox(height: 24),

        // --- Trending Section ---
        _buildTrendingMainTabs(),
        const SizedBox(height: 12),
        _buildTrendingTimePills(),
        const SizedBox(height: 12),
        _buildListHeader(), // 复用列表头
        const SizedBox(height: 8),
        // Trending 列表
        _buildTrendingCard(
          name: "INF",
          stats: "118K(59K/59K)",
          price: "\$0.00099",
          change: "+280.4%",
          isPositive: true,
        ),
        _buildTrendingCard(
          name: "SNG",
          stats: "43K(28K/15K)",
          price: "\$0.0,2156",
          change: "-34.29%",
          isPositive: false,
        ),
        _buildTrendingCard(
          name: "BioAI",
          stats: "29K(19K/10K)",
          price: "\$0.00022",
          change: "+282.5%",
          isPositive: true,
        ),
        _buildTrendingCard(
          name: "Microsoft",
          stats: "21K(12K/9K)",
          price: "\$0.00018",
          change: "+323.4%",
          isPositive: true,
        ),
        _buildTrendingCard(
          name: "DADDYMO",
          stats: "18K(18K/403)",
          price: "\$0.00014",
          change: "+211.2%",
          isPositive: true,
        ),
      ],
    );
  }

  // (下方的所有 _build... 辅助方法都保持不变，为了简洁省略)
  Widget _buildFilterTabs() {
    return Row(
      children: [
        _buildTabButton(text: 'All', isSelected: true),
        const SizedBox(width: 8),
        _buildTabButton(text: 'Default', isSelected: false),
      ],
    );
  }

  Widget _buildTabButton({required String text, required bool isSelected}) {
    return ElevatedButton(
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
        textStyle: const TextStyle(fontSize: 12),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildListHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildSortableHeaderItem(text: 'Token / TXs'),
        _buildSortableHeaderItem(text: 'Price / %'),
      ],
    );
  }

  Widget _buildSortableHeaderItem({required String text}) {
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
        ),
        const SizedBox(width: 4),
        const Column(
          children: [
            Icon(Icons.arrow_drop_up, size: 12, color: AppColors.textSecondary),
            Icon(
              Icons.arrow_drop_down,
              size: 12,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ],
    );
  }

Widget _buildWatchlistCard({
    required String name,
    required int value,
    required String price,
    required String change,
    required bool isPositive,
  }) {
    // **已更新**: 使用 Material 和 InkWell 包裹以实现悬停效果
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        hoverColor: AppColors.cardHoverBackground, // 设置悬停颜色
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), // 将padding移到内部
          child: Row(
            children: [
              const Icon(
                Icons.drag_handle,
                color: AppColors.textSecondary,
                size: 18,
              ),
              const SizedBox(width: 8),
              const CircleAvatar(radius: 18, backgroundColor: Colors.deepPurple),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        style: AppTextStyles.listItemTitle.copyWith(fontSize: 12),
                      ),
                      const SizedBox(width: 2),
                      const Icon(Icons.star, color: Colors.yellow, size: 12),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                        value.toString(),
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 2),
                      const Icon(
                        Icons.edit_outlined,
                        size: 12,
                        color: AppColors.textSecondary,
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(price, style: AppTextStyles.price.copyWith(fontSize: 12)),
                  const SizedBox(height: 2),
                  Text(
                    change,
                    style: TextStyle(
                      color: isPositive ? AppColors.pnlGreen : AppColors.downward,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrendingMainTabs() {
    return Row(
      children: [
        // 使用Expanded，让可滚动区域填充所有可用空间
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildMainTab("Trending", true),
                _buildMainTab("Pump", false),
                _buildMainTab("Tracking", false),
                _buildMainTab("Smart", false),
                _buildMainTab("KOL", false),
                // 如果还有更多标签，可以继续添加
              ],
            ),
          ),
        ),
        // 右侧的筛选图标保持不变
        const Icon(Icons.filter_alt, color: AppColors.textPrimary),
      ],
    );
  }

  Widget _buildMainTab(String text, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildTrendingTimePills() {
    return Row(
      children: [
        _buildTimePill("1m", false),
        _buildTimePill("5m", false),
        _buildTimePill("1h", true),
        _buildTimePill("6h", false),
        _buildTimePill("24h", false),
      ],
    );
  }

   Widget _buildTimePill(String text, bool isSelected) {
    return Padding(
      // 减小按钮之间的间距
      padding: const EdgeInsets.only(right: 4.0),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          backgroundColor: isSelected ? AppColors.cardBackground : Colors.transparent,
          foregroundColor: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          // **已修正**: 大幅减小内边距，使其更紧凑
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          minimumSize: Size.zero, // 允许按钮收缩到内容大小
          tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 减小点击区域
          textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
        ),
        child: Text(text),
      ),
    );
  }

Widget _buildTrendingCard({
    required String name,
    required String stats,
    required String price,
    required String change,
    required bool isPositive,
  }) {
    // **已更新**: 使用 Material 和 InkWell 包裹以实现悬停效果
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        hoverColor: AppColors.cardHoverBackground, // 设置悬停颜色
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0), // 将padding移到内部
          child: Row(
            children: [
              SizedBox(
                width: 36,
                height: 36,
                child: Stack(
                  children: const [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: AppColors.cardBackground,
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: CircleAvatar(
                        radius: 8,
                        backgroundColor: AppColors.border,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(name, style: AppTextStyles.listItemTitle.copyWith(fontSize: 14)),
                      const SizedBox(width: 4),
                      const Icon(Icons.medication, color: AppColors.textSecondary, size: 14),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(stats, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                      const SizedBox(width: 4),
                      const Icon(Icons.local_fire_department, size: 12, color: AppColors.valuePurple),
                    ],
                  )
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(price, style: AppTextStyles.price.copyWith(fontSize: 12)),
                  const SizedBox(height: 2),
                  Text(
                    change,
                    style: TextStyle(
                      color: isPositive ? AppColors.pnlGreen : AppColors.downward,
                      fontSize: 12,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
