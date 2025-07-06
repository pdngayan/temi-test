class RouteConstants {
  // Initial Routes
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  
  // Authentication Routes
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String pinSetup = '/pin-setup';
  static const String biometricSetup = '/biometric-setup';
  
  // Main Application Routes
  static const String home = '/home';
  static const String dashboard = '/dashboard';
  
  // Banking Routes
  static const String banking = '/banking';
  static const String accountBalance = '/banking/account-balance';
  static const String transactionHistory = '/banking/transaction-history';
  static const String loanInquiry = '/banking/loan-inquiry';
  static const String loanApplication = '/banking/loan-application';
  static const String loanCalculator = '/banking/loan-calculator';
  
  // Bill Payment Routes
  static const String billPayment = '/bill-payment';
  static const String mobileBillPayment = '/bill-payment/mobile';
  static const String utilityBillPayment = '/bill-payment/utility';
  static const String governmentPayment = '/bill-payment/government';
  static const String paymentHistory = '/bill-payment/history';
  static const String paymentConfirmation = '/bill-payment/confirmation';
  
  // KYC & Onboarding Routes
  static const String kyc = '/kyc';
  static const String kycDocumentUpload = '/kyc/document-upload';
  static const String kycSelfieCapture = '/kyc/selfie-capture';
  static const String kycVerification = '/kyc/verification';
  static const String accountCreation = '/kyc/account-creation';
  static const String kycStatus = '/kyc/status';
  
  // Help & Support Routes
  static const String help = '/help';
  static const String productCatalog = '/help/product-catalog';
  static const String navigationAssistance = '/help/navigation-assistance';
  static const String productDetails = '/help/product-details';
  static const String branchLocator = '/help/branch-locator';
  static const String atmLocator = '/help/atm-locator';
  static const String contactSupport = '/help/contact-support';
  static const String faq = '/help/faq';
  
  // Feedback Routes
  static const String feedback = '/feedback';
  static const String feedbackForm = '/feedback/form';
  static const String feedbackSuccess = '/feedback/success';
  static const String feedbackHistory = '/feedback/history';
  
  // Profile & Settings Routes
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String changePassword = '/settings/change-password';
  static const String changePIN = '/settings/change-pin';
  static const String languageSettings = '/settings/language';
  static const String notificationSettings = '/settings/notifications';
  static const String securitySettings = '/settings/security';
  
  // Error & Utility Routes
  static const String error = '/error';
  static const String noInternet = '/no-internet';
  static const String maintenance = '/maintenance';
  static const String sessionExpired = '/session-expired';
} 