import 'package:flutter/material.dart';
import 'package:template/api/Models/investments/create_investment_model.dart';
import 'package:template/core/Utilities/Calculators/investment_calculator.dart';
import 'package:template/presentation/styles/app_colors.dart';
import 'package:template/presentation/styles/text_styles.dart';

class InvestmentReceiptCard extends StatelessWidget {
  final CreateInvestmentModel createdInvestment;

  const InvestmentReceiptCard({
    super.key,
    required this.createdInvestment,
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
        children: [
          _buildReceiptRow(
            context,
            label: 'Asset',
            value: createdInvestment.productName,
            isBold: true,
          ),
          const Divider(height: 20),
          _buildReceiptRow(
            context,
            label: 'Principal Invested',
            value: InvestmentCalculator.formatCurrency(
              createdInvestment.investedAmount,
              symbol: createdInvestment.currencySymbol,
            ),
            isBold: true,
          ),
          const Divider(height: 20),
          _buildReceiptRow(
            context,
            label: 'Return Rate',
            value: createdInvestment.returnRateDisplay,
            valueColor: const Color(0xFF12B76A),
          ),
          const Divider(height: 20),
          _buildReceiptRow(
            context,
            label: 'Expected Maturity Payout',
            value: InvestmentCalculator.formatCurrency(
              createdInvestment.totalPayoutAtMaturity,
              symbol: createdInvestment.currencySymbol,
            ),
            valueColor: AppColors.primary,
            isBold: true,
          ),
          const Divider(height: 20),
          _buildReceiptRow(
            context,
            label: 'Maturity Date',
            value: createdInvestment.formattedMaturityDate,
          ),
          const Divider(height: 20),
          _buildReceiptRow(
            context,
            label: 'Status',
            value: createdInvestment.status,
            valueColor: const Color(0xFF12B76A),
            isStatus: true,
          ),
        ],
      ),
    );
  }

  Widget _buildReceiptRow(
    BuildContext context, {
    required String label,
    required String value,
    Color? valueColor,
    bool isBold = false,
    bool isStatus = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyle.bodyThree.copyWith(
            color: isDark ? Colors.white60 : const Color(0xFF667085),
            fontSize: 13,
          ),
        ),
        if (isStatus)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: const Color(0xFFECFDF3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFA6F4C5)),
            ),
            child: Text(
              value,
              style: AppTextStyle.bodyFour.copyWith(
                color: const Color(0xFF027A48),
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          )
        else
          Text(
            value,
            style: AppTextStyle.bodyTwo.copyWith(
              color: valueColor ?? (isDark ? Colors.white : AppColors.black2),
              fontSize: 13,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
      ],
    );
  }
}
