import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/route_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/loading/loading_indicator.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _initializeApp();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 0.8, curve: Curves.elasticOut),
    ));

    _animationController.forward();
  }

  Future<void> _initializeApp() async {
    try {
      // Simulate app initialization tasks
      await Future.wait([
        _initializeFirebase(),
        _checkAuthentication(),
        _loadUserPreferences(),
        _checkAppVersion(),
        Future.delayed(const Duration(seconds: 3)), // Minimum splash duration
      ]);

      // Navigate based on authentication state
      if (mounted) {
        _navigateToNextScreen();
      }
    } catch (error) {
      if (mounted) {
        _handleInitializationError(error);
      }
    }
  }

  Future<void> _initializeFirebase() async {
    // TODO: Initialize Firebase
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> _checkAuthentication() async {
    // TODO: Check if user is authenticated
    await Future.delayed(const Duration(milliseconds: 300));
  }

  Future<void> _loadUserPreferences() async {
    // TODO: Load user preferences and settings
    await Future.delayed(const Duration(milliseconds: 200));
  }

  Future<void> _checkAppVersion() async {
    // TODO: Check for app updates
    await Future.delayed(const Duration(milliseconds: 100));
  }

  void _navigateToNextScreen() {
    // TODO: Implement proper navigation logic based on auth state
    Navigator.of(context).pushReplacementNamed(RouteConstants.login);
  }

  void _handleInitializationError(dynamic error) {
    // TODO: Handle initialization errors
    Navigator.of(context).pushReplacementNamed(RouteConstants.error);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Set system UI overlay style for splash screen
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.primary,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.primaryGradient,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              
              // App Logo and Title
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: _fadeAnimation,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: Column(
                        children: [
                          // App Icon/Logo
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.account_balance,
                              size: 60,
                              color: AppColors.primary,
                            ),
                          ),
                          
                          const SizedBox(height: 24),
                          
                          // App Name
                          Text(
                            AppConstants.appName,
                            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          
                          const SizedBox(height: 8),
                          
                          // App Tagline
                          Text(
                            'Your Banking Companion',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Colors.white.withOpacity(0.9),
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              
              const Spacer(flex: 2),
              
              // Loading Indicator
              const LoadingIndicator(
                message: 'Initializing...',
                color: Colors.white,
                size: 32,
              ),
              
              const SizedBox(height: 40),
              
              // App Version
              Text(
                'Version ${AppConstants.appVersion}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Optimized for Temi
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Optimized for ${AppConstants.targetDevice}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
} 