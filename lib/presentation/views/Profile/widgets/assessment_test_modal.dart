import 'package:flutter/material.dart';
import 'package:template/core/Alerts/notification_manager.dart';
import 'package:template/core/Controllers/user_controller.dart';
import 'package:template/presentation/styles/app_colors.dart';
import 'package:template/presentation/styles/text_styles.dart';

class SimulationControlModal extends StatelessWidget {
  final UserController controller;

  const SimulationControlModal({
    super.key,
    required this.controller,
  });

  static void show(BuildContext context, UserController controller) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SimulationControlModal(controller: controller),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Testing Controls',
              style: AppTextStyle.headerFive.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Use these controls to verify edge cases',
              style: AppTextStyle.bodyFour.copyWith(
                color: const Color(0xFF667085),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading:
                  const Icon(Icons.refresh_rounded, color: AppColors.primary),
              title: const Text('Normal Fetch (Default)'),
              subtitle: const Text('Fetches real investments from the server'),
              onTap: () {
                Navigator.pop(context);
                controller.getUserInvestments();
              },
            ),
            ListTile(
              leading: const Icon(Icons.error_outline_rounded,
                  color: AppColors.errorColor),
              title: const Text('Simulate Server Error (500)'),
              subtitle: const Text('Triggers API error state & retry flow'),
              onTap: () {
                Navigator.pop(context);
                controller.getUserInvestments(simulateError: true);
              },
            ),
            ListTile(
              leading: const Icon(Icons.inbox_outlined, color: Colors.orange),
              title: const Text('Simulate Empty Portfolio'),
              subtitle: const Text('Tests empty state UI with zero records'),
              onTap: () {
                Navigator.pop(context);
                controller.getUserInvestments(simulateEmpty: true);
              },
            ),
            ListTile(
              leading: const Icon(Icons.restart_alt_rounded,
                  color: Color(0xFF12B76A)),
              title: const Text('Reset Mock Data on Server'),
              subtitle: const Text('Restores default seed sample data'),
              onTap: () async {
                Navigator.pop(context);
                final res = await controller.resetInvestments();
                if (res.success) {
                  NotificationManager.notifySuccess('Server reset successful.');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
