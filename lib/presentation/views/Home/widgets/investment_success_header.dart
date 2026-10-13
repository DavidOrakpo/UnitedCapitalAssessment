import 'package:flutter/material.dart';
import 'package:template/presentation/styles/app_colors.dart';
import 'package:template/presentation/styles/text_styles.dart';

class InvestmentSuccessHeader extends StatelessWidget {
  const InvestmentSuccessHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        const SizedBox(height: 30),
        // Success Animated Check Icon
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            color: const Color(0xFF12B76A).withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Container(
              width: 68,
              height: 68,
              decoration: const BoxDecoration(
                color: Color(0xFF12B76A),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_rounded,
                color: Colors.white,
                size: 42,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Header Title
        Text(
          'Investment Successful!',
          style: AppTextStyle.headerThree.copyWith(
            fontWeight: FontWeight.w800,
            fontSize: 24,
            color: isDark ? Colors.white : AppColors.black2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Your investment has been created and will start generating yields immediately.',
          textAlign: TextAlign.center,
          style: AppTextStyle.bodyThree.copyWith(
            color: isDark ? Colors.white70 : const Color(0xFF667085),
            fontSize: 14,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
