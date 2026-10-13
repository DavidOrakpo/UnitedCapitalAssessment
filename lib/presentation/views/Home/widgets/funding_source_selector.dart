import 'package:flutter/material.dart';
import 'package:template/presentation/styles/app_colors.dart';
import 'package:template/presentation/styles/text_styles.dart';

class FundingSourceSelector extends StatelessWidget {
  final List<String> sources;
  final String selectedSource;
  final ValueChanged<String> onSelectSource;

  const FundingSourceSelector({
    super.key,
    required this.sources,
    required this.selectedSource,
    required this.onSelectSource,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? const Color(0xFF1E1E2E) : Colors.white;
    final borderColor = isDark ? Colors.white10 : const Color(0xFFEAECF0);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Funding Source',
            style: AppTextStyle.bodyTwo.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 15,
              color: isDark ? Colors.white : AppColors.black2,
            ),
          ),
          const SizedBox(height: 12),
          ...sources.map((source) {
            final isSelected = selectedSource == source;
            return InkWell(
              onTap: () => onSelectSource(source),
              borderRadius: BorderRadius.circular(10),
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary.withValues(alpha: 0.08)
                      : (isDark
                          ? const Color(0xFF14141E)
                          : const Color(0xFFF9FAFB)),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : borderColor,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      isSelected
                          ? Icons.radio_button_checked_rounded
                          : Icons.radio_button_off_rounded,
                      color: isSelected
                          ? AppColors.primary
                          : (isDark
                              ? Colors.white54
                              : const Color(0xFF98A2B3)),
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      source,
                      style: AppTextStyle.bodyThree.copyWith(
                        color: isDark ? Colors.white : AppColors.black2,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
