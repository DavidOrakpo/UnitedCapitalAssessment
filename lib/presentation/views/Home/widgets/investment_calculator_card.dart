import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:template/api/Models/products/products_model.dart';
import 'package:template/core/Utilities/Calculators/investment_calculator.dart';
import 'package:template/core/Utilities/Validators/currency_formatter.dart';
import 'package:template/presentation/styles/app_colors.dart';
import 'package:template/presentation/styles/text_styles.dart';

class InvestmentCalculatorCard extends StatelessWidget {
  final Productsmodelresponse product;
  final TextEditingController controller;
  final CurrencyInputFormatter currencyFormatter;
  final String? validationMessage;
  final int currentAmount;
  final ValueChanged<int> onApplyPreset;
  final ValueChanged<int> onAddIncrement;

  const InvestmentCalculatorCard({
    super.key,
    required this.product,
    required this.controller,
    required this.currencyFormatter,
    required this.validationMessage,
    required this.currentAmount,
    required this.onApplyPreset,
    required this.onAddIncrement,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? const Color(0xFF1E1E2E) : Colors.white;
    final borderColor = isDark ? Colors.white10 : const Color(0xFFEAECF0);

    final estimatedEarnings = InvestmentCalculator.calculateEstimatedEarnings(
      principal: currentAmount,
      annualInterestRate: product.annualInterestRate,
      durationDays: product.durationDays,
    );
    final totalPayout = InvestmentCalculator.calculateTotalPayout(
      principal: currentAmount,
      estimatedEarnings: estimatedEarnings,
    );

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: validationMessage != null
              ? AppColors.errorColor
              : AppColors.primary.withValues(alpha: 0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.calculate_outlined,
                color: AppColors.primary,
                size: 22,
              ),
              const SizedBox(width: 8),
              Text(
                'Calculate Your Return',
                style: AppTextStyle.headerFive.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                  color: isDark ? Colors.white : AppColors.black2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Enter an amount to simulate your expected yield upon maturity.',
            style: AppTextStyle.bodyThree.copyWith(
              color: isDark ? Colors.white60 : const Color(0xFF667085),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 16),

          // Amount Input Field with Currency Formatter
          TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              currencyFormatter,
            ],
            style: AppTextStyle.headerFour.copyWith(
              color: isDark ? Colors.white : AppColors.black,
              fontWeight: FontWeight.w800,
              fontSize: 20,
            ),
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Text(
                  product.currencySymbol,
                  style: AppTextStyle.headerFour.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              prefixIconConstraints:
                  const BoxConstraints(minWidth: 0, minHeight: 0),
              hintText: '0',
              suffixText: product.currency,
              suffixStyle: AppTextStyle.bodyTwo.copyWith(
                color: isDark ? Colors.white60 : const Color(0xFF667085),
              ),
              filled: true,
              fillColor: isDark
                  ? const Color(0xFF14141E)
                  : const Color(0xFFF9FAFB),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: borderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: validationMessage != null
                      ? AppColors.errorColor
                      : borderColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 1.5,
                ),
              ),
            ),
          ),

          // Error validation message
          if (validationMessage != null) ...[
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(
                  Icons.error_outline_rounded,
                  color: AppColors.errorColor,
                  size: 14,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    validationMessage!,
                    style: AppTextStyle.bodyFour.copyWith(
                      color: AppColors.errorColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 12),

          // Quick Amount Presets
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildQuickChip(
                context,
                'Min (${product.currencySymbol}${product.minimumAmount})',
                () => onApplyPreset(product.minimumAmount),
              ),
              _buildQuickChip(
                context,
                '+${product.currencySymbol}500',
                () => onAddIncrement(500),
              ),
              _buildQuickChip(
                context,
                '+${product.currencySymbol}1,000',
                () => onAddIncrement(1000),
              ),
              _buildQuickChip(
                context,
                'Max (${product.currencySymbol}${product.maximumAmount})',
                () => onApplyPreset(product.maximumAmount),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Yield Calculation Box
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF14141E)
                  : const Color(0xFFF0FDF4),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color(0xFF86EFAC).withValues(alpha: 0.5),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Estimated Interest (${product.durationLabel})',
                      style: AppTextStyle.bodyThree.copyWith(
                        color:
                            isDark ? Colors.white70 : const Color(0xFF166534),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '+${InvestmentCalculator.formatCurrency(estimatedEarnings, symbol: product.currencySymbol)}',
                      style: AppTextStyle.bodyTwo.copyWith(
                        color: const Color(0xFF15803D),
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const Divider(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Payout at Maturity',
                      style: AppTextStyle.bodyTwo.copyWith(
                        color: isDark ? Colors.white : const Color(0xFF0F172A),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      InvestmentCalculator.formatCurrency(
                        totalPayout,
                        symbol: product.currencySymbol,
                      ),
                      style: AppTextStyle.headerFive.copyWith(
                        color: AppColors.primary,
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickChip(
    BuildContext context,
    String label,
    VoidCallback onTap,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isDark ? Colors.white10 : const Color(0xFFF2F4F7),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: AppTextStyle.bodyFour.copyWith(
            color: isDark ? Colors.white70 : const Color(0xFF344054),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
