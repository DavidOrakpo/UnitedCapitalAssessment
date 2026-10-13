import 'package:flutter/material.dart';
import 'package:template/presentation/styles/app_colors.dart';
import 'package:template/presentation/styles/text_styles.dart';
import 'package:template/presentation/views/components/primary_button.dart';

class HomeErrorState extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;

  const HomeErrorState({
    super.key,
    required this.errorMessage,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.cloud_off_rounded,
            size: 56,
            color: AppColors.errorColor,
          ),
          const SizedBox(height: 14),
          Text(
            'Failed to Load Products',
            style: AppTextStyle.headerFive.copyWith(
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : AppColors.black2,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: AppTextStyle.bodyThree.copyWith(
              color: isDark ? Colors.white70 : const Color(0xFF667085),
            ),
          ),
          const SizedBox(height: 20),
          PrimaryButton(
            text: 'Retry Loading',
            width: 160,
            height: 46,
            onPressed: onRetry,
          ),
        ],
      ),
    );
  }
}
