import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:template/api/Models/investments/create_investment_model.dart';
import 'package:template/core/Controllers/user_controller.dart';
import 'package:template/presentation/styles/app_colors.dart';
import 'package:template/presentation/views/Home/widgets/investment_receipt_card.dart';
import 'package:template/presentation/views/Home/widgets/investment_success_header.dart';
import 'package:template/presentation/views/Home/widgets/reference_number_card.dart';
import 'package:template/presentation/views/components/primary_button.dart';

class InvestmentSuccessPage extends ConsumerWidget {
  static const routeIdentifier = "INVESTMENT_SUCCESS_PAGE";
  final CreateInvestmentModel createdInvestment;

  const InvestmentSuccessPage({
    super.key,
    required this.createdInvestment,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? const Color(0xFF12121A) : const Color(0xFFF8F9FA);
    final borderColor = isDark ? Colors.white10 : const Color(0xFFEAECF0);

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10)
              .copyWith(bottom: 0),
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              children: [
                const InvestmentSuccessHeader(),
                const SizedBox(height: 28),
                ReferenceNumberCard(createdInvestment: createdInvestment),
                const SizedBox(height: 20),
                InvestmentReceiptCard(createdInvestment: createdInvestment),
                const SizedBox(height: 24),
                PrimaryButton(
                  text: 'View in Portfolio',
                  onPressed: () {
                    // Refresh user investments and navigate to profile tab
                    ref
                        .read(userControllerProvider.notifier)
                        .getUserInvestments();
                    context.go('/profile');
                  },
                ),
                const SizedBox(height: 12),
                PrimaryOutlinedButton(
                  text: 'Explore More Products',
                  borderColor: borderColor,
                  textColor: isDark ? Colors.white : AppColors.black2,
                  onPressed: () {
                    context.go('/');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
