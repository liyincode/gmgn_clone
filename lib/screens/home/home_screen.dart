// lib/screens/home/home_screen.dart

import 'package:flutter/material.dart';
import 'package:gmgn_app/screens/login/login_dialog.dart'; 
import 'package:gmgn_app/theme/app_text_styles.dart';
import 'package:gmgn_app/utils/dialog_utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // 这个按钮用于触发登录弹窗
        child: ElevatedButton(
          onPressed: () {
            // 显示登录对话框
            showCustomFadeDialog(
              context: context,
              child: LoginDialog(),
            );
          },
          child: Text('Show Login Dialog', style: AppTextStyles.button),
        ),
      ),
    );
  }
}
