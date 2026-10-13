import 'package:flutter/material.dart';
import 'package:template/api/Models/products/products_model.dart';
import 'package:template/core/Utilities/Calculators/investment_calculator.dart';
import 'package:template/presentation/styles/app_colors.dart';
import 'package:template/presentation/styles/text_styles.dart';

class ProductSpecificationsCard extends StatelessWidget {
  final Productsmodelresponse product;

  const ProductSpecificationsCard({
    super.key,
    required this.product,
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
            'Product Specifications',
            style: AppTextStyle.bodyTwo.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 15,
              color: isDark ? Colors.white : AppColors.black2,
            ),
          ),
          const SizedBox(height: 14),
          _buildSpecRow(
            context,
            icon: Icons.payments_outlined,
            label: 'Minimum Amount',
            value: InvestmentCalculator.formatCurrency(
              product.minimumAmount,
              symbol: product.currencySymbol,
              decimalDigits: 0,
            ),
          ),
          const Divider(height: 20),
          _buildSpecRow(
            context,
            icon: Icons.account_balance_wallet_outlined,
            label: 'Maximum Amount',
            value: InvestmentCalculator.formatCurrency(
              product.maximumAmount,
              symbol: product.currencySymbol,
              decimalDigits: 0,
            ),
          ),
          const Divider(height: 20),
          _buildSpecRow(
            context,
            icon: Icons.schedule_rounded,
            label: 'Investment Tenure',
            value:
                '${product.durationDays} Days (${product.durationLabel})',
          ),
          const Divider(height: 20),
          _buildSpecRow(
            context,
            icon: Icons.currency_exchange_rounded,
            label: 'Payout Frequency',
            value: product.payoutFrequency,
          ),
          const Divider(height: 20),
          _buildSpecRow(
            context,
            icon: Icons.verified_user_outlined,
            label: 'Maturity Terms',
            value: product.maturityTerms,
            isMultiLine: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSpecRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    bool isMultiLine = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      crossAxisAlignment:
          isMultiLine ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 18,
          color: AppColors.primary,
        ),
        const SizedBox(width: 10),
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
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
