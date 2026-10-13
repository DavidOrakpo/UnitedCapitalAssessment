import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:template/api/Models/investments/create_investment_model.dart';
import 'package:template/api/Models/investments/investment_preview_model.dart';
import 'package:template/api/Models/products/products_model.dart';
import 'package:template/core/Alerts/context.dart';
import 'package:template/core/Utilities/Transitions/transitions.dart';
import 'package:template/presentation/views/Home/home_page.dart';
import 'package:template/presentation/views/Home/ui/bottom_nav_manager.dart';
import 'package:template/presentation/views/Home/ui/investment_confirmation_page.dart';
import 'package:template/presentation/views/Home/ui/investment_success_page.dart';
import 'package:template/presentation/views/Home/ui/product_details_page.dart';
import 'package:template/presentation/views/Profile/ui/profile_page.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return AppRoutes(ref: ref).router;
});

/// Manages the routing of pages within the app using [GoRouter]
class AppRoutes {
  AppRoutes._internal();
  late GoRouter router;

  static final AppRoutes _instance = AppRoutes._internal();
  factory AppRoutes({required Ref ref}) {
    _instance.router = GoRouter(
      navigatorKey: AppNavigator().navKey,
      initialLocation: "/",
      routes: [
        StatefulShellRoute.indexedStack(
          pageBuilder: (context, state, navigationShell) =>
              CustomFadeTransition(
            child: ScaffoldWithNestedNavigation(
              navigationShell: navigationShell,
            ),
          ),
          branches: [
            StatefulShellBranch(
              navigatorKey: AppNavigator().homePageKey,
              routes: [
                GoRoute(
                  path: "/",
                  name: HomePage.routeIdentifier,
                  builder: (context, state) => const HomePage(),
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: AppNavigator().userPageKey,
              routes: [
                GoRoute(
                  path: "/profile",
                  name: ProfilePage.routeIdentifier,
                  builder: (context, state) => const ProfilePage(),
                ),
              ],
            ),
          ],
        ),

        // Fullscreen Transaction Flow Routes (Cover Bottom Navigation Bar)
        GoRoute(
          parentNavigatorKey: AppNavigator().navKey,
          path: "/product-details",
          name: ProductDetailsPage.routeIdentifier,
          pageBuilder: (context, state) {
            final product = state.extra as Productsmodelresponse;
            return CustomIOSTransition(
              child: ProductDetailsPage(product: product),
            );
          },
        ),
        GoRoute(
          parentNavigatorKey: AppNavigator().navKey,
          path: "/confirm-investment",
          name: InvestmentConfirmationPage.routeIdentifier,
          pageBuilder: (context, state) {
            final extraMap = state.extra as Map<String, dynamic>;
            final product = extraMap['product'] as Productsmodelresponse;
            final amount = extraMap['amount'] as int;
            final preview = extraMap['preview'] as InvestmentPreviewModel;
            return CustomIOSTransition(
              child: InvestmentConfirmationPage(
                product: product,
                amount: amount,
                preview: preview,
              ),
            );
          },
        ),
        GoRoute(
          parentNavigatorKey: AppNavigator().navKey,
          path: "/investment-success",
          name: InvestmentSuccessPage.routeIdentifier,
          pageBuilder: (context, state) {
            final createdInvestment = state.extra as CreateInvestmentModel;
            return CustomIOSTransition(
              child: InvestmentSuccessPage(
                createdInvestment: createdInvestment,
              ),
            );
          },
        ),
      ],
    );
    return _instance;
  }
}
