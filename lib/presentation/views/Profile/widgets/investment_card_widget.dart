import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:template/api/Models/investments/investment_model.dart';
import 'package:template/core/Alerts/notification_manager.dart';
import 'package:template/core/Utilities/Calculators/investment_calculator.dart';
import 'package:template/presentation/styles/app_colors.dart';
import 'package:template/presentation/styles/text_styles.dart';
import 'package:template/presentation/views/components/risk_badge.dart';

class InvestmentCardWidget extends StatelessWidget {
  final Investmentmodel investment;
  final VoidCallback onTap;

  const InvestmentCardWidget({
    super.key,
    required this.investment,
    required this.onTap,
  });

  void _copyReference(BuildContext context) {
    Clipboard.setData(ClipboardData(text: investment.referenceNumber));
    NotificationManager.notifySuccess('Reference copied: ${investment.referenceNumber}');
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? const Color(0xFF1E1E2E) : Colors.white;
    final borderColor = isDark ? Colors.white10 : const Color(0xFFEAECF0);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Reference & Status Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => _copyReference(context),
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Text(
                              investment.referenceNumber,
                              style: AppTextStyle.bodyFive.copyWith(
                                color: AppColors.primary,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.copy_rounded,
                              size: 12,
                              color: AppColors.primary,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFECFDF3),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFA6F4C5)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: Color(0xFF12B76A),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            investment.status,
                            style: AppTextStyle.bodyFive.copyWith(
                              color: const Color(0xFF027A48),
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Product Name & Category
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            investment.productName,
                            style: AppTextStyle.headerFive.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
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
                    const SizedBox(width: 8),
                    RiskBadgeWidget(riskLevel: investment.riskLevel, isSmall: true),
                  ],
                ),
                const SizedBox(height: 14),

                // Divider
                Container(
                  height: 1,
                  color: borderColor,
                ),
                const SizedBox(height: 14),

                // Metrics: Principal, Return, Maturity Payout
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Capital Invested',
                          style: AppTextStyle.bodyFour.copyWith(
                            color: isDark ? Colors.white54 : const Color(0xFF667085),
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          InvestmentCalculator.formatCurrency(
                            investment.investedAmount,
                            symbol: investment.currencySymbol,
                          ),
                          style: AppTextStyle.bodyTwo.copyWith(
                            color: isDark ? Colors.white : AppColors.black2,
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Estimated Yield',
                          style: AppTextStyle.bodyFour.copyWith(
                            color: isDark ? Colors.white54 : const Color(0xFF667085),
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '+${InvestmentCalculator.formatCurrency(investment.expectedReturnAmount, symbol: investment.currencySymbol)}',
                          style: AppTextStyle.bodyTwo.copyWith(
                            color: const Color(0xFF12B76A),
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Matures On',
                          style: AppTextStyle.bodyFour.copyWith(
                            color: isDark ? Colors.white54 : const Color(0xFF667085),
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          investment.formattedMaturityDate,
                          style: AppTextStyle.bodyTwo.copyWith(
                            color: isDark ? Colors.white70 : const Color(0xFF344054),
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Tap for full receipt hint
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'View Certificate & Breakdown',
                      style: AppTextStyle.bodyFour.copyWith(
                        color: AppColors.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColors.primary,
                      size: 11,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
