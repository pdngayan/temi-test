import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/constants/route_constants.dart';
import 'core/theme/app_theme.dart';
import 'features/splash/presentation/pages/splash_page.dart';
import 'features/authentication/presentation/pages/login_page.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'shared/widgets/pages/coming_soon_page.dart';
import 'shared/widgets/pages/error_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set preferred orientations for Temi device
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  
  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  
  runApp(const SelfCareAgentApp());
}

class SelfCareAgentApp extends StatelessWidget {
  const SelfCareAgentApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Self Care Agent',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: RouteConstants.splash,
      onGenerateRoute: _generateRoute,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            // Ensure text scaling is appropriate for elderly users
            textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.3),
          ),
          child: child!,
        );
      },
    );
  }

  Route<dynamic>? _generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteConstants.splash:
        return _createRoute(const SplashPage());
      
      case RouteConstants.login:
        return _createRoute(const LoginPage());
      
      case RouteConstants.home:
        return _createRoute(const HomePage());
      
      // Authentication Routes
      case RouteConstants.signup:
        return _createRoute(_buildComingSoonPage('Sign Up'));
      
      case RouteConstants.forgotPassword:
        return _createRoute(_buildComingSoonPage('Forgot Password'));
      
      // Banking Routes
      case RouteConstants.banking:
        return _createRoute(_buildComingSoonPage('Banking Services'));
      
      case RouteConstants.accountBalance:
        return _createRoute(_buildComingSoonPage('Account Balance'));
      
      case RouteConstants.transactionHistory:
        return _createRoute(_buildComingSoonPage('Transaction History'));
      
      case RouteConstants.loanInquiry:
        return _createRoute(_buildComingSoonPage('Loan Inquiry'));
      
      // Bill Payment Routes
      case RouteConstants.billPayment:
        return _createRoute(_buildComingSoonPage('Bill Payment'));
      
      case RouteConstants.mobileBillPayment:
        return _createRoute(_buildComingSoonPage('Mobile Bill Payment'));
      
      case RouteConstants.utilityBillPayment:
        return _createRoute(_buildComingSoonPage('Utility Bill Payment'));
      
      case RouteConstants.governmentPayment:
        return _createRoute(_buildComingSoonPage('Government Payment'));
      
      // Help Routes
      case RouteConstants.help:
        return _createRoute(_buildComingSoonPage('Help & Support'));
      
      case RouteConstants.productCatalog:
        return _createRoute(_buildComingSoonPage('Product Catalog'));
      
      case RouteConstants.navigationAssistance:
        return _createRoute(_buildComingSoonPage('Navigation Assistance'));
      
      // Feedback Routes
      case RouteConstants.feedback:
        return _createRoute(_buildComingSoonPage('Feedback'));
      
      // Error Route
      case RouteConstants.error:
        return _createRoute(_buildErrorPage());
      
      default:
        return _createRoute(_buildNotFoundPage());
    }
  }

  PageRoute _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  Widget _buildComingSoonPage(String featureName) {
    return ComingSoonPage(featureName: featureName);
  }

  Widget _buildErrorPage() {
    return const ErrorPage();
  }

  Widget _buildNotFoundPage() {
    return const NotFoundPage();
  }
}
