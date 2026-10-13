import 'package:flutter/material.dart';
import 'package:template/api/Models/investments/investment_preview_model.dart';
import 'package:template/core/Utilities/Calculators/investment_calculator.dart';
import 'package:template/presentation/styles/app_colors.dart';
import 'package:template/presentation/styles/text_styles.dart';
import 'package:template/presentation/views/components/risk_badge.dart';

class ConfirmationSummaryCard extends StatelessWidget {
  final InvestmentPreviewModel preview;

  const ConfirmationSummaryCard({
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  preview.productName,
                  style: AppTextStyle.headerFive.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 17,
                    color: isDark ? Colors.white : AppColors.black2,
                  ),
                ),
              ),
              RiskBadgeWidget(
                riskLevel: preview.riskLevel,
                isSmall: true,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            preview.category,
            style: AppTextStyle.bodyFour.copyWith(
              color: isDark ? Colors.white60 : const Color(0xFF667085),
              fontSize: 12,
            ),
          ),
          const Divider(height: 24),
          Center(
            child: Column(
              children: [
                Text(
                  'Investment Capital',
                  style: AppTextStyle.bodyFour.copyWith(
                    color: isDark ? Colors.white60 : const Color(0xFF667085),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  InvestmentCalculator.formatCurrency(
                    preview.investedAmount,
                    symbol: preview.currencySymbol,
                  ),
                  style: AppTextStyle.headerTwo.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w900,
                    fontSize: 32,
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
