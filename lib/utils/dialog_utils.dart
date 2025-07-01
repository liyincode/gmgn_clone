// lib/utils/dialog_utils.dart

import 'package:flutter/material.dart';

// 这是一个通用的函数，可以为任何 Widget 添加淡入淡出弹窗效果
void showCustomFadeDialog({
  required BuildContext context,
  required Widget child, // 我们要显示的弹窗Widget
}) {
  showGeneralDialog(
    context: context,
    // 弹窗背景色
    barrierColor: Colors.black.withOpacity(0.7),
    // 过渡动画时长
    transitionDuration: const Duration(milliseconds: 300),
    // 是否点击背景关闭弹窗
    barrierDismissible: true,
    barrierLabel: '',
    // 核心部分：构建页面和过渡动画
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      // 使用 FadeTransition 来实现淡入淡出
      return FadeTransition(
        // animation.drive(CurveTween(...)) 让动画带有缓动效果，更自然
        opacity: animation.drive(CurveTween(curve: Curves.easeOut)),
        child: child,
      );
    },
  );
}
