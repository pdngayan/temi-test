class AppConstants {
  // App Information
  static const String appName = 'Self Care Agent';
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';
  
  // Device Configuration
  static const String targetDevice = 'Temi';
  static const bool isTabletOptimized = true;
  static const String preferredOrientation = 'landscape';
  
  // Session Management
  static const int sessionTimeoutMinutes = 10;
  static const int maxLoginAttempts = 3;
  static const int lockoutDurationMinutes = 15;
  static const int passwordMinLength = 8;
  
  // File Upload Limits
  static const int maxFileUploadSizeMB = 5;
  static const int maxImageSizeMB = 2;
  static const List<String> allowedImageFormats = ['jpg', 'jpeg', 'png'];
  static const List<String> allowedDocumentFormats = ['jpg', 'jpeg', 'png', 'pdf'];
  
  // UI Constants
  static const double minTouchTargetSize = 44.0;
  static const double defaultPadding = 16.0;
  static const double defaultBorderRadius = 8.0;
  static const int defaultAnimationDuration = 300;
  
  // Currency
  static const String currencyCode = 'LKR';
  static const String currencySymbol = 'Rs.';
  static const int currencyDecimalPlaces = 2;
  
  // Languages
  static const String defaultLanguage = 'en';
  static const List<String> supportedLanguages = ['en', 'si', 'ta'];
  
  // Date Formats
  static const String dateFormat = 'dd/MM/yyyy';
  static const String timeFormat = 'HH:mm';
  static const String dateTimeFormat = 'dd/MM/yyyy HH:mm';
  
  // Cache Duration
  static const int balanceCacheMinutes = 5;
  static const int transactionCacheHours = 24;
  static const int userProfileCacheHours = 12;
  
  // Performance
  static const int apiTimeoutSeconds = 30;
  static const int retryAttempts = 3;
  static const int retryDelaySeconds = 2;
} 