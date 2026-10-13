import 'package:flutter/material.dart';
import 'package:template/api/Models/investments/investment_preview_model.dart';
import 'package:template/core/Utilities/Calculators/investment_calculator.dart';
import 'package:template/presentation/styles/app_colors.dart';
import 'package:template/presentation/styles/text_styles.dart';

class FinancialBreakdownCard extends StatelessWidget {
  final InvestmentPreviewModel preview;

  const FinancialBreakdownCard({
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
            'Financial Breakdown',
            style: AppTextStyle.bodyTwo.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 15,
              color: isDark ? Colors.white : AppColors.black2,
            ),
          ),
          const SizedBox(height: 14),
          _buildRow(
            context,
            'Annual Return Rate',
            preview.returnRateDisplay,
            valueColor: const Color(0xFF12B76A),
            isBold: true,
          ),
          const Divider(height: 20),
          _buildRow(
            context,
            'Investment Duration',
            preview.durationLabel,
          ),
          const Divider(height: 20),
          _buildRow(
            context,
            'Estimated Earnings',
            '+${InvestmentCalculator.formatCurrency(preview.summaryBreakdown.estimatedEarnings, symbol: preview.currencySymbol)}',
            valueColor: const Color(0xFF15803D),
            isBold: true,
          ),
          const Divider(height: 20),
          _buildRow(
            context,
            'Management / Platform Fee',
            InvestmentCalculator.formatCurrency(
              preview.summaryBreakdown.managementFee,
              symbol: preview.currencySymbol,
            ),
            valueColor: const Color(0xFF12B76A),
          ),
          const Divider(height: 20),
          _buildRow(
            context,
            'Total Payout at Maturity',
            InvestmentCalculator.formatCurrency(
              preview.summaryBreakdown.netEstimatedPayout,
              symbol: preview.currencySymbol,
            ),
            valueColor: AppColors.primary,
            isBold: true,
            fontSize: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildRow(
    BuildContext context,
    String label,
    String value, {
    Color? valueColor,
    bool isBold = false,
    double fontSize = 13,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyle.bodyThree.copyWith(
            color: isDark ? Colors.white60 : const Color(0xFF667085),
            fontSize: fontSize,
          ),
        ),
        Text(
          value,
          style: AppTextStyle.bodyTwo.copyWith(
            color: valueColor ?? (isDark ? Colors.white : AppColors.black2),
            fontSize: fontSize,
            fontWeight: isBold ? FontWeight.w800 : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
