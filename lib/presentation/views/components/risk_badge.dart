import 'package:flutter/material.dart';
import 'package:template/presentation/styles/text_styles.dart';

class RiskBadgeWidget extends StatelessWidget {
  final String riskLevel;
  final bool isSmall;

  const RiskBadgeWidget({
    super.key,
    required this.riskLevel,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    IconData icon;

    final lower = riskLevel.toLowerCase();
    if (lower.contains('low')) {
      bg = const Color(0xFFE8F5E9);
      fg = const Color(0xFF2E7D32);
      icon = Icons.shield_outlined;
    } else if (lower.contains('medium')) {
      bg = const Color(0xFFFFF8E1);
      fg = const Color(0xFFF57F17);
      icon = Icons.trending_up_rounded;
    } else {
      bg = const Color(0xFFFFEBEE);
      fg = const Color(0xFFC62828);
      icon = Icons.bolt_rounded;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 8 : 10,
        vertical: isSmall ? 3 : 5,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: fg.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: isSmall ? 12 : 14,
            color: fg,
          ),
          const SizedBox(width: 4),
          Text(
            '$riskLevel Risk',
            style: AppTextStyle.bodyFive.copyWith(
              color: fg,
              fontSize: isSmall ? 10 : 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
