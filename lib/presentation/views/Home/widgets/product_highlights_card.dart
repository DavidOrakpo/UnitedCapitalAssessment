import 'package:flutter/material.dart';
import 'package:template/presentation/styles/app_colors.dart';
import 'package:template/presentation/styles/text_styles.dart';

class ProductHighlightsCard extends StatelessWidget {
  final List<String> highlights;

  const ProductHighlightsCard({
    super.key,
    required this.highlights,
  });

  @override
  Widget build(BuildContext context) {
    if (highlights.isEmpty) return const SizedBox.shrink();

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
            'Key Highlights',
            style: AppTextStyle.bodyTwo.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 15,
              color: isDark ? Colors.white : AppColors.black2,
            ),
          ),
          const SizedBox(height: 12),
          ...highlights.map(
            (highlight) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.check_circle_rounded,
                    color: Color(0xFF12B76A),
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      highlight,
                      style: AppTextStyle.bodyThree.copyWith(
                        color: isDark
                            ? Colors.white70
                            : const Color(0xFF344054),
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
