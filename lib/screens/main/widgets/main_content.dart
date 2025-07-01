// lib/screens/main/widgets/main_content.dart

import 'package:flutter/material.dart';
import 'package:gmgn_app/theme/app_colors.dart';
import 'package:gmgn_app/theme/app_text_styles.dart';
import 'package:gmgn_app/screens/main/widgets/creation_card.dart';

class MainContent extends StatelessWidget {
  // 2. 接收回调函数
  final VoidCallback onCardTapped;
  const MainContent({super.key, required this.onCardTapped});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildContentHeader(),
        Expanded(
          child: Row(
            children: [
              // **更新**: 调用参数化的方法来构建每一列
              // 第一列
              _buildColumnWithRealCards(
                title: 'New Creations',
                icon: Icons.eco_outlined,
                iconColor: Colors.greenAccent,
                onCardTapped: onCardTapped,
              ),
              const VerticalDivider(color: AppColors.headerBorder, width: 1),

              // 第二列
              _buildColumnWithRealCards(
                title: 'Completing',
                icon: Icons.format_list_bulleted, // Completing 的占位符图标
                onCardTapped: onCardTapped,
              ),
              const VerticalDivider(color: AppColors.headerBorder, width: 1),

              // 第三列 (我们顺便也实现了)
              _buildColumnWithRealCards(
                title: 'Completed',
                icon: Icons.check_circle_outline, // Completed 的占位符图标
                iconColor: AppColors.pnlGreen,
                onCardTapped: onCardTapped,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 3. 更新列的构建方法，以接收和传递函数
  Widget _buildColumnWithRealCards({
    required String title,
    required IconData icon,
    Color? iconColor,
    required VoidCallback onCardTapped, // <--- 接收
  }) {
    return Expanded(
      child: Column(
        children: [
          _buildListHeader(title: title, icon: icon, iconColor: iconColor),
          Expanded(
            child: ListView.separated(
              itemCount: 20,
              itemBuilder: (context, index) {
                // 4. 将函数最终传递给卡片
                return CreationCard(onTap: onCardTapped); // <--- 传递
              },
              separatorBuilder: (context, index) => const Divider(
                color: AppColors.headerBorder, height: 1, thickness: 1),
            ),
          ),
        ],
      ),
    );
  }

  // **已更新**: 列的内部Header现在也接收参数
  Widget _buildListHeader({
    required String title,
    required IconData icon,
    Color? iconColor,
  }) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: iconColor ?? AppColors.textPrimary,
              ), // 使用传入的图标和颜色
              const SizedBox(width: 8),
              Text(title, style: AppTextStyles.listItemTitle), // 使用传入的标题
            ],
          ),
          const Spacer(),
          Row(
            children: [
              _buildInputBox(
                child: Row(
                  children: const [
                    FlutterLogo(size: 16),
                    SizedBox(width: 8),
                    Text("0", style: TextStyle(color: AppColors.textPrimary)),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _buildP1Dropdown(),
              const SizedBox(width: 8),
              _buildInputBox(
                child: Row(
                  children: const [
                    Icon(
                      Icons.search,
                      size: 18,
                      color: AppColors.textSecondary,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Search",
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _buildInputBox(
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.volume_off_outlined,
                  size: 18,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: 8),
              _buildInputBox(
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.filter_list,
                  size: 18,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // (文件其余部分代码保持不变...)
  Widget _buildInputBox({required Widget child, EdgeInsets? padding}) {
    return Container(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }

  Widget _buildP1Dropdown() {
    return PopupMenuButton<String>(
      color: AppColors.cardBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onSelected: (String value) {},
      child: _buildInputBox(
        child: Row(
          children: const [
            Text("P1", style: TextStyle(color: AppColors.textPrimary)),
            SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down,
              size: 18,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'P1',
          child: Text('P1', style: AppTextStyles.listItemTitle),
        ),
        PopupMenuItem<String>(
          value: 'P2',
          child: Text('P2', style: AppTextStyles.listItemTitle),
        ),
        PopupMenuItem<String>(
          value: 'P3',
          child: Text('P3', style: AppTextStyles.listItemTitle),
        ),
      ],
    );
  }

  Widget _buildContentHeader() {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(
          bottom: BorderSide(color: AppColors.headerBorder, width: 1),
        ),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.military_tech_outlined,
                    color: AppColors.textPrimary,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Trenches',
                    style: AppTextStyles.headline1.copyWith(fontSize: 20),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Row(
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.dashboard_customize_outlined,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
                label: const Text(
                  'Customize',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: 8),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.filter_alt_outlined,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
                label: const Text(
                  'Filter',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.settings_outlined,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
