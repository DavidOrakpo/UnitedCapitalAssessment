import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:template/api/Models/investments/create_investment_model.dart';
import 'package:template/api/Models/investments/investment_preview_model.dart';
import 'package:template/api/Models/products/products_model.dart';
import 'package:template/core/Alerts/notification_manager.dart';
import 'package:template/core/Controllers/user_controller.dart';
import 'package:template/presentation/styles/app_colors.dart';
import 'package:template/presentation/styles/text_styles.dart';
import 'package:template/presentation/views/Home/ui/investment_success_page.dart';
import 'package:template/presentation/views/Home/widgets/confirmation_summary_card.dart';
import 'package:template/presentation/views/Home/widgets/financial_breakdown_card.dart';
import 'package:template/presentation/views/Home/widgets/funding_source_selector.dart';
import 'package:template/presentation/views/Home/widgets/idempotency_security_banner.dart';
import 'package:template/presentation/views/Home/widgets/settlement_details_card.dart';
import 'package:template/presentation/views/components/primary_button.dart';

class InvestmentConfirmationPage extends ConsumerStatefulWidget {
  static const routeIdentifier = "INVESTMENT_CONFIRMATION_PAGE";
  final Productsmodelresponse product;
  final int amount;
  final InvestmentPreviewModel preview;

  const InvestmentConfirmationPage({
    super.key,
    required this.product,
    required this.amount,
    required this.preview,
  });

  @override
  ConsumerState<InvestmentConfirmationPage> createState() =>
      _InvestmentConfirmationPageState();
}

class _InvestmentConfirmationPageState
    extends ConsumerState<InvestmentConfirmationPage> {
  late final String _idempotencyKey;
  String _selectedFundingSource = 'Primary Wallet';
  bool _agreedToTerms = true;
  bool _isSubmitting = false;

  final List<String> _fundingSources = [
    'Primary Wallet',
    'High-Yield Savings (..4821)',
    'Direct Bank Transfer',
  ];

  @override
  void initState() {
    super.initState();
    _idempotencyKey =
        'idemp-${DateTime.now().millisecondsSinceEpoch}-${Random().nextInt(999999)}';
  }

  Future<void> _handleConfirmInvestment() async {
    if (_isSubmitting) return;

    if (!_agreedToTerms) {
      NotificationManager.notifyError(
        'Please accept the investment terms to proceed.',
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    final controller = ref.read(userControllerProvider.notifier);
    final response = await controller.createInvestment(
      productId: widget.product.id,
      amount: widget.amount,
      investorName: 'Demo Investor',
      fundingSource: _selectedFundingSource,
      idempotencyKey: _idempotencyKey,
    );

    if (!mounted) return;

    setState(() {
      _isSubmitting = false;
    });

    if (response.success && response.data is CreateInvestmentModel) {
      final created = response.data as CreateInvestmentModel;
      context.pushReplacementNamed(
        InvestmentSuccessPage.routeIdentifier,
        extra: created,
      );
    } else {
      NotificationManager.notifyError(
        response.message.isNotEmpty
            ? response.message
            : 'Failed to create investment. Please try again.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? const Color(0xFF12121A) : const Color(0xFFF8F9FA);
    final cardBg = isDark ? const Color(0xFF1E1E2E) : Colors.white;
    final borderColor = isDark ? Colors.white10 : const Color(0xFFEAECF0);
    final state = ref.watch(userControllerProvider);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF1E1E2E) : Colors.white,
        foregroundColor: isDark ? Colors.white : AppColors.black,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: isDark ? Colors.white : AppColors.black,
            size: 20,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Confirm Investment',
          style: AppTextStyle.headerFive.copyWith(
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : AppColors.black,
          ),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConfirmationSummaryCard(preview: widget.preview),
                    const SizedBox(height: 18),
                    FinancialBreakdownCard(preview: widget.preview),
                    const SizedBox(height: 18),
                    SettlementDetailsCard(preview: widget.preview),
                    const SizedBox(height: 18),
                    FundingSourceSelector(
                      sources: _fundingSources,
                      selectedSource: _selectedFundingSource,
                      onSelectSource: (s) =>
                          setState(() => _selectedFundingSource = s),
                    ),
                    const SizedBox(height: 18),

                    // Idempotency Note
                    const IdempotencySecurityBanner(),
                    const SizedBox(height: 16),

                    // Terms Checkbox
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: _agreedToTerms,
                          activeColor: AppColors.primary,
                          onChanged: (val) {
                            setState(() {
                              _agreedToTerms = val ?? false;
                            });
                          },
                        ),
                        Expanded(
                          child: Text(
                            'I confirm and authorize this investment under the stated maturity terms.',
                            style: AppTextStyle.bodyThree.copyWith(
                              color: isDark
                                  ? Colors.white70
                                  : const Color(0xFF475467),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // Fixed Bottom CTA Bar
            Container(
              width: double.infinity,
              height: 80,
              // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                color: cardBg,
                border: Border(top: BorderSide(color: borderColor)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: PrimaryButton(
                text: _isSubmitting
                    ? 'Confirming Investment...'
                    : 'Confirm & Create Investment',
                isLoading: _isSubmitting || state.isCreatingInvestment,
                isValidated: _agreedToTerms && !_isSubmitting,
                onPressed: _handleConfirmInvestment,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
