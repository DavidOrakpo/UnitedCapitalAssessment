import 'package:flutter/material.dart';
import 'package:template/core/Utilities/Calculators/investment_calculator.dart';
import 'package:template/presentation/styles/app_colors.dart';
import 'package:template/presentation/styles/text_styles.dart';

class PortfolioSnapshotBanner extends StatelessWidget {
  final double totalInvested;
  final double totalExpectedReturns;
  final int activeInvestmentsCount;
  final VoidCallback onTapPortfolio;

  const PortfolioSnapshotBanner({
    super.key,
    required this.totalInvested,
    required this.totalExpectedReturns,
    required this.activeInvestmentsCount,
    required this.onTapPortfolio,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.primary,
            Color(0xFF4338CA),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Portfolio Capital',
                style: AppTextStyle.bodyFour.copyWith(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
              InkWell(
                onTap: onTapPortfolio,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '$activeInvestmentsCount Active',
                        style: AppTextStyle.bodyFive.copyWith(
                          color: Colors.white,
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                        size: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            InvestmentCalculator.formatCurrency(totalInvested),
            style: AppTextStyle.headerTwo.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(
                Icons.trending_up_rounded,
                color: Color(0xFF6EE7B7),
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(
                'Projected returns: +${InvestmentCalculator.formatCurrency(totalExpectedReturns)}',
                style: AppTextStyle.bodyThree.copyWith(
                  color: const Color(0xFF6EE7B7),
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
