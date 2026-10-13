import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import '../../styles/darkMode_provider.dart';

class LoadingSkeleton extends ConsumerWidget {
  final double height;
  final double? width;
  final bool? isCircle;
  final double? borderRadius;
  final Color? baseColor;
  final Color? highlightColor;
  final bool hasBorder;

  const LoadingSkeleton({
    super.key,
    required this.height,
    this.width,
    this.isCircle = false,
    this.borderRadius,
    this.baseColor,
    this.highlightColor,
    this.hasBorder = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeProviderState = ref.watch(themeProvider);
    final isDark =
        Theme.of(context).brightness == Brightness.dark ||
        themeProviderState.darkTheme;

    // Tailored palette that seamlessly matches the app's card styles
    final defaultBaseColor = isDark
        ? const Color(0xFF1E1E2E)
        : const Color(0xFFE9ECEF);
    final defaultHighlightColor = isDark
        ? const Color(0xFF2C2C40)
        : const Color(0xFFF8F9FA);
    final borderColor = isDark ? Colors.white10 : const Color(0xFFEAECF0);

    final isCircular = isCircle ?? false;
    final effectiveRadius = borderRadius ?? (height < 30 ? 6.0 : 16.0);

    return Shimmer.fromColors(
      baseColor: baseColor ?? defaultBaseColor,
      highlightColor: highlightColor ?? defaultHighlightColor,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E2E) : Colors.white,
          borderRadius:
              isCircular ? null : BorderRadius.circular(effectiveRadius),
          shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
          border: (!isCircular && hasBorder)
              ? Border.all(color: borderColor, width: 1.0)
              : null,
        ),
      ),
    );
  }
}
