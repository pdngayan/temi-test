# Flutter Self-Care Agent Banking Application

A comprehensive Flutter banking application designed specifically for Temi devices, providing self-service banking functionality with a focus on accessibility and user-friendly design for elderly users.

## 🏦 Project Overview

The Self-Care Agent is a banking application that offers:
- **Account Management**: Balance inquiries, transaction history, and account details
- **Bill Payment Services**: Mobile bills, utility bills, and government payments
- **User Onboarding**: KYC verification and account creation
- **Help & Assistance**: Product catalog and navigation assistance
- **Feedback System**: User feedback collection and support

## 🎯 Target Platform

- **Primary**: Temi Robot devices (Android-based tablets)
- **Orientation**: Landscape mode optimized
- **Accessibility**: Designed for elderly users with large touch targets and high contrast
- **Languages**: English, Sinhala, and Tamil support

## 🏗️ Architecture

The project follows **Clean Architecture** principles with:
- **BLoC Pattern** for state management
- **Feature-based** modular structure
- **Repository Pattern** for data abstraction
- **Dependency Injection** using GetIt
- **Firebase Backend** integration

## 📁 Project Structure

```
lib/
├── core/                    # Core utilities and shared components
│   ├── constants/          # App constants and configurations
│   ├── theme/             # App theming and colors
│   └── utils/             # Utility functions
├── features/              # Feature modules
│   ├── authentication/   # User login and authentication
│   ├── banking/          # Banking services
│   ├── bill_payment/     # Bill payment functionality
│   ├── onboarding/       # User onboarding and KYC
│   ├── help/             # Help and assistance
│   └── feedback/         # Feedback collection
├── shared/               # Shared components
│   ├── widgets/         # Reusable UI components
│   └── services/        # Shared services
└── l10n/                # Localization files
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/pdngayan/temi-test.git
   cd temi-test
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Generate localization files:**
   ```bash
   flutter gen-l10n
   ```

4. **Run the application:**
   ```bash
   flutter run
   ```

### Development Setup

1. **Install Flutter:**
   - Follow the [official Flutter installation guide](https://docs.flutter.dev/get-started/install)

2. **IDE Setup:**
   - Install Flutter and Dart plugins for your IDE
   - Configure code formatting and linting

3. **Firebase Setup (Optional):**
   - Create a Firebase project
   - Add configuration files for Android/iOS
   - Enable Authentication, Firestore, and Storage

## 🎨 Design System

### Colors
- **Primary**: Banking blue theme with high contrast
- **Secondary**: Complementary colors for different banking services
- **Accessibility**: WCAG AA compliant color combinations

### Typography
- **Large fonts**: Optimized for elderly users
- **Clear hierarchy**: Distinct font sizes for different content types
- **Readable**: High contrast text on all backgrounds

### Components
- **Touch Targets**: Minimum 44dp for easy interaction
- **Buttons**: Large, clearly labeled with appropriate spacing
- **Forms**: Simple, step-by-step with clear validation

## 🌐 Localization

The app supports three languages:
- **English (en)**: Primary language
- **Sinhala (si)**: Local language support
- **Tamil (ta)**: Regional language support

All user-facing text is externalized to `.arb` files for easy translation management.

## 🧪 Testing

### Running Tests

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run integration tests
flutter drive --target=test_driver/app.dart
```

### Test Structure
- **Unit Tests**: Business logic and utility functions
- **Widget Tests**: UI components and user interactions
- **Integration Tests**: Complete user flows

## 📱 Platform Support

| Platform | Status | Notes |
|----------|--------|-------|
| Android | ✅ Primary | Optimized for Temi devices |
| iOS | ✅ Supported | Standard iOS support |
| Web | ✅ Supported | For development and testing |
| Desktop | ⚠️ Limited | Basic support |

## 🔒 Security Features

- **Authentication**: Secure login with biometric support
- **Session Management**: Automatic timeout and secure token handling
- **Data Encryption**: All sensitive data encrypted
- **Banking Compliance**: PCI DSS and regulatory compliance

## 🚀 Deployment

### Development
```bash
flutter run --debug
```

### Staging
```bash
flutter build apk --release --flavor staging
```

### Production
```bash
flutter build apk --release --flavor production
```

## 📚 Documentation

- [Business Rules](BUSINESS_RULES.md) - Comprehensive business logic documentation
- [Business Configuration](BUSINESS_CONFIG.md) - Configurable business parameters
- [Project Structure](PROJECT_STRUCTURE.md) - Detailed architecture documentation

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Code Standards
- Follow Flutter/Dart style guidelines
- Write comprehensive tests
- Update documentation
- Ensure accessibility compliance

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

For support and questions:
- Create an issue in the GitHub repository
- Contact the development team
- Check the documentation files

## 🎯 Roadmap

- [ ] Complete authentication implementation
- [ ] Add banking service integrations
- [ ] Implement real-time notifications
- [ ] Add voice interaction features
- [ ] Enhance accessibility features
- [ ] Add analytics and monitoring

---

**Built with ❤️ for accessible banking services**
