import 'package:aesera_jewels/models/catalog_model.dart';
import 'package:aesera_jewels/models/goldcoin_payment_model.dart';
import 'package:aesera_jewels/models/summary_model.dart';
import 'package:aesera_jewels/modules/Gold_Coin/goldcoin_binding.dart';
import 'package:aesera_jewels/modules/Gold_Coin/goldcoin_screen.dart';
import 'package:aesera_jewels/modules/Gold_Coin_Payment/goldcoin_payment_binding.dart';
import 'package:aesera_jewels/modules/Gold_Coin_Payment/goldcoin_payment_controller.dart';
import 'package:aesera_jewels/modules/Gold_Coin_Payment/goldcoin_payment_screen.dart';
import 'package:aesera_jewels/modules/add_address/add_addresses_binding.dart';
import 'package:aesera_jewels/modules/add_address/add_addresses_screen.dart';
import 'package:aesera_jewels/modules/coin_catalog/coin_catalog_binding.dart';
import 'package:aesera_jewels/modules/coin_catalog/coin_catalog_screen.dart';
import 'package:aesera_jewels/modules/onboard/onboard_binding.dart';
import 'package:aesera_jewels/modules/onboard/onboard_view.dart';
import 'package:aesera_jewels/modules/payment/payment_binding.dart';
import 'package:aesera_jewels/modules/payment/payment_screen.dart';
import 'package:aesera_jewels/modules/address/address_binding.dart';
import 'package:aesera_jewels/modules/address/address_screen.dart';
import 'package:aesera_jewels/modules/summary/summary_binding.dart';
import 'package:aesera_jewels/modules/summary/summary_controller.dart';
import 'package:aesera_jewels/modules/summary/summary_screen.dart';
import 'package:get/get.dart';

// Splash
import 'package:aesera_jewels/modules/splash/splash_binding.dart';
import 'package:aesera_jewels/modules/splash/splash_view.dart';


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
// import 'package:aesera_jewels/modules/catalog/product_model.dart';
// TODO: Create 'product_model.dart' in 'lib/modules/catalog/' or update this import to the correct model file.

// Buy Gold
import 'package:aesera_jewels/modules/buy_gold/buy_gold_binding.dart';
import 'package:aesera_jewels/modules/buy_gold/buy_gold_view.dart';

// Portfolio
import 'package:aesera_jewels/modules/investment_details/investment_binding.dart';
import 'package:aesera_jewels/modules/investment_details/investment_view.dart';


class AppRoutes {
  // Route names
  static const splash = '/splash';
  static const jewelsForOccasion = '/jewels_for_occasion';
  static const register = '/register';
  static const login = '/login';
  static const otp = '/otp';
  static const summary = '/summary';
  static const goldcoin = '/goldcoin';
  static  const address = '/address';
  static const add_address = '/add_address ';
  static const dashboard = '/dashboard';
 static const scanToPay = '/scan_to_pay';
  static const catalog = '/catalog';
  static const goldcoinpayment = '/goldcoinpayment';

  static const investment = '/investment';
 static const payment_selection = '/payment_selection';
  //static const buyGold = '/buy_gold';
  static const coin_catalog = '/coin_catalog';
  static const payment = '/payment';
  static const UPIpayment = '/upi_payment';
  static const madeGoldEasy = '/made_gold_easy';
  static const seamlessPayments = '/seamless_payments';
 static const onboard = '/onboard';

 static const UpdateAddressScreen ="/update_address_screen";

  static final routes = [
    GetPage(name: splash, page: () =>SplashScreen(), binding: SplashBinding()),

    
    GetPage(
      name: register,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(name: goldcoin, page:()=> GoldCoinView(), binding: GoldCoinBinding()),
 
   GetPage(
      name: summary,
      page: () {
        // Get.arguments should contain the SummaryModel
        final SummaryModel summary = Get.arguments as SummaryModel;
        return SummaryScreen(summary: summary, );
      },
      binding: BindingsBuilder(() {
        final SummaryModel summary = Get.arguments as SummaryModel;
        Get.put(SummaryController(summary));
      }),
    ),
    GetPage(name: login, page: () => LoginView(), binding: LoginBinding()),
    GetPage(name: otp, page: () => OtpScreen(), binding: OtpBinding()),

    // Dashboard
    GetPage(
      name: dashboard,
      page: () => DashboardScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
    name: address,
      page: () => AddressScreen(),
      binding: AddressBinding(),
    ),
    GetPage(name: add_address, page: ()=>AddAddressScreen(),
    binding: AddAddressBinding()),
  GetPage(name: goldcoinpayment, 
  page: ()=>GoldCoinPaymentScreen(selectedCoins: []),
    binding: GoldCoinPaymentBinding()),
GetPage(
  name: catalog,
  page: () => CatalogScreen(),
  binding: BindingsBuilder(() {
    Get.lazyPut(() => CatalogController());
  }),
),
 GetPage(name:payment,
 page:()=>PaymentScreen(),
 binding: PaymentBinding() ),
    
  GetPage(
      name: onboard,
      page: () => OnboardingScreen(),
       binding: OnboardingBinding(),
    ),
    GetPage(
      name: investment,
      page: () => InvestmentDetailScreen(initialTabIndex: 0,),
      binding: InvestmentDetailBinding(),
    ),
    
    GetPage(name: onboard, page: () => OnboardingScreen(), binding: OnboardingBinding()),     
  ];

  
}


