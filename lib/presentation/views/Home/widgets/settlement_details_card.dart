import 'package:flutter/material.dart';
import 'package:template/api/Models/investments/investment_preview_model.dart';
import 'package:template/presentation/styles/app_colors.dart';
import 'package:template/presentation/styles/text_styles.dart';

class SettlementDetailsCard extends StatelessWidget {
  final InvestmentPreviewModel preview;

  const SettlementDetailsCard({
    super.key,
    required this.preview,
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
            'Settlement & Maturity Details',
            style: AppTextStyle.bodyTwo.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 15,
              color: isDark ? Colors.white : AppColors.black2,
            ),
          ),
          const SizedBox(height: 14),
          _buildRow(
            'Maturity Date',
            preview.formattedMaturityDate,
            isDark: isDark,
            isBold: true,
          ),
          const Divider(height: 20),
          _buildRow(
            'Payout Frequency',
            preview.payoutFrequency,
            isDark: isDark,
          ),
          const Divider(height: 20),
          _buildRow(
            'Terms of Settlement',
            preview.maturityTerms,
            isDark: isDark,
            isMultiLine: true,
          ),
        ],
      ),
    );
  }

  Widget _buildRow(
    String label,
    String value, {
    required bool isDark,
    bool isBold = false,
    bool isMultiLine = false,
  }) {
    return Row(
      crossAxisAlignment:
          isMultiLine ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: AppTextStyle.bodyThree.copyWith(
            color: isDark ? Colors.white60 : const Color(0xFF667085),
            fontSize: 13,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: AppTextStyle.bodyTwo.copyWith(
              color: isDark ? Colors.white : AppColors.black2,
              fontSize: 13,
              fontWeight: isBold ? FontWeight.w800 : FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
