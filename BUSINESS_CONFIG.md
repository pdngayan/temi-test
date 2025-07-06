# Flutter Self-Care Agent - Business Configuration

## Overview
This document defines configurable business parameters, constants, and settings that can be adjusted without code changes for the Flutter Self-Care Agent banking application.

## 1. Authentication Configuration

### 1.1 Security Settings
```yaml
authentication:
  max_login_attempts: 3
  lockout_duration_minutes: 15
  session_timeout_minutes: 10
  token_expiry_hours: 24
  password_min_length: 8
  pin_length_range: [4, 6]
  biometric_enabled: true
  screenshot_prevention: true
  auto_screen_lock_minutes: 2
```

### 1.2 Password Policy
```yaml
password_policy:
  require_uppercase: true
  require_lowercase: true
  require_numbers: true
  require_special_chars: true
  min_length: 8
  max_length: 20
  special_chars: "!@#$%^&*()_+-=[]{}|;:,.<>?"
  password_history_count: 5
  password_expiry_days: 90
```

## 2. Transaction Limits Configuration

### 2.1 Daily Limits (LKR)
```yaml
daily_limits:
  bill_payments: 50000
  fund_transfers: 100000
  cash_withdrawals: 25000
  online_purchases: 75000
  total_daily_limit: 200000
  mobile_topup: 10000
  utility_bills: 50000
  government_payments: 25000
```

### 2.2 Transaction Limits by Type
```yaml
transaction_limits:
  mobile_bill:
    min_amount: 100
    max_amount: 10000
    daily_limit: 50000
    monthly_limit: 200000
  
  utility_bill:
    min_amount: 500
    max_amount: 50000
    daily_limit: 100000
    monthly_limit: 500000
  
  government_payment:
    min_amount: 100
    max_amount: 25000
    daily_limit: 50000
    monthly_limit: 200000
```

### 2.3 Velocity Controls
```yaml
velocity_controls:
  max_transactions_per_hour: 10
  max_transactions_per_day: 50
  duplicate_prevention_minutes: 5
  unusual_activity_threshold: 5
  risk_score_threshold: 75
```

## 3. Banking Service Configuration

### 3.1 Account Services
```yaml
account_services:
  balance_refresh_seconds: 30
  transaction_history_months: 12
  statement_generation_days: 30
  account_number_length: 12
  currency_code: "LKR"
  decimal_places: 2
  minimum_balance: 1000
```

### 3.2 Loan Configuration
```yaml
loan_config:
  personal_loan:
    min_amount: 50000
    max_amount: 2000000
    min_interest_rate: 12.0
    max_interest_rate: 18.0
    max_tenure_years: 5
    min_income_requirement: 25000
  
  home_loan:
    min_amount: 500000
    max_amount: 50000000
    min_interest_rate: 8.0
    max_interest_rate: 12.0
    max_tenure_years: 30
    min_income_requirement: 50000
  
  vehicle_loan:
    min_amount: 100000
    max_amount: 10000000
    min_interest_rate: 10.0
    max_interest_rate: 15.0
    max_tenure_years: 7
    min_income_requirement: 30000
```

### 3.3 Eligibility Criteria
```yaml
eligibility:
  min_age: 18
  max_age: 65
  min_credit_score: 650
  required_documents: ["nic", "income_proof", "address_proof"]
  kyc_processing_hours: 48
  account_creation_bonus: 500
```

## 4. Bill Payment Providers

### 4.1 Mobile Operators
```yaml
mobile_operators:
  dialog:
    name: "Dialog Axiata"
    prefix_codes: ["070", "071", "072"]
    prepaid_enabled: true
    postpaid_enabled: true
    service_charge: 0
  
  mobitel:
    name: "Sri Lanka Telecom Mobitel"
    prefix_codes: ["071", "076", "077"]
    prepaid_enabled: true
    postpaid_enabled: true
    service_charge: 0
  
  hutch:
    name: "Hutchison Telecommunications"
    prefix_codes: ["078"]
    prepaid_enabled: true
    postpaid_enabled: true
    service_charge: 0
  
  airtel:
    name: "Bharti Airtel Lanka"
    prefix_codes: ["070", "075"]
    prepaid_enabled: true
    postpaid_enabled: true
    service_charge: 0
```

### 4.2 Utility Providers
```yaml
utility_providers:
  ceb:
    name: "Ceylon Electricity Board"
    reference_format: "CEB[0-9]{7}"
    reference_length: 10
    service_charge_percentage: 0.5
    late_fee_percentage: 2.0
  
  leco:
    name: "Lanka Electricity Company"
    reference_format: "[0-9]{12}"
    reference_length: 12
    service_charge_percentage: 0.5
    late_fee_percentage: 2.0
  
  water_board:
    name: "National Water Supply & Drainage Board"
    reference_format: "WB[0-9]{6}"
    reference_length: 8
    service_charge_percentage: 0.5
    late_fee_percentage: 1.5
```

### 4.3 Government Services
```yaml
government_services:
  vehicle_license:
    name: "Vehicle Revenue License"
    reference_format: "[A-Z]{2,3}-[0-9]{4}"
    service_charge: 50
    processing_days: 1
  
  passport_fees:
    name: "Department of Immigration & Emigration"
    reference_format: "N[0-9]{7}"
    service_charge: 100
    processing_days: 3
  
  court_fines:
    name: "Court Fines Payment"
    reference_format: "CF[0-9]{8}"
    service_charge: 25
    processing_days: 1
```

## 5. KYC & Onboarding Configuration

### 5.1 Document Requirements
```yaml
kyc_documents:
  primary_id:
    types: ["nic", "passport", "driving_license"]
    required: true
    max_file_size_mb: 5
    allowed_formats: ["jpg", "jpeg", "png", "pdf"]
  
  address_proof:
    types: ["utility_bill", "bank_statement", "lease_agreement"]
    required: true
    max_age_months: 3
    max_file_size_mb: 5
    allowed_formats: ["jpg", "jpeg", "png", "pdf"]
  
  income_proof:
    types: ["salary_certificate", "bank_statement", "tax_return"]
    required: true
    max_age_months: 6
    max_file_size_mb: 5
    allowed_formats: ["jpg", "jpeg", "png", "pdf"]
  
  selfie:
    required: true
    min_resolution: "720p"
    max_file_size_mb: 2
    allowed_formats: ["jpg", "jpeg"]
```

### 5.2 Verification Settings
```yaml
verification:
  face_match_threshold: 0.85
  document_quality_threshold: 0.80
  processing_time_hours: 48
  manual_review_threshold: 0.70
  retry_attempts: 3
  expiry_check_enabled: true
```

## 6. Performance Configuration

### 6.1 Response Time Targets (seconds)
```yaml
performance_targets:
  authentication: 2
  balance_inquiry: 3
  bill_payment: 5
  transaction_history: 4
  app_launch: 3
  api_timeout: 30
  retry_attempts: 3
  retry_delay_seconds: 2
```

### 6.2 Caching Configuration
```yaml
caching:
  balance_cache_minutes: 5
  transaction_cache_hours: 24
  user_profile_cache_hours: 12
  exchange_rate_cache_hours: 6
  branch_location_cache_days: 7
  product_catalog_cache_days: 1
```

## 7. Notification Configuration

### 7.1 Message Settings
```yaml
notifications:
  sms_enabled: true
  email_enabled: true
  push_enabled: true
  in_app_enabled: true
  
  transaction_notifications:
    - payment_success
    - payment_failure
    - low_balance
    - large_transaction
  
  security_notifications:
    - login_success
    - login_failure
    - password_change
    - account_lockout
```

### 7.2 Message Timing
```yaml
message_timing:
  success_duration_seconds: 3
  error_duration_seconds: 5
  warning_duration_seconds: 5
  info_duration_seconds: 4
  banner_auto_dismiss_hours: 24
```

## 8. Accessibility Configuration

### 8.1 Temi Device Settings
```yaml
temi_settings:
  screen_orientation: "landscape"
  min_touch_target_dp: 44
  font_scale_factor: 1.2
  high_contrast_enabled: true
  voice_feedback_enabled: true
  gesture_timeout_seconds: 10
```

### 8.2 Language Support
```yaml
localization:
  default_language: "en"
  supported_languages: ["en", "si", "ta"]
  rtl_support: false
  date_format: "dd/MM/yyyy"
  time_format: "HH:mm"
  currency_symbol: "LKR"
```

## 9. Security Configuration

### 9.1 Encryption Settings
```yaml
security:
  encryption_algorithm: "AES-256"
  key_rotation_days: 90
  ssl_pinning_enabled: true
  certificate_validation: true
  api_rate_limiting: true
  requests_per_minute: 60
```

### 9.2 Fraud Detection
```yaml
fraud_detection:
  enabled: true
  velocity_check: true
  location_check: true
  device_fingerprinting: true
  unusual_pattern_detection: true
  risk_scoring_enabled: true
  manual_review_threshold: 80
```

## 10. Business Hours Configuration

### 10.1 Service Availability
```yaml
service_hours:
  banking_services:
    start_time: "06:00"
    end_time: "22:00"
    timezone: "Asia/Colombo"
    weekends_enabled: true
  
  bill_payments:
    available_24x7: true
    maintenance_window: "02:00-04:00"
  
  customer_support:
    start_time: "08:00"
    end_time: "18:00"
    weekends_enabled: false
```

### 10.2 Holiday Configuration
```yaml
holidays:
  bank_holidays:
    - "2024-01-01"  # New Year's Day
    - "2024-02-04"  # Independence Day
    - "2024-05-01"  # Labour Day
    - "2024-12-25"  # Christmas Day
  
  maintenance_windows:
    - day: "sunday"
      start_time: "02:00"
      end_time: "04:00"
      frequency: "weekly"
```

## 11. Feature Flags

### 11.1 Feature Toggles
```yaml
features:
  biometric_login: true
  face_recognition: true
  voice_commands: true
  offline_mode: true
  dark_theme: true
  loan_calculator: true
  investment_products: false
  cryptocurrency: false
  international_transfers: false
```

### 11.2 Beta Features
```yaml
beta_features:
  ai_chatbot: false
  predictive_analytics: false
  advanced_budgeting: false
  investment_advisor: false
  credit_score_monitoring: false
```

## 12. Integration Configuration

### 12.1 External APIs
```yaml
external_apis:
  payment_gateway:
    timeout_seconds: 30
    retry_attempts: 3
    fallback_enabled: true
  
  credit_bureau:
    timeout_seconds: 15
    retry_attempts: 2
    cache_duration_hours: 24
  
  sms_gateway:
    timeout_seconds: 10
    retry_attempts: 3
    rate_limit_per_minute: 100
```

### 12.2 Database Configuration
```yaml
database:
  connection_pool_size: 20
  query_timeout_seconds: 30
  backup_frequency_hours: 6
  retention_period_days: 2555  # 7 years
  encryption_at_rest: true
```

## 13. Monitoring & Analytics

### 13.1 Metrics Collection
```yaml
monitoring:
  performance_metrics: true
  business_metrics: true
  security_metrics: true
  user_behavior_analytics: true
  crash_reporting: true
  error_tracking: true
```

### 13.2 Alert Thresholds
```yaml
alerts:
  error_rate_threshold: 5.0
  response_time_threshold: 5000
  transaction_failure_threshold: 2.0
  security_incident_threshold: 1
  system_downtime_threshold: 60
```

## 14. Compliance Configuration

### 14.1 Regulatory Settings
```yaml
compliance:
  pci_dss_enabled: true
  gdpr_enabled: false
  cbsl_reporting: true
  aml_monitoring: true
  transaction_reporting_threshold: 1000000
  suspicious_activity_reporting: true
```

### 14.2 Data Retention
```yaml
data_retention:
  transaction_records_years: 7
  user_activity_logs_years: 3
  audit_trails_years: 10
  kyc_documents_years: 7
  customer_communications_years: 5
```

This configuration file provides a centralized location for all business parameters that can be adjusted without code changes, enabling flexible business rule management. 