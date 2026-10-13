import 'package:flutter/material.dart';
import 'package:template/presentation/views/components/primary_button.dart';

class ProductDetailsBottomBar extends StatelessWidget {
  final bool isLoading;
  final bool isValidated;
  final VoidCallback onPressed;

  const ProductDetailsBottomBar({
    super.key,
    required this.isLoading,
    required this.isValidated,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? const Color(0xFF1E1E2E) : Colors.white;
    final borderColor = isDark ? Colors.white10 : const Color(0xFFEAECF0);

    return Container(
      width: double.infinity,
      height: 80,
      // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
        text: 'Review & Invest Now',
        fontSize: 16,
        isLoading: isLoading,
        isValidated: isValidated,
        onPressed: onPressed,
      ),
    );
  }
}
