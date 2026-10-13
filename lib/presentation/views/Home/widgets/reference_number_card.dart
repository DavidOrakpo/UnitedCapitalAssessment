import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:template/api/Models/investments/create_investment_model.dart';
import 'package:template/core/Alerts/notification_manager.dart';
import 'package:template/presentation/styles/app_colors.dart';
import 'package:template/presentation/styles/text_styles.dart';

class ReferenceNumberCard extends StatelessWidget {
  final CreateInvestmentModel createdInvestment;

  const ReferenceNumberCard({
    super.key,
    required this.createdInvestment,
  });

  void _copyReference(BuildContext context) {
    Clipboard.setData(ClipboardData(text: createdInvestment.referenceNumber));
    NotificationManager.notifySuccess('Reference number copied to clipboard!');
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? const Color(0xFF1E1E2E) : Colors.white;

    return Column(
      children: [
        if (createdInvestment.wasDuplicatePrevented) ...[
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFBEB),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFFDE68A)),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.info_outline_rounded,
                  color: Color(0xFFD97706),
                  size: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Duplicate submission prevented. Your original investment was safely preserved.',
                    style: AppTextStyle.bodyFour.copyWith(
                      color: const Color(0xFF92400E),
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],

        // Reference Number Card (Tap to Copy)
        InkWell(
          onTap: () => _copyReference(context),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.4),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.06),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TRANSACTION REFERENCE',
                      style: AppTextStyle.bodyFour.copyWith(
                        color: isDark ? Colors.white54 : const Color(0xFF667085),
                        fontSize: 10,
                        letterSpacing: 1.1,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      createdInvestment.referenceNumber,
                      style: AppTextStyle.headerFive.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: 17,
                        color: AppColors.primary,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.copy_rounded,
                    color: AppColors.primary,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
