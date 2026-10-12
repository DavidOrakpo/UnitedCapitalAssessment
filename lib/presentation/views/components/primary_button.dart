import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auto_size_text/flutter_auto_size_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template/core/Extensions/extensions.dart';
import 'package:template/presentation/styles/app_colors.dart';
import 'package:template/presentation/styles/darkMode_provider.dart';

import '../../styles/text_styles.dart';

class PrimaryButton extends ConsumerWidget {
  final double? cornerRadius;
  final double? width;
  final double height;
  final String? bonuzoIconPath;
  final double? leftPadding;
  final double? topPadding;
  final Color? backgroundColor;
  final String text;
  final Color textColor;
  final Color iconColor;
  final Color? disabledBackgroundColor;
  final Color? disabledForegroundColor;
  final Color? borderColor, shadowColor;
  final double fontSize;
  final List<Color>? gradientColorList;
  final List<double>? gradientStops;
  final bool hasIcon;
  final bool isBonuzoIcon;
  final bool filled;
  final bool hasShadow;
  final Alignment? begin, end;
  final double borderWidth;
  final bool hasGradient;
  final IconData? icon;
  final FontWeight fontweight;
  final bool isLoading;
  final bool? isValidated;
  final double? iconSize;
  final void Function()? onPressed;
  final double? maxFontSize;
  const PrimaryButton({
    super.key,
    this.cornerRadius = 12,
    this.gradientColorList,
    this.shadowColor,
    this.isValidated = true,
    this.bonuzoIconPath,
    this.isLoading = false,
    this.leftPadding,
    this.topPadding,
    this.gradientStops,
    this.hasIcon = false,
    this.isBonuzoIcon = false,
    this.begin,
    this.end,
    this.width,
    this.height = 55,
    this.iconSize,
    this.icon,
    this.hasShadow = false,
    this.borderColor,
    this.hasGradient = false,
    this.filled = true,
    this.iconColor = Colors.transparent,
    this.backgroundColor,
    this.borderWidth = 1,
    this.text = "",
    this.textColor = AppColors.white,
    this.fontSize = 16,
    this.fontweight = FontWeight.bold,
    this.onPressed,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.maxFontSize,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final brandColor = ref.watch(brandColorProvider).selectedBrandColor;
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: (isValidated ?? true) ? onPressed : null,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: disabledBackgroundColor,
          disabledForegroundColor: disabledForegroundColor,
          backgroundColor: (isValidated ?? true)
              ? backgroundColor ?? AppColors.primary
              : disabledForegroundColor ?? AppColors.textGray,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(cornerRadius ?? 60),
          ),
          padding: EdgeInsets.symmetric(
              horizontal: leftPadding ?? 45, vertical: topPadding ?? 17),
        ),
        child: isLoading
            ? const Center(
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: CupertinoActivityIndicator(
                    color: AppColors.white,
                    radius: 12,
                  ),
                ),
              )
            : hasIcon
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (!isBonuzoIcon)
                        Icon(
                          icon!,
                          color: iconColor,
                          size: iconSize ?? 18,
                        ),
                      // if (isBonuzoIcon)
                      //   BonuzoAsset(
                      //     imagePath: bonuzoIconPath!,
                      //     isIcon: true,
                      //     color: iconColor,
                      //     height: iconSize ?? 20,
                      //     scale: 3,
                      //   ),
                      if (text.isNotEmpty)
                        const SizedBox(
                          width: 10,
                        ),
                      if (maxFontSize != null)
                        Text(
                          text,
                          style: AppTextStyle.bodyThree.copyWith(
                            color: textColor,
                            fontSize: fontSize,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      if (maxFontSize == null)
                        AutoSizeText(
                          text,
                          maxLines: 1,
                          maxFontSize: maxFontSize != null ? null : fontSize,
                          style: AppTextStyle.bodyThree.copyWith(
                            color: textColor,
                            fontSize: fontSize,
                          ),
                        ),
                    ],
                  )
                : Consumer(
                    builder: (context, ref, child) {
                      final themeProv = ref.watch(themeProvider);
                      return AutoSizeText(
                        text,
                        maxLines: 1,
                        maxFontSize: maxFontSize != null ? null : fontSize,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.bodyThree.copyWith(
                          color: themeProv.darkTheme
                              ? (isValidated ?? true)
                                  ? textColor
                                  : AppColors.textGray.withOpacity(0.3)
                              : textColor,
                          fontSize: fontSize,
                          fontWeight: fontweight,
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}

class PrimaryOutlinedButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final Color? textColor;
  final Color? borderColor, backgroundColor;
  final double borderRadius;
  final double fontSize;
  final EdgeInsets? padding;
  final Widget? icon;
  final double? width;
  final double? borderWidth;
  final bool hasIcon;
  final double? height;

  const PrimaryOutlinedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textColor,
    this.borderColor,
    this.backgroundColor,
    this.borderRadius = 10,
    this.fontSize = 16,
    this.width,
    this.padding,
    this.height,
    this.hasIcon = false,
    this.icon,
    this.borderWidth = 1,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? 55,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: textColor,
          backgroundColor: backgroundColor ?? Colors.transparent,
          padding: padding ?? EdgeInsets.symmetric(horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          side: BorderSide(
            color: borderColor ?? AppColors.primary,
            width: borderWidth ?? 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (hasIcon) ...[
              icon!,
              4.0.horizontalSpace(),
            ],
            Text(
              text,
              style: AppTextStyle.bodyThree.copyWith(
                // color: textColor ?? AppColors.tangaroa.shade500,
                fontSize: fontSize,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
