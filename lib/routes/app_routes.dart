import 'package:aesera_jewels/modules/catalog/catalog_controller.dart';
import 'package:aesera_jewels/modules/catalog/catalog_view.dart';
import 'package:aesera_jewels/modules/dashboard/dashboard_binding.dart';
import 'package:aesera_jewels/modules/dashboard/dashboard_view.dart';
import 'package:aesera_jewels/modules/login/login_binding.dart';
import 'package:aesera_jewels/modules/login/login_view.dart';
import 'package:aesera_jewels/modules/otpverification/otp_binding.dart';
import 'package:aesera_jewels/modules/otpverification/otp_view.dart';
import 'package:aesera_jewels/modules/buy_gold/buy_gold_binding.dart';
import 'package:aesera_jewels/modules/buy_gold/buy_gold_view.dart';

import 'package:aesera_jewels/modules/investment_details/portfolio_binding.dart';
import 'package:aesera_jewels/modules/investment_details/portfolio_view.dart';
import 'package:aesera_jewels/modules/registration/register_binding.dart';
import 'package:aesera_jewels/modules/registration/register_view.dart';
import 'package:aesera_jewels/modules/scan_to_pay/scan_to_pay_controller.dart';
import 'package:aesera_jewels/modules/scan_to_pay/scan_to_pay_view.dart';
import 'package:aesera_jewels/modules/splash/splash_binding.dart';
import 'package:aesera_jewels/modules/splash/splash_view.dart';
import 'package:aesera_jewels/modules/welcome_screen1.dart/seamless_payments_binding.dart';
import 'package:aesera_jewels/modules/welcome_screen1.dart/seamless_payments_binding.dart';
import 'package:aesera_jewels/modules/welcome_screen1.dart/seamless_payments_view.dart';
import 'package:aesera_jewels/modules/welcome_screen2/made_gold_easy_binding.dart';
import 'package:aesera_jewels/modules/welcome_screen2/made_gold_easy_view.dart';

import 'package:aesera_jewels/modules/welcome_screen3/jewels_for_occasion_binding.dart';
import 'package:aesera_jewels/modules/welcome_screen3/welcome_view.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const splash = '/splash';
  static const JewelsForOccasion = '/JewelsForOccasion';
  static const register = '/register';
  static const login = '/login';
  static const otp = '/otp';
  static const dashboard = '/dashboard';
  static const scanToPay = '/scan_to_pay';
  static const catalog = '/catalog';
  static const portfolio = '/portfolio';
  static const paymentSelection = '/payment_selection';

  static const buyGold = '/buyGold';
  static const madeGoldEasy = '/madeGoldEasy';
  static const seamlessPayments = '/seamlessPayments';
  static const home = '/home';

  //static const BuyGold = '/payment-selection';

  static final routes = [
    GetPage(name: splash, page: () => SplashView(), binding: SplashBinding()),

    GetPage(
      name: JewelsForOccasion,
      page: () => JewelsForOccasionScreen(),
      binding: JewelsForOccasionBinding(),
    ),
    GetPage(
      name: register,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),

    GetPage(name: otp, page: () => const OtpView(), binding: OtpBinding()),
    GetPage(
      name: dashboard,
      page: () => DashboardScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: scanToPay,
      page: () => ScanToPayScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ScanToPayController());
      }),
    ),
    GetPage(
      name: seamlessPayments,
      page: () => SeamlessPaymentView(),
      binding: SeamlessPaymentBinding(),
    ),
    GetPage(
      name: catalog,
      page: () => CatalogScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => CatalogController());
      }),
    ),
    GetPage(
      name: portfolio,
      page: () => PortfolioScreen(),
      binding: PortfolioBinding(),
    ),

    GetPage(
      name: madeGoldEasy,
      page: () => MadeGoldEasyScreen(),
      binding: MadeGoldEasyBinding(),
    ),

    GetPage(name: dashboard, page: () => DashboardScreen()),

    GetPage(name: catalog, page: () => CatalogScreen()),
    // GetPage(name: portfolio, page: () => PortfolioScreen()),
    GetPage(name: login, page: () => LoginView(), binding: LoginBinding()),
    GetPage(
      name: buyGold,
      page: () => BuyGoldScreen(),
      binding: BuyGoldBinding(),
    ),
  ];
}
