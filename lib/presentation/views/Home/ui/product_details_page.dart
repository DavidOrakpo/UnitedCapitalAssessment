import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:template/api/Models/products/products_model.dart';
import 'package:template/core/Alerts/notification_manager.dart';
import 'package:template/core/Controllers/user_controller.dart';
import 'package:template/core/Utilities/Validators/currency_formatter.dart';
import 'package:template/core/Utilities/Validators/investment_validator.dart';
import 'package:template/presentation/styles/app_colors.dart';
import 'package:template/presentation/styles/text_styles.dart';
import 'package:template/presentation/views/Home/ui/investment_confirmation_page.dart';
import 'package:template/presentation/views/Home/widgets/investment_calculator_card.dart';
import 'package:template/presentation/views/Home/widgets/product_description_card.dart';
import 'package:template/presentation/views/Home/widgets/product_details_bottom_bar.dart';
import 'package:template/presentation/views/Home/widgets/product_header_banner.dart';
import 'package:template/presentation/views/Home/widgets/product_highlights_card.dart';
import 'package:template/presentation/views/Home/widgets/product_specifications_card.dart';

class ProductDetailsPage extends ConsumerStatefulWidget {
  static const routeIdentifier = "PRODUCT_DETAILS_PAGE";
  final Productsmodelresponse product;

  const ProductDetailsPage({
    super.key,
    required this.product,
  });

  @override
  ConsumerState<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends ConsumerState<ProductDetailsPage> {
  final _amountController = TextEditingController();
  late final CurrencyInputFormatter currencyInputFormatter;
  final _formKey = GlobalKey<FormState>();
  int _currentAmount = 0;
  String? _amountValidationMessage;

  @override
  void initState() {
    super.initState();
    _currentAmount = widget.product.minimumAmount;
    currencyInputFormatter = CurrencyInputFormatter(
      currencySymbol: '', // Prefix widget already shows currency symbol
      decimalDigits: 0,
    );
    _amountController.text = currencyInputFormatter.format(_currentAmount);
    _amountController.addListener(_onAmountChanged);
  }

  @override
  void dispose() {
    _amountController.removeListener(_onAmountChanged);
    _amountController.dispose();
    super.dispose();
  }

  void _onAmountChanged() {
    final parsed = InvestmentValidator.parseAmount(_amountController.text);
    setState(() {
      _currentAmount = parsed ?? 0;
      _amountValidationMessage = InvestmentValidator.validateAmount(
        _amountController.text,
        minAmount: widget.product.minimumAmount,
        maxAmount: widget.product.maximumAmount,
        currencySymbol: widget.product.currencySymbol,
      );
    });
  }

  void _applyQuickAmount(int amount) {
    _amountController.text = currencyInputFormatter.format(amount);
  }

  void _addQuickAmount(int increment) {
    final current =
        InvestmentValidator.parseAmount(_amountController.text) ?? 0;
    final target = current + increment;
    final capped = (widget.product.maximumAmount > 0 &&
            target > widget.product.maximumAmount)
        ? widget.product.maximumAmount
        : target;
    _amountController.text = currencyInputFormatter.format(capped);
  }

  Future<void> _handleProceedToConfirmation() async {
    final validation = InvestmentValidator.validateAmount(
      _amountController.text,
      minAmount: widget.product.minimumAmount,
      maxAmount: widget.product.maximumAmount,
      currencySymbol: widget.product.currencySymbol,
    );

    if (validation != null) {
      setState(() {
        _amountValidationMessage = validation;
      });
      NotificationManager.notifyError(validation);
      return;
    }

    final amountToInvest = _currentAmount;

    // Fetch the live preview from server
    final controller = ref.read(userControllerProvider.notifier);
    final response = await controller.previewInvestment(
      productId: widget.product.id,
      amount: amountToInvest,
    );

    if (!mounted) return;

    if (response.success && response.data != null) {
      context.pushNamed(
        InvestmentConfirmationPage.routeIdentifier,
        extra: {
          'product': widget.product,
          'amount': amountToInvest,
          'preview': response.data,
        },
      );
    } else {
      NotificationManager.notifyError(
        response.message.isNotEmpty
            ? response.message
            : 'Unable to prepare investment preview. Please try again.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? const Color(0xFF12121A) : const Color(0xFFF8F9FA);
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
          'Product Details',
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductHeaderBanner(product: widget.product),
                      const SizedBox(height: 20),
                      ProductSpecificationsCard(product: widget.product),
                      const SizedBox(height: 20),
                      ProductHighlightsCard(
                        highlights: widget.product.highlights,
                      ),
                      const SizedBox(height: 20),
                      ProductDescriptionCard(
                        description: widget.product.fullDescription,
                      ),
                      const SizedBox(height: 24),
                      InvestmentCalculatorCard(
                        product: widget.product,
                        controller: _amountController,
                        currencyFormatter: currencyInputFormatter,
                        validationMessage: _amountValidationMessage,
                        currentAmount: _currentAmount,
                        onApplyPreset: _applyQuickAmount,
                        onAddIncrement: _addQuickAmount,
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
            ProductDetailsBottomBar(
              isLoading: state.isLoadingPreview,
              isValidated:
                  _amountValidationMessage == null && _currentAmount > 0,
              onPressed: _handleProceedToConfirmation,
            ),
          ],
        ),
      ),
    );
  }
}
