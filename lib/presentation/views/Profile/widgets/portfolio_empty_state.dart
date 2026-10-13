import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:template/presentation/styles/app_colors.dart';
import 'package:template/presentation/styles/text_styles.dart';
import 'package:template/presentation/views/components/primary_button.dart';

class PortfolioEmptyState extends StatelessWidget {
  const PortfolioEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.account_balance_wallet_outlined,
              size: 48,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'No Active Investments Yet',
            style: AppTextStyle.headerFive.copyWith(
              fontWeight: FontWeight.w800,
              fontSize: 18,
              color: isDark ? Colors.white : AppColors.black2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'You haven\'t created any investment holdings yet. Explore our verified products and start earning fixed returns.',
            textAlign: TextAlign.center,
            style: AppTextStyle.bodyThree.copyWith(
              color: isDark ? Colors.white70 : const Color(0xFF667085),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            text: 'Explore Investment Products',
            width: 240,
            height: 48,
            onPressed: () {
              context.go('/');
            },
          ),
        ],
      ),
    );
  }
}
