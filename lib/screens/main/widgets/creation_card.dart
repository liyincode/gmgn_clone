// lib/screens/main/widgets/creation_card.dart

import 'package:flutter/material.dart';
import 'package:gmgn_app/theme/app_colors.dart';
import 'package:gmgn_app/theme/app_text_styles.dart';

class CreationCard extends StatelessWidget {
   // 1. 接收回调函数
  final VoidCallback onTap;
  const CreationCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // **更新**: 使用 Material 和 InkWell 来实现悬停效果
    return Material(
      color: Colors.transparent, // Material 本身是透明的
      child: InkWell(
        onTap: onTap,
        hoverColor: AppColors.cardHoverBackground, // **核心**: 设置悬停颜色
        splashColor: AppColors.cardHoverBackground.withOpacity(0.5), // 点击时的波纹颜色
        child: Container(
          // 卡片的根容器
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 左侧部分
              _buildLeftSection(),
              const Spacer(),
              // 右侧部分
              _buildRightSection(),
            ],
          ),
        ),
      ),
    );
  }

  // ... 文件中所有其他的 _build... 方法都保持不变 ...
  // 为方便起见，下面依然提供完整代码。

  Widget _buildLeftSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAvatar(),
        const SizedBox(width: 12),
        _buildInfoColumn(),
      ],
    );
  }

  Widget _buildRightSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.flash_on, size: 16),
          label: const Text('Buy'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.cardBackground,
            foregroundColor: AppColors.pnlGreen,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildStatItem(Icons.people_alt_outlined, "17"),
            const SizedBox(width: 8),
            _buildStatItem(Icons.ac_unit, "1"),
            const SizedBox(width: 8),
            _buildStatItem(Icons.wallet_outlined, "0.0080"),
            const SizedBox(width: 8),
            const Text("TX 18", style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
          ],
        ),
        Container(height: 2, width: 25, color: AppColors.pnlGreen, margin: const EdgeInsets.only(top: 2)),
        const SizedBox(height: 4),
        Row(
          children: [
            Text("V \$954.3", style: AppTextStyles.listItemSubtitle),
            const SizedBox(width: 8),
            Text("MC \$5.1K", style: AppTextStyles.listItemSubtitle),
          ],
        )
      ],
    );
  }
  
  Widget _buildAvatar() {
    return SizedBox(
      width: 52,
      height: 52,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const Center(
            child: SizedBox(
              width: 52,
              height: 52,
              child: CircularProgressIndicator(
                value: 0.8,
                strokeWidth: 2.5,
                backgroundColor: AppColors.border,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.pnlGreen),
              ),
            ),
          ),
          const Center(
            child: CircleAvatar(
              radius: 22,
              backgroundColor: Colors.deepPurple,
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                color: AppColors.background,
                shape: BoxShape.circle,
              ),
              child: const CircleAvatar(
                radius: 6,
                backgroundColor: AppColors.pnlGreen,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInfoColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("passive", style: AppTextStyles.listItemTitle.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            Text("works when you sleep", style: AppTextStyles.listItemSubtitle),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            const Text("11s", style: TextStyle(color: AppColors.pnlGreen, fontSize: 13)),
            const SizedBox(width: 8),
            Text("G5jZC...ump", style: AppTextStyles.listItemSubtitle),
            const SizedBox(width: 8),
            const Icon(Icons.copy, size: 14, color: AppColors.textSecondary),
            const SizedBox(width: 4),
            const Icon(Icons.people_alt_outlined, size: 14, color: AppColors.textSecondary),
            const SizedBox(width: 4),
            const Icon(Icons.language, size: 14, color: AppColors.textSecondary),
             const SizedBox(width: 4),
            const Icon(Icons.search, size: 14, color: AppColors.textSecondary),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            _buildStatTag(Icons.ac_unit, "12.5%"),
            const SizedBox(width: 4),
            _buildStatTag(Icons.people_alt_outlined, "9%"),
            const SizedBox(width: 4),
            _buildStatTag(Icons.bakery_dining_outlined, "3%"),
            const SizedBox(width: 4),
            _buildStatTag(Icons.ac_unit, "4"),
          ],
        ),
      ],
    );
  }

  Widget _buildStatTag(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Row(
        children: [
          Icon(icon, size: 12, color: AppColors.textSecondary),
          const SizedBox(width: 4),
          Text(text, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppColors.textSecondary),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(color: AppColors.textPrimary, fontSize: 13)),
      ],
    );
  }
}
