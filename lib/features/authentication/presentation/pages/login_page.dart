import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/route_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/buttons/primary_button.dart';
import '../../../../shared/services/message_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  bool _rememberMe = false;
  bool _isBiometricAvailable = false;
  int _loginAttempts = 0;

  @override
  void initState() {
    super.initState();
    _checkBiometricAvailability();
    _loadSavedCredentials();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _checkBiometricAvailability() async {
    // TODO: Check if biometric authentication is available
    setState(() {
      _isBiometricAvailable = true; // Simulated for now
    });
  }

  Future<void> _loadSavedCredentials() async {
    // TODO: Load saved credentials if remember me was enabled
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // TODO: Implement actual login logic with BLoC
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call
      
      // Simulate login success/failure
      if (_emailController.text == 'test@example.com' && 
          _passwordController.text == 'password123') {
        _onLoginSuccess();
      } else {
        _onLoginFailure('Invalid email or password');
      }
    } catch (error) {
      _onLoginFailure('An error occurred. Please try again.');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onLoginSuccess() {
    MessageService.showSnackbar(
      context,
      'Login successful!',
      type: MessageType.success,
    );
    Navigator.of(context).pushReplacementNamed(RouteConstants.home);
  }

  void _onLoginFailure(String message) {
    setState(() {
      _loginAttempts++;
    });

    if (_loginAttempts >= AppConstants.maxLoginAttempts) {
      MessageService.showSnackbar(
        context,
        'Account locked for ${AppConstants.lockoutDurationMinutes} minutes due to multiple failed attempts.',
        type: MessageType.error,
      );
    } else {
      MessageService.showSnackbar(
        context,
        '$message (${AppConstants.maxLoginAttempts - _loginAttempts} attempts remaining)',
        type: MessageType.error,
      );
    }
  }

  Future<void> _handleBiometricLogin() async {
    try {
      // TODO: Implement biometric authentication
      MessageService.showSnackbar(
        context,
        'Biometric authentication not implemented yet',
        type: MessageType.info,
      );
    } catch (error) {
      MessageService.showSnackbar(
        context,
        'Biometric authentication failed',
        type: MessageType.error,
      );
    }
  }

  void _navigateToSignUp() {
    Navigator.of(context).pushNamed(RouteConstants.signup);
  }

  void _navigateToForgotPassword() {
    Navigator.of(context).pushNamed(RouteConstants.forgotPassword);
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < AppConstants.passwordMinLength) {
      return 'Password must be at least ${AppConstants.passwordMinLength} characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // App Logo and Title
                    _buildHeader(),
                    
                    const SizedBox(height: 48),
                    
                    // Login Form
                    _buildLoginForm(),
                    
                    const SizedBox(height: 24),
                    
                    // Remember Me and Forgot Password
                    _buildOptionsRow(),
                    
                    const SizedBox(height: 32),
                    
                    // Login Button
                    PrimaryButton(
                      text: 'Login',
                      onPressed: _handleLogin,
                      isLoading: _isLoading,
                      width: double.infinity,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Biometric Login
                    if (_isBiometricAvailable) _buildBiometricLogin(),
                    
                    const SizedBox(height: 32),
                    
                    // Divider
                    const Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text('OR'),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Sign Up Link
                    _buildSignUpLink(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(
            Icons.account_balance,
            size: 50,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Welcome Back',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.onBackground,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Sign in to access your banking services',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Column(
      children: [
        // Email Field
        TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          validator: _validateEmail,
          decoration: const InputDecoration(
            labelText: 'Email Address',
            hintText: 'Enter your email address',
            prefixIcon: Icon(Icons.email_outlined),
          ),
        ),
        
        const SizedBox(height: 20),
        
        // Password Field
        TextFormField(
          controller: _passwordController,
          obscureText: !_isPasswordVisible,
          textInputAction: TextInputAction.done,
          validator: _validatePassword,
          onFieldSubmitted: (_) => _handleLogin(),
          decoration: InputDecoration(
            labelText: 'Password',
            hintText: 'Enter your password',
            prefixIcon: const Icon(Icons.lock_outlined),
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOptionsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Remember Me
        Row(
          children: [
            Checkbox(
              value: _rememberMe,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value ?? false;
                });
              },
            ),
            const Text('Remember me'),
          ],
        ),
        
        // Forgot Password
        TextButton(
          onPressed: _navigateToForgotPassword,
          child: const Text('Forgot Password?'),
        ),
      ],
    );
  }

  Widget _buildBiometricLogin() {
    return Column(
      children: [
        OutlinedButton.icon(
          onPressed: _handleBiometricLogin,
          icon: const Icon(Icons.fingerprint),
          label: const Text('Login with Biometrics'),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 56),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSignUpLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        TextButton(
          onPressed: _navigateToSignUp,
          child: const Text(
            'Sign Up',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
} 