// lib/main.dart

import 'package:flutter/material.dart';
import 'package:gmgn_app/screens/main/main_screen.dart';
import 'package:gmgn_app/services/auth_service.dart'; // 1. 导入我们创建的AuthService
import 'package:gmgn_app/theme/app_colors.dart';
import 'package:gmgn_app/theme/app_text_styles.dart';
import 'package:provider/provider.dart'; // 2. 导入provider包

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 3. 用 ChangeNotifierProvider 包裹 MaterialApp
    return ChangeNotifierProvider(
      // 4. 'create' 负责创建我们的 AuthService 实例
      create: (context) => AuthService(),
      child: MaterialApp(
        title: 'gmgn.ai Clone',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.background,
          fontFamily: 'Inter',
          textTheme: TextTheme(
            displayLarge: AppTextStyles.headline1,
            bodyLarge: AppTextStyles.listItemTitle,
            bodyMedium: AppTextStyles.listItemSubtitle,
            labelLarge: AppTextStyles.button,
          ),
        ),
        home: const MainScreen(),
      ),
    );
  }
}
