import 'package:anjastore/src/controllers/invoice_detail_controller.dart';
import 'package:anjastore/src/repositories/session_repository.dart';
import 'package:anjastore/src/views/web/web_customer_page.dart';
import 'package:anjastore/src/views/web/web_dashboard_page.dart';
import 'package:anjastore/src/views/web/web_expense_page.dart';
import 'package:anjastore/src/views/web/web_home_page.dart';
import 'package:anjastore/src/views/web/web_invoice_detail_page.dart';
import 'package:anjastore/src/views/web/web_invoice_page.dart';
import 'package:anjastore/src/views/web/web_product_page.dart';
import 'package:anjastore/src/views/web/web_profile_page.dart';
import 'package:anjastore/src/views/web/web_signin_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../src/controllers/controller.dart';
import '../src/controllers/home_controller.dart';
import 'app_route_name.dart';

final navigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKey = GlobalKey<NavigatorState>();

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}

GoRouter router = GoRouter(
  errorBuilder: (context, state) => Container(),
  navigatorKey: navigatorKey,
  initialLocation: "/",
  debugLogDiagnostics: true,
  redirect: (context, state) {
    return SessionRepository.isLoggedIn();
  },
  routes: [
    ShellRoute(
      navigatorKey: shellNavigatorKey,
      pageBuilder: ((context, state, child) {
        Get.put(DashboardController());
        return buildPageWithDefaultTransition(
          context: context,
          state: state,
          child: WebDashboardPage(
            widget: child,
            route: state.matchedLocation,
          ),
        );
      }),
      routes: [
        GoRoute(
          path: "/",
          name: AppRouteName.app,
          onExit: (context) {
            // Get.delete<DashboardController>();
            return true;
          },
          pageBuilder: (context, state) {
            return const NoTransitionPage(
              child: SizedBox(),
            );
          },
          routes: [
            GoRoute(
              path: AppRouteName.home,
              name: AppRouteName.home,
              onExit: (context) {
                Get.delete<HomeController>();
                return true;
              },
              pageBuilder: (context, state) {
                Get.put(HomeController());
                return NoTransitionPage(child: WebHomePage());
              },
            ),
            GoRoute(
              path: AppRouteName.profile,
              name: AppRouteName.profile,
              onExit: (context) {
                Get.delete<ProfileController>();
                return true;
              },
              pageBuilder: (context, state) {
                Get.put(ProfileController());
                return NoTransitionPage(child: WebProfilePage());
              },
            ),
            GoRoute(
              path: AppRouteName.customers,
              name: AppRouteName.customers,
              onExit: (context) {
                Get.delete<CustomerController>();
                return true;
              },
              pageBuilder: (context, state) {
                Get.put(CustomerController());
                return NoTransitionPage(child: WebCustomerPage());
              },
            ),
            GoRoute(
              path: AppRouteName.products,
              name: AppRouteName.products,
              onExit: (context) {
                Get.delete<ProductController>();
                return true;
              },
              pageBuilder: (context, state) {
                Get.put(ProductController());
                return NoTransitionPage(child: WebProductPage());
              },
            ),
            GoRoute(
              path: AppRouteName.expenses,
              name: AppRouteName.expenses,
              onExit: (context) {
                Get.delete<ExpenseController>();
                return true;
              },
              pageBuilder: (context, state) {
                Get.put(ExpenseController());
                return NoTransitionPage(child: WebExpensePage());
              },
            ),
            GoRoute(
              path: AppRouteName.invoices,
              name: AppRouteName.invoices,
              onExit: (context) {
                Get.delete<InvoiceController>();
                return true;
              },
              pageBuilder: (context, state) {
                Get.put(InvoiceController());
                return NoTransitionPage(child: WebInvoicePage());
              },
            ),
          ],
        ),
      ],
    ),
    // GoRoute(
    //   path: '/signout',
    //   name: AppRouteName.signout,
    //   builder: (context, state) {
    //     return const SignoutPage();
    //   },
    // ),
    GoRoute(
      path: '/signin',
      name: AppRouteName.signin,
      builder: (context, state) {
        return WebSigninPage();
      },
    ),
    GoRoute(
      path: '/invoice/:id',
      name: AppRouteName.invoicesDetail,
      onExit: (context) {
        Get.delete<InvoiceDetailController>();
        return true;
      },
      pageBuilder: (context, state) {
        String id = state.pathParameters["id"] ?? "";
        Get.put(InvoiceDetailController()).invoiceId.value = id;
        return NoTransitionPage(child: WebInvoiceDetailPage());
      },
    ),
  ],
);
