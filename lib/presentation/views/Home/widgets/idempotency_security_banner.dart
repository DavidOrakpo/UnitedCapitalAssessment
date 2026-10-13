import 'package:flutter/material.dart';
import 'package:template/presentation/styles/text_styles.dart';

class IdempotencySecurityBanner extends StatelessWidget {
  const IdempotencySecurityBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF14141E) : const Color(0xFFF0FDF4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF86EFAC).withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.security_rounded,
            color: Color(0xFF15803D),
            size: 18,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Idempotency & Duplicate Protection Active',
                  style: AppTextStyle.bodyFour.copyWith(
                    color: isDark ? Colors.white : const Color(0xFF166534),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Session key ensures this order cannot be submitted twice accidentally.',
                  style: AppTextStyle.bodyThree.copyWith(
                    color: isDark ? Colors.white70 : const Color(0xFF166534),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
