// lib/screens/main/widgets/main_header.dart

import 'package:flutter/material.dart';
import 'package:gmgn_app/screens/login/login_dialog.dart';
import 'package:gmgn_app/services/auth_service.dart';
import 'package:gmgn_app/theme/app_colors.dart';
import 'package:gmgn_app/theme/app_text_styles.dart';
import 'package:gmgn_app/utils/dialog_utils.dart';
import 'package:provider/provider.dart';

class MainHeader extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback onWalletTapped;
  final VoidCallback onLogoTapped; // 1. 接收一个新的回调函数 for logo tap

  const MainHeader({
    super.key,
    required this.onWalletTapped,
    required this.onLogoTapped, // 2. 在构造函数中要求传入
  });

  @override
  State<MainHeader> createState() => _MainHeaderState();
  
  @override
  Size get preferredSize => const Size.fromHeight(72.0);
}

class _MainHeaderState extends State<MainHeader> {
  bool _isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      // ... (build 方法和大部分内容不变)
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(
          bottom: BorderSide(color: AppColors.headerBorder, width: 1.0),
        ),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildLeftSection(),
            _buildCenterSection(),
            Consumer<AuthService>(
              builder: (context, authService, child) {
                return authService.isLoggedIn
                    ? _buildUserProfile(context, authService)
                    : _buildAuthButtons(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  // 3. **核心修改**: 修改 _buildLeftSection 方法
  Widget _buildLeftSection() {
    const menuItems = ['Trenches', 'New', 'Pending', 'Copy Trade', 'Monitor', 'Track', 'Holding'];
    return Row(
      children: [
        // 4. 使用 InkWell 包裹 Logo 图片，使其可以被点击
        InkWell(
          onTap: widget.onLogoTapped, // 5. 点击时调用传递过来的函数
          borderRadius: BorderRadius.circular(8), // 给点击效果一个圆角
          child: MouseRegion(
            cursor: SystemMouseCursors.click, // 鼠标悬停时显示小手图标
            child: Padding(
              padding: const EdgeInsets.all(4.0), // 增加一点内边距，扩大点击区域
              child: Image.asset('assets/images/gmg_logo.png', height: 42),
            ),
          ),
        ),
        const SizedBox(width: 32),
        Row(
          children: menuItems.map((item) => TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: AppColors.textSecondary,
              textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
            child: Text(item),
          )).toList(),
        ),
      ],
    );
  }


  // --- 其他所有方法保持不变 ---
  
  PopupMenuItem<String> _buildMenuItem({
    required IconData icon,
    required String text,
    String? value,
    Widget? trailing,
  }) {
    return PopupMenuItem<String>(
      value: value ?? text,
      child: Row(
        children: [
          Icon(icon, color: AppColors.textSecondary, size: 20),
          const SizedBox(width: 12),
          Text(text, style: AppTextStyles.listItemTitle.copyWith(fontSize: 14)),
          const Spacer(),
          if (trailing != null) trailing,
        ],
      ),
    );
  }
  
  PopupMenuItem<String> _buildContestMenuItem() {
    return PopupMenuItem<String>(
      value: 'Contest',
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: const LinearGradient(
            colors: [Color(0xFF3A408E), Color(0xFF1E63B4)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Row(
          children: [
            const Icon(Icons.emoji_events_outlined, color: Colors.yellowAccent, size: 20),
            const SizedBox(width: 12),
            Text('Contest(S6)', style: AppTextStyles.listItemTitle.copyWith(fontSize: 14)),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserProfile(BuildContext context, AuthService authService) {
    final user = authService.user;
    if (user == null) return const SizedBox.shrink();

    final String shortAddress =
        '${user.walletAddress.substring(0, 5)}...${user.walletAddress.substring(user.walletAddress.length - 5)}';

    return PopupMenuButton<String>(
      onOpened: () => setState(() => _isMenuOpen = true),
      onCanceled: () => setState(() => _isMenuOpen = false),
      onSelected: (value) {
        setState(() => _isMenuOpen = false);
        
        if (value == 'Disconnect') {
          authService.logout();
        } else if (value == 'My Wallet') {
          widget.onWalletTapped();
        }
      },
      color: AppColors.cardBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        _buildMenuItem(icon: Icons.account_balance_wallet_outlined, text: 'My Wallet', value: 'My Wallet'),
        _buildMenuItem(icon: Icons.wallet_membership_outlined, text: 'Wallet Manager'),
        _buildMenuItem(
          icon: Icons.security_outlined,
          text: 'Security',
          trailing: const Text(
            'Not Bound',
            style: TextStyle(color: AppColors.downward, fontSize: 13, fontWeight: FontWeight.bold),
          ),
        ),
        _buildMenuItem(icon: Icons.card_giftcard_outlined, text: 'Referral'),
        _buildContestMenuItem(),
        _buildMenuItem(icon: Icons.upload_outlined, text: 'Withdraw'),
        _buildMenuItem(icon: Icons.telegram_outlined, text: 'TG Alert'),
        _buildMenuItem(icon: Icons.add_circle_outline, text: 'Add Twitter'),
        const PopupMenuDivider(height: 16),
        _buildMenuItem(icon: Icons.logout, text: 'Disconnect', value: 'Disconnect'),
      ],
      offset: const Offset(0, 12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.background,
              child: Icon(
                Icons.account_balance_wallet_outlined,
                color: AppColors.textSecondary,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: const [
                    Icon(Icons.wysiwyg_outlined, color: AppColors.textSecondary, size: 16),
                    SizedBox(width: 4),
                    Text(
                      "0",
                      style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, height: 1.2),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      shortAddress,
                      style: const TextStyle(color: AppColors.textSecondary, fontSize: 11, height: 1.0, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.copy, color: AppColors.textSecondary, size: 13),
                  ],
                ),
              ],
            ),
            const SizedBox(width: 16),
            Icon(_isMenuOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }

  Widget _buildCenterSection() {
    return Expanded(
      child: Center(
        child: SizedBox(
          width: 480,
          child: TextField(
            style: const TextStyle(color: AppColors.textPrimary),
            decoration: InputDecoration(
              hintText: 'Search tokens, contract address or wallet...',
              hintStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
              filled: true,
              fillColor: AppColors.cardBackground,
              prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
              suffixIcon: Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text('⌘K', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildAuthButtons(BuildContext context) {
    return Row(
      children: [
        OutlinedButton(
          onPressed: () {
             showCustomFadeDialog(
              context: context,
              child: const LoginDialog(),
            );
          },
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.textPrimary,
            side: const BorderSide(color: AppColors.textSecondary, width: 1),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            minimumSize: const Size(90, 40),
          ),
          child: const Text('Sign Up', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          onPressed: () {
            showCustomFadeDialog(
              context: context,
              child: const LoginDialog(),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            minimumSize: const Size(80, 40),
          ),
          child: const Text('Log In', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        ),
      ],
    );
  }
}
