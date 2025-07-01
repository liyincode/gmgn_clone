// lib/screens/login/login_dialog.dart

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gmgn_app/screens/login/signup_dialog.dart';
import 'package:gmgn_app/services/auth_service.dart'; // 1. 导入 AuthService
import 'package:gmgn_app/theme/app_colors.dart';
import 'package:gmgn_app/theme/app_text_styles.dart';
import 'package:gmgn_app/utils/dialog_utils.dart';
import 'package:gmgn_app/widgets/styled_text_field.dart';
import 'package:provider/provider.dart'; // 2. 导入 provider

// 3. 将其转换为 StatefulWidget，因为它现在需要管理自己的状态（如加载状态、文本框内容）
class LoginDialog extends StatefulWidget {
  const LoginDialog({super.key});

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  // 4. 创建 TextEditingController 来获取输入框中的文本
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  // 5. 创建一个布尔值来控制是否显示加载动画
  bool _isLoading = false;

  // 6. 这是处理登录的核心函数
  Future<void> _handleLogin() async {
    // 防止用户在加载时重复点击
    if (_isLoading) return;

    setState(() {
      _isLoading = true; // 开始加载，更新UI以显示加载动画
    });

    // 7. 使用 Provider 获取 AuthService 的实例
    // listen: false 是因为我们在这里只是想调用一个方法，而不是要监听它的变化来重建UI
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      // 8. 调用 authService 的登录方法，并传入邮箱和密码
      await authService.login(
        _emailController.text,
        _passwordController.text,
      );
      // 9. 如果登录成功 (没有抛出异常)，就关闭当前的登录弹窗
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      // 在真实应用中，这里应该处理登录失败的情况，比如弹出一个错误提示
      // 我们暂时留空
    } finally {
      // 10. 无论成功还是失败，最后都要结束加载状态
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // 11. 记得在组件销毁时释放 Controller 资源，防止内存泄漏
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      // ... (Dialog 的样式代码保持不变)
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
                    // 12. 将 Controller 绑定到输入框
                    StyledTextField(
                      hintText: 'Enter Email',
                      //controller: _emailController, // (在你的StyledTextField中添加controller属性)
                    ),
                    const SizedBox(height: 16),
                    const StyledTextField(
                      hintText: 'Enter Password',
                      obscureText: true,
                      //controller: _passwordController, // (在你的StyledTextField中添加controller属性)
                      suffixIcon: Icon(Icons.visibility_off_outlined, color: AppColors.textSecondary, size: 20),
                    ),
                    const SizedBox(height: 8),
                    _buildForgotPasswordButton(),
                    const SizedBox(height: 16),
                    _buildLoginButton(), // 这个按钮现在会根据 _isLoading 状态显示不同内容
                    const SizedBox(height: 24),
                    _buildOrDivider(),
                    const SizedBox(height: 24),
                    _buildSocialLogins(),
                    const SizedBox(height: 32),
                    _buildConnectWalletButton(),
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

  // 13. 修改登录按钮，使其能响应 _isLoading 状态
  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: _handleLogin, // 点击时调用我们的处理函数
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.buttonGreen,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      ),
      child: _isLoading
          ? const SizedBox( // 如果正在加载，显示一个圆形进度条
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: Colors.black,
                strokeWidth: 2.5,
              ),
            )
          : Text('Log In', style: AppTextStyles.button.copyWith(color: Colors.black, fontWeight: FontWeight.bold)),
    );
  }

  // --- 其他所有 _build... 方法保持原样，无需改动 ---
  // (为保持简洁，此处省略)
   Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Log In', style: AppTextStyles.headline1),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            style: AppTextStyles.listItemSubtitle,
            children: [
              const TextSpan(text: "Don't have an account yet? "),
              TextSpan(
                text: 'Sign Up',
                style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w500),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.of(context).pop();
                    showCustomFadeDialog(
                      context: context,
                      child: const SignUpDialog(),
                    );
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordButton() {
     return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(50, 30), tapTargetSize: MaterialTapTargetSize.shrinkWrap),
        child: Text('Forgot Password?', style: AppTextStyles.listItemSubtitle.copyWith(color: AppColors.buttonGreen, fontWeight: FontWeight.w500)),
      ),
    );
  }

  Widget _buildOrDivider() {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.border)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text('OR', style: AppTextStyles.listItemSubtitle),
        ),
        const Expanded(child: Divider(color: AppColors.border)),
      ],
    );
  }

  Widget _buildSocialLogins() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildSocialLoginButton(Icons.send_outlined, 'Telegram'),
        _buildSocialLoginButton(Icons.bubble_chart_outlined, 'Phantom'),
        _buildSocialLoginButton(Icons.qr_code_scanner_outlined, 'APP Scan'),
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

  Widget _buildConnectWalletButton() {
    return TextButton(
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Connect with extension wallet', style: AppTextStyles.listItemTitle.copyWith(fontSize: 14, fontWeight: FontWeight.w500)),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward, color: AppColors.textPrimary, size: 16),
        ],
      ),
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
