import 'package:flutter/material.dart';
import 'package:template/presentation/styles/app_colors.dart';
import 'package:template/presentation/styles/text_styles.dart';
import 'package:template/presentation/views/components/primary_button.dart';

class HomeEmptyState extends StatelessWidget {
  final VoidCallback onReset;

  const HomeEmptyState({
    super.key,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 60,
            color: isDark ? Colors.white30 : const Color(0xFFD0D5DD),
          ),
          const SizedBox(height: 14),
          Text(
            'No Products Found',
            style: AppTextStyle.headerFive.copyWith(
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : AppColors.black2,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Try adjusting your search query or clear the risk level filters.',
            textAlign: TextAlign.center,
            style: AppTextStyle.bodyThree.copyWith(
              color: isDark ? Colors.white70 : const Color(0xFF667085),
            ),
          ),
          const SizedBox(height: 18),
          PrimaryOutlinedButton(
            text: 'Reset Filters',
            width: 150,
            height: 44,
            borderColor: AppColors.primary,
            textColor: AppColors.primary,
            onPressed: onReset,
          ),
        ],
      ),
    );
  }
}
