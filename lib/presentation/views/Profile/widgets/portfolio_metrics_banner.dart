import 'package:flutter/material.dart';
import 'package:template/core/Utilities/Calculators/investment_calculator.dart';
import 'package:template/presentation/styles/text_styles.dart';

class PortfolioMetricsBanner extends StatelessWidget {
  final num totalInvested;
  final num totalExpectedReturns;
  final num totalPortfolioValue;
  final int activeInvestmentsCount;

  const PortfolioMetricsBanner({
    super.key,
    required this.totalInvested,
    required this.totalExpectedReturns,
    required this.totalPortfolioValue,
    required this.activeInvestmentsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF1E1B4B),
            Color(0xFF312E81),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E1B4B).withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TOTAL INVESTED CAPITAL',
            style: AppTextStyle.bodyFour.copyWith(
              color: Colors.white70,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            InvestmentCalculator.formatCurrency(totalInvested),
            style: AppTextStyle.headerTwo.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 32,
            ),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Estimated Returns',
                      style: AppTextStyle.bodyFour.copyWith(
                        color: Colors.white70,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '+${InvestmentCalculator.formatCurrency(totalExpectedReturns)}',
                      style: AppTextStyle.bodyTwo.copyWith(
                        color: const Color(0xFF6EE7B7),
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 28,
                  width: 1,
                  color: Colors.white24,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Maturity Value',
                      style: AppTextStyle.bodyFour.copyWith(
                        color: Colors.white70,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      InvestmentCalculator.formatCurrency(totalPortfolioValue),
                      style: AppTextStyle.bodyTwo.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 28,
                  width: 1,
                  color: Colors.white24,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Active Positions',
                      style: AppTextStyle.bodyFour.copyWith(
                        color: Colors.white70,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '$activeInvestmentsCount',
                      style: AppTextStyle.bodyTwo.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
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
}
