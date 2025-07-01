// lib/screens/main/widgets/main_footer.dart

import 'package:flutter/material.dart';
import 'package:gmgn_app/theme/app_colors.dart';

class MainFooter extends StatelessWidget {
  const MainFooter({super.key});

  @override
  Widget build(BuildContext context) {
    // 使用 Decoration 来添加顶部边框
    return Container(
      height: 48.0, // Footer 的高度
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      decoration: const BoxDecoration(
        color: AppColors.background, // 背景色
        border: Border(
          top: BorderSide(
            color: AppColors.headerBorder, // 与Header使用相同的边框颜色
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 左侧区域
          _buildLeftSection(),
          // 右侧区域
          _buildRightSection(),
        ],
      ),
    );
  }

  // 左侧区域
  Widget _buildLeftSection() {
    return Row(
      children: [
        _buildFooterItem(Icons.account_balance_wallet_outlined, 'Wallet Tracker'),
        const SizedBox(width: 24),
        _buildFooterItem(Icons.inventory_2_outlined, 'Holding'),
        const SizedBox(width: 24),
        _buildFooterItem(Icons.show_chart, 'PnL'),
        const SizedBox(width: 24),
        // 垂直分割线
        Container(
          height: 20,
          width: 1,
          color: AppColors.border,
        ),
        const SizedBox(width: 24),
        _buildFooterItem(Icons.arrow_upward, '\$151.22', textColor: AppColors.pnlGreen),
        const SizedBox(width: 24),
        _buildFooterItem(Icons.data_usage, '\$62.1K', textColor: AppColors.valuePurple),
      ],
    );
  }

  // 右侧区域
  Widget _buildRightSection() {
    return Row(
      children: [
        _buildFooterItem(Icons.security, 'STable'),
        const SizedBox(width: 20),
        _buildFooterItem(Icons.school_outlined, 'Tutorial'),
        const SizedBox(width: 20),
        _buildFooterItem(Icons.info_outline, 'About'),
        const SizedBox(width: 20),
        _buildFooterItem(Icons.smart_toy_outlined, 'Bot'),
        const SizedBox(width: 20),
        _buildFooterItem(Icons.code, 'API'),
        const SizedBox(width: 20),
        // 社交媒体图标 (这里用占位符)
        const Icon(Icons.close, color: AppColors.textSecondary, size: 18), // Placeholder for X
        const SizedBox(width: 20),
        const Icon(Icons.send, color: AppColors.textSecondary, size: 18), // Placeholder for Telegram
        const SizedBox(width: 20),
        const Icon(Icons.discord, color: AppColors.textSecondary, size: 18),
        const SizedBox(width: 20),
        // 彩色图标+文字
        _buildColorfulFooterItem(Colors.orange, 'Refer'),
        const SizedBox(width: 20),
        _buildColorfulFooterItem(Colors.purple, 'Contest'),
        const SizedBox(width: 20),
        _buildColorfulFooterItem(Colors.lightGreenAccent, 'APP'),
      ],
    );
  }

  // 辅助方法，用于创建 "图标+文字" 组合
  Widget _buildFooterItem(IconData icon, String text, {Color? textColor}) {
    return Row(
      children: [
        Icon(icon, color: AppColors.textSecondary, size: 16),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            color: textColor ?? AppColors.textSecondary, // 如果没有指定颜色，则用默认灰色
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
  
  // 辅助方法，用于创建右下角的 "彩色图标+文字"
  Widget _buildColorfulFooterItem(Color color, String text) {
     return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            color: AppColors.textPrimary, // 文字是白色
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
