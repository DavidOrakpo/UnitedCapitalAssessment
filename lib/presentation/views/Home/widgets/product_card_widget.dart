import 'package:flutter/material.dart';
import 'package:template/api/Models/products/products_model.dart';
import 'package:template/core/Utilities/Calculators/investment_calculator.dart';
import 'package:template/presentation/styles/app_colors.dart';
import 'package:template/presentation/styles/text_styles.dart';
import 'package:template/presentation/views/components/risk_badge.dart';

class ProductCardWidget extends StatelessWidget {
  final Productsmodelresponse product;
  final VoidCallback onTap;

  const ProductCardWidget({
    super.key,
    required this.product,
    required this.onTap,
  });

  IconData _getCategoryIcon(String iconName) {
    switch (iconName) {
      case 'account_balance':
        return Icons.account_balance_outlined;
      case 'savings':
        return Icons.savings_outlined;
      case 'eco':
        return Icons.eco_outlined;
      case 'pie_chart':
        return Icons.pie_chart_outline_rounded;
      case 'trending_up':
        return Icons.trending_up_rounded;
      default:
        return Icons.monetization_on_outlined;
    }
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
                // Top header: Category, Risk Badge & Rate Pill
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        _getCategoryIcon(product.iconName),
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.category,
                            style: AppTextStyle.bodyFour.copyWith(
                              color: isDark ? Colors.white60 : const Color(0xFF667085),
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            product.name,
                            style: AppTextStyle.headerFive.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: isDark ? Colors.white : AppColors.black2,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    RiskBadgeWidget(riskLevel: product.riskLevel, isSmall: true),
                  ],
                ),
                const SizedBox(height: 12),

                // Short Description
                Text(
                  product.shortDescription,
                  style: AppTextStyle.bodyThree.copyWith(
                    color: isDark ? Colors.white70 : const Color(0xFF475467),
                    fontSize: 13,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),

                // Metrics Divider
                Container(
                  height: 1,
                  color: borderColor,
                ),
                const SizedBox(height: 14),

                // Key Metrics: Expected Return, Duration, Min Amount
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Return Rate
                    _buildMetric(
                      context,
                      label: 'Expected Return',
                      value: product.returnRateDisplay,
                      valueColor: const Color(0xFF12B76A),
                      isHighlight: true,
                    ),
                    // Duration
                    _buildMetric(
                      context,
                      label: 'Duration',
                      value: product.durationLabel,
                    ),
                    // Min Amount
                    _buildMetric(
                      context,
                      label: 'Min. Investment',
                      value: InvestmentCalculator.formatCurrency(
                        product.minimumAmount,
                        symbol: product.currencySymbol,
                        decimalDigits: 0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Bottom Call To Action Button
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'View Details & Invest',
                        style: AppTextStyle.bodyTwo.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        color: AppColors.primary,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMetric(
    BuildContext context, {
    required String label,
    required String value,
    Color? valueColor,
    bool isHighlight = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.bodyFour.copyWith(
            color: isDark ? Colors.white54 : const Color(0xFF667085),
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyle.bodyTwo.copyWith(
            color: valueColor ?? (isDark ? Colors.white : AppColors.black2),
            fontSize: 14,
            fontWeight: isHighlight ? FontWeight.w800 : FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
