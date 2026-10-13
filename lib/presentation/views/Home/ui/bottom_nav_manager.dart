import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:template/presentation/styles/app_colors.dart';

class ScaffoldWithNestedNavigation extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey('ScaffoldWithNestedNavigation'));

  void _goBranch(int index, WidgetRef ref) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
              // top: BorderSide(
              //   // color: Colors.red,
              //   color: AppColors.gray.shade500,
              //   width: 1.0,
              // ),

              ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 6,
              spreadRadius: 6,
            ),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            navigationBarTheme: NavigationBarThemeData(
              labelTextStyle: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return TextStyle(color: AppColors.primary);
                }
                return TextStyle(color: const Color(0xFF98A2B3));
              }),
              iconTheme: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return IconThemeData(color: AppColors.primary);
                }
                return IconThemeData(color: const Color(0xFF98A2B3));
              }),
            ),
          ),
          child: NavigationBar(
            selectedIndex: navigationShell.currentIndex,
            backgroundColor: Colors.transparent,
            indicatorColor: Colors.transparent,
            elevation: 10,
            overlayColor: WidgetStateProperty.all(
              Colors.transparent,
            ),
            destinations: _buildNavigationDestinations(ref),
            // destinations: [
            //   NavigationDestination(
            //     label: 'Home',
            //     icon: Image.asset(
            //       "assets/icons/home_icon.png",
            //       width: 24,
            //       height: 24,
            //       scale: 3,
            //       color: navigationShell.currentIndex == 0
            //           ? AppColors.primary
            //           : const Color(0xFF98A2B3),
            //     ),
            //   ),
            //   NavigationDestination(
            //     label: 'Inventory',
            //     icon: Image.asset(
            //       "assets/icons/inventory_icon.png",
            //       width: 24,
            //       height: 24,
            //       scale: 3,
            //       color: navigationShell.currentIndex == 1
            //           ? AppColors.primary
            //           : const Color(0xFF98A2B3),
            //     ),
            //   ),
            //   NavigationDestination(
            //     label: 'Transfer',
            //     icon: Image.asset(
            //       "assets/icons/transfers_icon.png",
            //       width: 24,
            //       height: 24,
            //       scale: 3,
            //       color: navigationShell.currentIndex == 2
            //           ? AppColors.primary
            //           : const Color(0xFF98A2B3),
            //     ),
            //   ),
            //   NavigationDestination(
            //     label: 'Sales',
            //     icon: Image.asset(
            //       "assets/icons/sales_icon.png",
            //       width: 24,
            //       height: 24,
            //       scale: 3,
            //       color: navigationShell.currentIndex == 3
            //           ? AppColors.primary
            //           : const Color(0xFF98A2B3),
            //     ),
            //   ),
            // ],
            onDestinationSelected: (index) => _goBranch(index, ref),
          ),
        ),
      ),
    );
  }

  List<NavigationDestination> _buildNavigationDestinations(WidgetRef ref) {
    // Check if user needs to see the lessons reminder (red dot)

    return [
      _buildNavigationDestination('Streak', 'plant_icon', 0),
      _buildNavigationDestination('Community', 'family_icon', 1),
      _buildNavigationDestination(
        'Lessons',
        'building_icon',
        2,
        showBadge: false,
      ),
      // _buildNavigationDestination('Prayers', 'prayer_hands_icon', 3),
      // _buildNavigationDestination('Qibla Finder', 'building_icon', 3),
      // _buildNavigationDestination('Community', 'community_icon', 3),
    ];
  }

  NavigationDestination _buildNavigationDestination(
    String label,
    String iconPath,
    int index, {
    bool showBadge = false,
  }) {
    final icon = Icon(Icons.home);

    return NavigationDestination(
      label: label,
      icon: icon,
    );
  }
}
