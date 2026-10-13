import 'package:flutter/material.dart';
import 'package:template/presentation/styles/app_colors.dart';
import 'package:template/presentation/styles/text_styles.dart';

class InvestorProfileHeader extends StatelessWidget {
  final String investorName;
  final String fundingSource;
  final VoidCallback onSettingsTap;

  const InvestorProfileHeader({
    super.key,
    required this.investorName,
    required this.fundingSource,
    required this.onSettingsTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: AppColors.primary.withValues(alpha: 0.15),
              child: const Text(
                'DI',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      investorName,
                      style: AppTextStyle.headerFive.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                        color: isDark ? Colors.white : AppColors.black2,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(
                      Icons.verified_rounded,
                      color: Color(0xFF12B76A),
                      size: 16,
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  fundingSource,
                  style: AppTextStyle.bodyFour.copyWith(
                    color: isDark ? Colors.white60 : const Color(0xFF667085),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        // Assessment Testing Tool button
        IconButton(
          icon: const Icon(
            Icons.tune_rounded,
            color: AppColors.primary,
          ),
          tooltip: 'Assessment Edge Case Controls',
          onPressed: onSettingsTap,
        ),
      ],
    );
  }
}
