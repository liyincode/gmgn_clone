// lib/screens/login/signup_dialog.dart

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gmgn_app/screens/login/login_dialog.dart';
import 'package:gmgn_app/services/auth_service.dart'; // 1. 导入
import 'package:gmgn_app/theme/app_colors.dart';
import 'package:gmgn_app/theme/app_text_styles.dart';
import 'package:gmgn_app/widgets/styled_text_field.dart';
import 'package:provider/provider.dart'; // 2. 导入

// 3. 转换为 StatefulWidget
class SignUpDialog extends StatefulWidget {
  const SignUpDialog({super.key});

  @override
  State<SignUpDialog> createState() => _SignUpDialogState();
}

class _SignUpDialogState extends State<SignUpDialog> {
  // 4. 添加 Controller 和加载状态
  final _emailController = TextEditingController();
  bool _isLoading = false;

  // 5. 注册处理函数
  Future<void> _handleSignUp() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      // 6. 调用注册方法
      await authService.signUp(_emailController.text);
      // 注册成功后关闭弹窗
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      // 错误处理
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.cardBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildHeader(context),
                    const SizedBox(height: 24),
                    // 7. 绑定 Controller
                    StyledTextField(
                      hintText: 'Enter Email',
                      controller: _emailController,
                    ),
                    const SizedBox(height: 16),
                    const StyledTextField(hintText: 'Invite Code (Optional)'),
                    const SizedBox(height: 8),
                    Text(
                      'The invite code cannot be changed after binding. Please ensure the correct invite code is entered.',
                      style: AppTextStyles.listItemSubtitle.copyWith(fontSize: 12),
                    ),
                    const SizedBox(height: 24),
                    _buildSignUpButton(), // 使用更新后的按钮
                    const SizedBox(height: 24),
                    _buildOrDivider(),
                    const SizedBox(height: 24),
                    _buildSocialLogins(),
                    const SizedBox(height: 24),
                    _buildFooterLinks(),
                  ],
                ),
                _buildCloseButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- Widgets ---

  // 8. 修改注册按钮以显示加载状态
  Widget _buildSignUpButton() {
    return ElevatedButton(
      onPressed: _handleSignUp, // 点击时调用处理函数
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.buttonGreen,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      ),
      child: _isLoading
          ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.black, strokeWidth: 2.5))
          : Text('Sign Up', style: AppTextStyles.button.copyWith(color: Colors.black, fontWeight: FontWeight.bold)),
    );
  }

  // --- 其他所有 _build... 方法保持原样，无需改动 ---
  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Sign Up', style: AppTextStyles.headline1),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            style: AppTextStyles.listItemSubtitle,
            children: [
              const TextSpan(text: "Already have an account? "),
              TextSpan(
                text: 'Log In',
                style: const TextStyle(color: AppColors.buttonGreen, fontWeight: FontWeight.w500),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      barrierColor: Colors.black.withOpacity(0.7),
                      builder: (context) => const LoginDialog(),
                    );
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOrDivider() {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.border)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text('OR Sign Up', style: AppTextStyles.listItemSubtitle),
        ),
        const Expanded(child: Divider(color: AppColors.border)),
      ],
    );
  }

  Widget _buildSocialLogins() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialLoginButton(Icons.send_outlined, 'Telegram'),
        const SizedBox(width: 48),
        _buildSocialLoginButton(Icons.bubble_chart_outlined, 'Phantom'),
      ],
    );
  }

  Widget _buildSocialLoginButton(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(color: AppColors.background, shape: BoxShape.circle),
          child: Icon(icon, color: AppColors.textPrimary, size: 28),
        ),
        const SizedBox(height: 8),
        Text(label, style: AppTextStyles.listItemSubtitle.copyWith(fontSize: 12)),
      ],
    );
  }

  Widget _buildFooterLinks() {
     return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Terms of Service', style: AppTextStyles.listItemSubtitle.copyWith(fontSize: 12)),
        const SizedBox(width: 8),
        const Text('|', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
        const SizedBox(width: 8),
        Text('Privacy Policy', style: AppTextStyles.listItemSubtitle.copyWith(fontSize: 12)),
      ],
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return Positioned(
      top: -16,
      right: -16,
      child: InkWell(
        onTap: () => Navigator.of(context).pop(),
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(color: AppColors.cardBackground, shape: BoxShape.circle),
          child: const Icon(Icons.close, color: AppColors.textSecondary, size: 24),
        ),
      ),
    );
  }
}
