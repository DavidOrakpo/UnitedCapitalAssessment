import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:template/api/Models/investments/investment_model.dart';
import 'package:template/core/Alerts/notification_manager.dart';
import 'package:template/core/Utilities/Calculators/investment_calculator.dart';
import 'package:template/presentation/styles/app_colors.dart';
import 'package:template/presentation/styles/text_styles.dart';
import 'package:template/presentation/views/components/risk_badge.dart';

class InvestmentDetailsBottomSheet extends StatelessWidget {
  final Investmentmodel investment;

  const InvestmentDetailsBottomSheet({
    super.key,
    required this.investment,
  });

  static void show(BuildContext context, Investmentmodel investment) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => InvestmentDetailsBottomSheet(investment: investment),
    );
  }

  void _copyReference(BuildContext context) {
    Clipboard.setData(ClipboardData(text: investment.referenceNumber));
    NotificationManager.notifySuccess('Reference copied: ${investment.referenceNumber}');
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? const Color(0xFF1E1E2E) : Colors.white;

    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        top: 16,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark ? Colors.white24 : const Color(0xFFD0D5DD),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 18),

            // Top Header: Title and Close button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Investment Certificate',
                  style: AppTextStyle.headerFive.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    color: isDark ? Colors.white : AppColors.black2,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded, size: 20),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Reference Card
            InkWell(
              onTap: () => _copyReference(context),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CERTIFICATE REFERENCE NUMBER',
                          style: AppTextStyle.bodyFour.copyWith(
                            color: isDark ? Colors.white54 : const Color(0xFF667085),
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          investment.referenceNumber,
                          style: AppTextStyle.bodyTwo.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.copy_rounded,
                      color: AppColors.primary,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),

            // Product Header & Risk
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        investment.productName,
                        style: AppTextStyle.headerFive.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 17,
                          color: isDark ? Colors.white : AppColors.black2,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        investment.category,
                        style: AppTextStyle.bodyFour.copyWith(
                          color: isDark ? Colors.white60 : const Color(0xFF667085),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                RiskBadgeWidget(riskLevel: investment.riskLevel, isSmall: true),
              ],
            ),
            const Divider(height: 24),

            // Details List
            _buildDetailItem(
              context,
              label: 'Principal Invested',
              value: InvestmentCalculator.formatCurrency(
                investment.investedAmount,
                symbol: investment.currencySymbol,
              ),
              isBold: true,
            ),
            const Divider(height: 18),
            _buildDetailItem(
              context,
              label: 'Annual Return Rate',
              value: investment.returnRateDisplay,
              valueColor: const Color(0xFF12B76A),
              isBold: true,
            ),
            const Divider(height: 18),
            _buildDetailItem(
              context,
              label: 'Tenure Duration',
              value: investment.durationLabel,
            ),
            const Divider(height: 18),
            _buildDetailItem(
              context,
              label: 'Estimated Interest Yield',
              value: '+${InvestmentCalculator.formatCurrency(investment.expectedReturnAmount, symbol: investment.currencySymbol)}',
              valueColor: const Color(0xFF15803D),
              isBold: true,
            ),
            const Divider(height: 18),
            _buildDetailItem(
              context,
              label: 'Total Payout at Maturity',
              value: InvestmentCalculator.formatCurrency(
                investment.totalPayoutAtMaturity,
                symbol: investment.currencySymbol,
              ),
              valueColor: AppColors.primary,
              isBold: true,
              fontSize: 16,
            ),
            const Divider(height: 18),
            _buildDetailItem(
              context,
              label: 'Creation Date',
              value: investment.formattedCreatedAt,
            ),
            const Divider(height: 18),
            _buildDetailItem(
              context,
              label: 'Maturity Date',
              value: investment.formattedMaturityDate,
              isBold: true,
            ),
            const Divider(height: 18),
            _buildDetailItem(
              context,
              label: 'Investor Name',
              value: investment.investorName,
            ),
            const Divider(height: 18),
            _buildDetailItem(
              context,
              label: 'Funding Source',
              value: investment.fundingSource,
            ),
            const Divider(height: 18),
            _buildDetailItem(
              context,
              label: 'Status',
              value: investment.status,
              valueColor: const Color(0xFF12B76A),
              isBold: true,
            ),
            const SizedBox(height: 24),

            // Close CTA
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Dismiss',
                  style: AppTextStyle.bodyTwo.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(
    BuildContext context, {
    required String label,
    required String value,
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
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
