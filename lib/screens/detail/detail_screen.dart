// lib/screens/detail/detail_screen.dart

import 'package:flutter/material.dart';
import 'package:gmgn_app/theme/app_colors.dart';
import 'package:gmgn_app/screens/detail/widgets/left_panel.dart';
import 'package:gmgn_app/screens/detail/widgets/center_panel.dart';
// **新增**: 导入我们新建的右侧面板Widget
import 'package:gmgn_app/screens/detail/widgets/right_panel.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 1. 左侧列 (保持不变)
        Container(
          width: 265,
          decoration: const BoxDecoration(
            color: AppColors.background,
            border: Border(right: BorderSide(color: AppColors.headerBorder, width: 1)),
          ),
          child: const LeftPanel(),
        ),

        // 2. 中间列 (保持不变)
        const Expanded(
          child: CenterPanel(),
        ),

        // 3. 右侧列 (固定宽度 320)
        Container(
          width: 320,
          decoration: const BoxDecoration(
            color: AppColors.background,
            border: Border(left: BorderSide(color: AppColors.headerBorder, width: 1)),
          ),
          // **更新**: 使用我们新建的 RightPanel
          child: const RightPanel(),
        ),
      ],
    );
  }
}
