import 'package:flutter/material.dart';
import 'package:template/core/Utilities/Enums/enums.dart';
import 'package:template/presentation/styles/app_colors.dart';
import 'package:template/presentation/styles/text_styles.dart';

class RiskFilterChips extends StatelessWidget {
  final RiskLevel? selectedRisk;
  final ValueChanged<RiskLevel?> onSelectRisk;

  const RiskFilterChips({
    super.key,
    required this.selectedRisk,
    required this.onSelectRisk,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildChip(
            context,
            label: 'All Risk Levels',
            isSelected: selectedRisk == null,
            onTap: () => onSelectRisk(null),
          ),
          const SizedBox(width: 8),
          _buildChip(
            context,
            label: 'Low Risk',
            isSelected: selectedRisk == RiskLevel.Low,
            onTap: () => onSelectRisk(RiskLevel.Low),
          ),
          const SizedBox(width: 8),
          _buildChip(
            context,
            label: 'Medium Risk',
            isSelected: selectedRisk == RiskLevel.Medium,
            onTap: () => onSelectRisk(RiskLevel.Medium),
          ),
          const SizedBox(width: 8),
          _buildChip(
            context,
            label: 'High Risk',
            isSelected: selectedRisk == RiskLevel.High,
            onTap: () => onSelectRisk(RiskLevel.High),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(
    BuildContext context, {
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary
              : (isDark ? const Color(0xFF1E1E2E) : Colors.white),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : (isDark ? Colors.white10 : const Color(0xFFD0D5DD)),
          ),
        ),
        child: Text(
          label,
          style: AppTextStyle.bodyFour.copyWith(
            color: isSelected
                ? Colors.white
                : (isDark ? Colors.white70 : const Color(0xFF344054)),
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
