# Flutter Self-Care Agent - Business Rules

## Overview
This document defines the business rules, validation logic, and functional requirements for the Flutter Self-Care Agent banking application designed for Temi devices.

## 1. Authentication & Security

### 1.1 User Authentication Rules
- **Login Attempts**: Maximum 3 failed login attempts before account lockout
- **Account Lockout**: 15-minute lockout period after failed attempts
- **Session Timeout**: 10 minutes of inactivity triggers automatic logout
- **Password Requirements**: 
  - Minimum 8 characters
  - At least one uppercase letter
  - At least one number
  - At least one special character
- **Biometric Authentication**: Support fingerprint and face recognition where available
- **PIN Authentication**: 4-6 digit PIN for quick access

### 1.2 Security Protocols
- **Data Encryption**: All sensitive data encrypted using AES-256
- **Token Management**: JWT tokens with 24-hour expiry
- **API Security**: All API calls require valid authentication tokens
- **Screen Lock**: Automatic screen lock after 2 minutes of inactivity
- **Screenshot Prevention**: Disable screenshots in sensitive screens
- **App Background**: Hide app content when moved to background

### 1.3 Audit Trail Requirements
- **Transaction Logging**: Log all financial transactions with timestamps
- **User Activity**: Track user actions for security monitoring
- **Error Logging**: Comprehensive error logging for debugging
- **Compliance Logging**: Maintain logs for regulatory compliance

## 2. Banking Services

### 2.1 Account Balance Inquiry

#### Business Rules:
- **Real-time Balance**: Display current available balance
- **Multiple Accounts**: Support checking multiple account balances
- **Currency Format**: Display amounts in Sri Lankan Rupees (LKR)
- **Decimal Places**: Show amounts with 2 decimal places
- **Refresh Rate**: Auto-refresh balance every 30 seconds
- **Offline Mode**: Show last known balance when offline

#### Validation Rules:
```dart
// Account balance validation
bool validateAccountAccess(String accountNumber, String userId) {
  return accountNumber.isNotEmpty && 
         accountNumber.length == 12 && 
         isAccountOwnedByUser(accountNumber, userId);
}

// Balance display formatting
String formatCurrency(double amount) {
  return 'LKR ${amount.toStringAsFixed(2)}';
}
```

#### Error Handling:
- **Account Not Found**: "Account not found. Please contact customer service."
- **Network Error**: "Unable to fetch balance. Please check your connection."
- **Service Unavailable**: "Service temporarily unavailable. Please try again later."

### 2.2 Loan Inquiry

#### Business Rules:
- **Loan Types**: Personal loans, home loans, vehicle loans
- **Eligibility Check**: Verify customer eligibility before showing options
- **Interest Rates**: Display current interest rates for each loan type
- **Loan Calculator**: Provide EMI calculator functionality
- **Application Status**: Show status of existing loan applications
- **Document Requirements**: List required documents for each loan type

#### Validation Rules:
```dart
// Loan eligibility validation
bool checkLoanEligibility(UserProfile user) {
  return user.age >= 18 && 
         user.age <= 65 && 
         user.monthlyIncome >= 25000 && 
         user.creditScore >= 650;
}

// Loan amount validation
bool validateLoanAmount(double amount, LoanType type) {
  switch (type) {
    case LoanType.personal:
      return amount >= 50000 && amount <= 2000000;
    case LoanType.home:
      return amount >= 500000 && amount <= 50000000;
    case LoanType.vehicle:
      return amount >= 100000 && amount <= 10000000;
  }
}
```

#### Interest Rate Rules:
- **Personal Loan**: 12% - 18% per annum
- **Home Loan**: 8% - 12% per annum
- **Vehicle Loan**: 10% - 15% per annum
- **Rate Factors**: Based on credit score, income, and loan amount

## 3. Bill Payment Services

### 3.1 Mobile Bill Payment

#### Supported Providers:
- **Dialog**: Prepaid and postpaid
- **Mobitel**: Prepaid and postpaid
- **Hutch**: Prepaid and postpaid
- **Airtel**: Prepaid and postpaid

#### Business Rules:
- **Minimum Amount**: LKR 100
- **Maximum Amount**: LKR 10,000 per transaction
- **Daily Limit**: LKR 50,000 per day
- **Monthly Limit**: LKR 200,000 per month
- **Service Hours**: 24/7 service availability
- **Confirmation**: SMS confirmation for successful payments

#### Validation Rules:
```dart
// Mobile number validation
bool validateMobileNumber(String number) {
  final regex = RegExp(r'^(?:\+94|0)?[1-9]\d{8}$');
  return regex.hasMatch(number) && number.length >= 9;
}

// Payment amount validation
bool validatePaymentAmount(double amount, PaymentType type) {
  if (type == PaymentType.mobile) {
    return amount >= 100 && amount <= 10000;
  }
  return false;
}

// Daily limit check
bool checkDailyLimit(String userId, double amount) {
  double todayTotal = getTodayTransactionTotal(userId);
  return (todayTotal + amount) <= 50000;
}
```

### 3.2 Utility Bill Payment

#### Supported Utilities:
- **Ceylon Electricity Board (CEB)**
- **Lanka Electricity Company (LECO)**
- **National Water Supply & Drainage Board**
- **Colombo Municipal Council**

#### Business Rules:
- **Bill Reference**: Validate bill reference number format
- **Due Date Check**: Warn if payment is after due date
- **Late Fees**: Calculate and display late fees if applicable
- **Partial Payments**: Allow partial payments for overdue bills
- **Payment History**: Maintain 12-month payment history

#### Validation Rules:
```dart
// Utility bill reference validation
bool validateBillReference(String reference, UtilityProvider provider) {
  switch (provider) {
    case UtilityProvider.ceb:
      return reference.length == 10 && reference.startsWith('CEB');
    case UtilityProvider.leco:
      return reference.length == 12 && isNumeric(reference);
    case UtilityProvider.waterBoard:
      return reference.length == 8 && reference.startsWith('WB');
  }
}

// Late fee calculation
double calculateLateFee(double billAmount, int daysLate) {
  if (daysLate <= 0) return 0;
  double lateFeeRate = 0.02; // 2% per month
  return billAmount * lateFeeRate * (daysLate / 30);
}
```

### 3.3 Government Payment

#### Supported Services:
- **Vehicle Revenue License**
- **Municipal Taxes**
- **Court Fines**
- **Passport Fees**
- **Visa Fees**

#### Business Rules:
- **Payment Verification**: Verify payment eligibility before processing
- **Receipt Generation**: Generate official receipts for all payments
- **Reference Numbers**: Validate government reference numbers
- **Service Fees**: Apply applicable service charges

#### Validation Rules:
```dart
// Government payment validation
bool validateGovernmentPayment(String reference, GovernmentService service) {
  switch (service) {
    case GovernmentService.vehicleLicense:
      return validateVehicleNumber(reference);
    case GovernmentService.passport:
      return validatePassportNumber(reference);
    case GovernmentService.courtFine:
      return validateCaseNumber(reference);
  }
}

// Vehicle number validation
bool validateVehicleNumber(String vehicleNumber) {
  final regex = RegExp(r'^[A-Z]{2,3}-\d{4}$');
  return regex.hasMatch(vehicleNumber);
}
```

## 4. User Onboarding & KYC

### 4.1 KYC Requirements

#### Document Types:
- **Primary ID**: National Identity Card (NIC) or Passport
- **Address Proof**: Utility bill or bank statement (within 3 months)
- **Income Proof**: Salary certificate or bank statements
- **Selfie**: Live selfie for face verification

#### Business Rules:
- **Document Quality**: Minimum 1080p resolution for photos
- **File Size**: Maximum 5MB per document
- **File Formats**: JPEG, PNG, PDF accepted
- **Expiry Check**: Validate document expiry dates
- **Face Matching**: Compare selfie with ID photo
- **Processing Time**: 24-48 hours for verification

#### Validation Rules:
```dart
// NIC validation
bool validateNIC(String nic) {
  if (nic.length == 10) {
    // Old NIC format
    return RegExp(r'^\d{9}[VvXx]$').hasMatch(nic);
  } else if (nic.length == 12) {
    // New NIC format
    return RegExp(r'^\d{12}$').hasMatch(nic);
  }
  return false;
}

// Document quality check
bool validateDocumentQuality(File imageFile) {
  return imageFile.lengthSync() >= 100000 && // Minimum 100KB
         imageFile.lengthSync() <= 5242880;   // Maximum 5MB
}

// Age validation from NIC
int calculateAgeFromNIC(String nic) {
  if (nic.length == 10) {
    int year = int.parse(nic.substring(0, 2));
    year += (year > 50) ? 1900 : 2000;
    int dayOfYear = int.parse(nic.substring(2, 5));
    // Calculate age logic
  }
  // New NIC format calculation
  return 0;
}
```

### 4.2 Account Creation

#### Business Rules:
- **Minimum Age**: 18 years old
- **Maximum Age**: 65 years for new accounts
- **Initial Deposit**: Minimum LKR 1,000 for savings account
- **Account Types**: Savings, Current, Fixed Deposit
- **Branch Selection**: Customer can select preferred branch
- **Welcome Bonus**: LKR 500 welcome bonus for new accounts

#### Validation Rules:
```dart
// Account creation validation
bool validateAccountCreation(CustomerData customer) {
  return customer.age >= 18 && 
         customer.age <= 65 && 
         customer.initialDeposit >= 1000 && 
         customer.kycStatus == KYCStatus.approved;
}

// Email validation
bool validateEmail(String email) {
  return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
}

// Phone validation
bool validatePhoneNumber(String phone) {
  return RegExp(r'^(?:\+94|0)?[1-9]\d{8}$').hasMatch(phone);
}
```

## 5. Help & Assistance

### 5.1 Product Catalog

#### Product Categories:
- **Savings Accounts**: Regular, Premium, Senior Citizen
- **Current Accounts**: Business, Corporate, SME
- **Fixed Deposits**: Short-term, Long-term, Flexi
- **Loans**: Personal, Home, Vehicle, Education
- **Cards**: Debit Cards, Credit Cards, Prepaid Cards
- **Insurance**: Life, Health, Vehicle, Property

#### Business Rules:
- **Product Eligibility**: Check customer eligibility for each product
- **Interest Rates**: Display current rates for deposits and loans
- **Features Comparison**: Side-by-side product comparison
- **Application Process**: Step-by-step application guidance

### 5.2 Navigation Assistance

#### Location Services:
- **Branch Locator**: Find nearest bank branches
- **ATM Locator**: Find nearest ATMs
- **CDM Locator**: Find Cash Deposit Machines
- **Service Centers**: Find customer service centers

#### Business Rules:
- **GPS Integration**: Use device GPS for location-based services
- **Distance Calculation**: Show distance and estimated travel time
- **Operating Hours**: Display branch/ATM operating hours
- **Service Availability**: Show available services at each location
- **Accessibility**: Highlight wheelchair-accessible locations

#### Validation Rules:
```dart
// Location validation
bool validateLocation(double latitude, double longitude) {
  // Sri Lanka boundaries
  return latitude >= 5.9 && latitude <= 9.9 && 
         longitude >= 79.5 && longitude <= 81.9;
}

// Operating hours check
bool isBranchOpen(Branch branch, DateTime currentTime) {
  TimeOfDay openTime = branch.openTime;
  TimeOfDay closeTime = branch.closeTime;
  TimeOfDay current = TimeOfDay.fromDateTime(currentTime);
  
  return isTimeInRange(current, openTime, closeTime) && 
         !branch.holidays.contains(currentTime.weekday);
}
```

## 6. Feedback System

### 6.1 Feedback Categories

#### Categories:
- **Service Quality**: Rating 1-5 stars
- **App Performance**: Technical issues and suggestions
- **Feature Requests**: New feature suggestions
- **Complaints**: Service complaints and issues
- **Compliments**: Positive feedback and appreciation

#### Business Rules:
- **Mandatory Fields**: Category, rating, and comment required
- **Character Limits**: Comments limited to 500 characters
- **Anonymous Option**: Allow anonymous feedback
- **Follow-up**: Customer service follow-up for complaints
- **Response Time**: 24-48 hours response for complaints

#### Validation Rules:
```dart
// Feedback validation
bool validateFeedback(Feedback feedback) {
  return feedback.category != null && 
         feedback.rating >= 1 && 
         feedback.rating <= 5 && 
         feedback.comment.isNotEmpty && 
         feedback.comment.length <= 500;
}

// Profanity filter
bool containsProfanity(String text) {
  List<String> profanityWords = ['word1', 'word2']; // Load from config
  return profanityWords.any((word) => 
    text.toLowerCase().contains(word.toLowerCase()));
}
```

## 7. Transaction Limits & Controls

### 7.1 Daily Transaction Limits

#### Per User Limits:
- **Bill Payments**: LKR 50,000 per day
- **Fund Transfers**: LKR 100,000 per day
- **Cash Withdrawals**: LKR 25,000 per day (ATM)
- **Online Purchases**: LKR 75,000 per day
- **Total Daily Limit**: LKR 200,000 per day

#### Per Transaction Limits:
- **Mobile Top-up**: LKR 10,000 per transaction
- **Utility Bills**: LKR 50,000 per transaction
- **Government Payments**: LKR 25,000 per transaction

### 7.2 Velocity Checks

#### Business Rules:
- **Frequency Limits**: Maximum 10 transactions per hour
- **Duplicate Prevention**: Prevent duplicate transactions within 5 minutes
- **Unusual Activity**: Flag transactions outside normal patterns
- **Risk Scoring**: Calculate risk score for each transaction

#### Implementation:
```dart
// Transaction velocity check
bool checkTransactionVelocity(String userId, TransactionType type) {
  List<Transaction> recentTransactions = 
    getRecentTransactions(userId, Duration(hours: 1));
  
  return recentTransactions.where((t) => t.type == type).length < 10;
}

// Duplicate transaction check
bool isDuplicateTransaction(Transaction newTransaction) {
  List<Transaction> recent = 
    getRecentTransactions(newTransaction.userId, Duration(minutes: 5));
  
  return recent.any((t) => 
    t.amount == newTransaction.amount && 
    t.recipient == newTransaction.recipient &&
    t.type == newTransaction.type);
}
```

## 8. Error Handling & Recovery

### 8.1 Network Error Handling

#### Business Rules:
- **Retry Logic**: Automatic retry for failed network requests (max 3 attempts)
- **Timeout Handling**: 30-second timeout for API calls
- **Offline Mode**: Cache critical data for offline access
- **Queue Management**: Queue transactions when offline

### 8.2 Transaction Recovery

#### Business Rules:
- **Failed Transactions**: Automatic reversal within 24 hours
- **Partial Failures**: Handle partial transaction completions
- **Reconciliation**: Daily reconciliation of all transactions
- **Customer Notification**: Notify customers of failed/reversed transactions

### 8.3 Data Integrity

#### Business Rules:
- **Checksum Validation**: Validate data integrity using checksums
- **Backup Strategy**: Regular data backups every 6 hours
- **Corruption Detection**: Detect and handle data corruption
- **Recovery Procedures**: Automated recovery from backups

## 9. Compliance & Regulatory Requirements

### 9.1 Banking Regulations

#### Central Bank of Sri Lanka (CBSL) Requirements:
- **Customer Due Diligence**: Mandatory KYC for all customers
- **Anti-Money Laundering**: Monitor and report suspicious transactions
- **Data Protection**: Comply with data protection regulations
- **Transaction Reporting**: Report large transactions to authorities

### 9.2 PCI DSS Compliance

#### Requirements:
- **Data Encryption**: Encrypt all cardholder data
- **Access Control**: Implement strict access controls
- **Network Security**: Secure network architecture
- **Regular Testing**: Regular security testing and monitoring

### 9.3 GDPR Compliance (if applicable)

#### Requirements:
- **Data Consent**: Explicit consent for data processing
- **Data Portability**: Allow customers to export their data
- **Right to Erasure**: Allow customers to request data deletion
- **Privacy by Design**: Implement privacy by design principles

## 10. Performance & Scalability Rules

### 10.1 Performance Requirements

#### Response Time Targets:
- **Authentication**: < 2 seconds
- **Balance Inquiry**: < 3 seconds
- **Bill Payment**: < 5 seconds
- **Transaction History**: < 4 seconds
- **App Launch**: < 3 seconds

### 10.2 Scalability Requirements

#### Business Rules:
- **Concurrent Users**: Support 10,000 concurrent users
- **Peak Load**: Handle 5x normal load during peak hours
- **Database Performance**: Optimize queries for sub-second response
- **Caching Strategy**: Implement multi-level caching

### 10.3 Availability Requirements

#### Business Rules:
- **Uptime Target**: 99.9% availability (8.76 hours downtime per year)
- **Maintenance Windows**: Scheduled maintenance during off-peak hours
- **Disaster Recovery**: Recovery Time Objective (RTO) of 4 hours
- **Backup Strategy**: Recovery Point Objective (RPO) of 1 hour

## 11. Monitoring & Analytics

### 11.1 Business Metrics

#### Key Performance Indicators (KPIs):
- **Transaction Success Rate**: > 99.5%
- **Customer Satisfaction**: > 4.5/5 stars
- **App Adoption Rate**: Track new user registrations
- **Feature Usage**: Monitor feature utilization rates
- **Support Ticket Volume**: Track customer support requests

### 11.2 Technical Metrics

#### Performance Monitoring:
- **API Response Times**: Monitor all API endpoints
- **Error Rates**: Track error rates by feature
- **Crash Reports**: Monitor app crashes and stability
- **Resource Usage**: Monitor CPU, memory, and network usage

### 11.3 Security Monitoring

#### Security Metrics:
- **Failed Login Attempts**: Monitor authentication failures
- **Suspicious Activities**: Track unusual transaction patterns
- **Security Incidents**: Monitor and respond to security events
- **Vulnerability Assessments**: Regular security assessments

This comprehensive business rules document ensures that all banking functions are properly defined, validated, and implemented according to industry standards and regulatory requirements. 