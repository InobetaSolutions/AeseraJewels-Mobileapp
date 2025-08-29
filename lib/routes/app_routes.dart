import 'package:aesera_jewels/modules/onboard/onboard_binding.dart';
import 'package:aesera_jewels/modules/onboard/onboard_view.dart';
import 'package:get/get.dart';

// Splash
import 'package:aesera_jewels/modules/splash/splash_binding.dart';
import 'package:aesera_jewels/modules/splash/splash_view.dart';

// Welcome Screens
import 'package:aesera_jewels/modules/welcome_screen1.dart/seamless_payments_binding.dart';
import 'package:aesera_jewels/modules/welcome_screen1.dart/seamless_payments_view.dart';
import 'package:aesera_jewels/modules/welcome_screen2/made_gold_easy_binding.dart';
import 'package:aesera_jewels/modules/welcome_screen2/made_gold_easy_view.dart';
import 'package:aesera_jewels/modules/welcome_screen3/jewels_for_occasion_binding.dart';
import 'package:aesera_jewels/modules/welcome_screen3/jewels_of_occasion_view.dart';

// Auth
import 'package:aesera_jewels/modules/registration/register_binding.dart';
import 'package:aesera_jewels/modules/registration/register_view.dart';
import 'package:aesera_jewels/modules/login/login_binding.dart';
import 'package:aesera_jewels/modules/login/login_view.dart';
import 'package:aesera_jewels/modules/otpverification/otp_binding.dart';
import 'package:aesera_jewels/modules/otpverification/otp_view.dart';

// Dashboard
import 'package:aesera_jewels/modules/dashboard/dashboard_binding.dart';
import 'package:aesera_jewels/modules/dashboard/dashboard_view.dart';

// Catalog
import 'package:aesera_jewels/modules/catalog/catalog_controller.dart';
import 'package:aesera_jewels/modules/catalog/catalog_view.dart';

// Buy Gold
import 'package:aesera_jewels/modules/buy_gold/buy_gold_binding.dart';
import 'package:aesera_jewels/modules/buy_gold/buy_gold_view.dart';

// Portfolio
import 'package:aesera_jewels/modules/investment_details/portfolio_binding.dart';
import 'package:aesera_jewels/modules/investment_details/portfolio_view.dart';

// Payments
import 'package:aesera_jewels/modules/payment_selection/payment_selection_controller.dart';
import 'package:aesera_jewels/modules/payment_selection/payment_selection_view.dart';
import 'package:aesera_jewels/modules/payment_selection/payment_selection_binding.dart';

// Scan to Pay
import 'package:aesera_jewels/modules/scan_to_pay/scan_to_pay_controller.dart';
import 'package:aesera_jewels/modules/scan_to_pay/scan_to_pay_view.dart';

class AppRoutes {
  // Route names
  static const splash = '/splash';
  static const jewelsForOccasion = '/jewels_for_occasion';
  static const register = '/register';
  static const login = '/login';
  static const otp = '/otp';
  static const dashboard = '/dashboard';
  //  static const scanToPay = '/scan_to_pay';
  static const catalog = '/catalog';
  static const investment = '/investment';
  static const payment = '/payment';
  static const buyGold = '/buy_gold';
  static const madeGoldEasy = '/made_gold_easy';
  static const seamlessPayments = '/seamless_payments';
 static const onboard = '/onboard';

  static final routes = [
    GetPage(name: splash, page: () => SplashView(), binding: SplashBinding()),

    // Welcome Screens
    // GetPage(
    //   name: jewelsForOccasion,
    //   page: () => JewelsForOccasionScreen(),
    //   binding: JewelsForOccasionBinding(),
    // ),
    // GetPage(
    //   name: seamlessPayments,
    //   page: () => SeamlessPaymentView(),
    //   binding: SeamlessPaymentBinding(),
    // ),
    // GetPage(
    //   name: madeGoldEasy,
    //   page: () => MadeGoldEasyScreen(),
    //   binding: MadeGoldEasyBinding(),
    // ),

    // Auth
    GetPage(
      name: register,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(name: login, page: () => LoginView(), binding: LoginBinding()),
    GetPage(name: otp, page: () => OtpView(), binding: OtpBinding()),

    // Dashboard
    GetPage(
      name: dashboard,
      page: () => DashboardScreen(),
      binding: DashboardBinding(),
    ),

    // Catalog
    GetPage(
      name: catalog,
      page: () => CatalogScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => CatalogController());
      }),
    ),

    // Buy Gold
    GetPage(
      name: buyGold,
      page: () => BuyGoldScreen(),
      binding: BuyGoldBinding(),
    ),

    
  GetPage(
      name: onboard,
      page: () => OnboardingScreen(),
       binding: OnboardingBinding(),
    ),
    GetPage(name: payment, page: () => PaymentScreen(sourceScreen: Get.arguments["source"] ?? "")),
    // GetPage(name: investment, page: () => InvestmentDetailScreen(initialTabIndex: 0), binding: InvestmentBinding()),
    
  ];
}
