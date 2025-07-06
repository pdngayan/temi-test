# Flutter Self-Care Agent Makefile

.PHONY: help install clean build test analyze format generate l10n run-dev run-prod

# Default target
help:
	@echo "Available commands:"
	@echo "  install     - Install dependencies"
	@echo "  clean       - Clean build artifacts"
	@echo "  build       - Build the application"
	@echo "  test        - Run all tests"
	@echo "  analyze     - Run static analysis"
	@echo "  format      - Format code"
	@echo "  generate    - Generate code"
	@echo "  l10n        - Generate localizations"
	@echo "  run-dev     - Run in development mode"
	@echo "  run-prod    - Run in production mode"
	@echo "  check       - Run all checks (format, analyze, test)"
	@echo "  setup       - Initial project setup"

# Install dependencies
install:
	flutter pub get
	cd ios && pod install --repo-update

# Clean build artifacts
clean:
	flutter clean
	flutter pub get
	cd ios && pod install --repo-update

# Build the application
build:
	flutter build apk --release
	flutter build ios --release

# Run tests
test:
	flutter test --coverage
	genhtml coverage/lcov.info -o coverage/html

# Run static analysis
analyze:
	flutter analyze
	dart analyze

# Format code
format:
	dart format --set-exit-if-changed lib/ test/

# Generate code
generate:
	flutter packages pub run build_runner build --delete-conflicting-outputs

# Generate localizations
l10n:
	flutter gen-l10n

# Run in development mode
run-dev:
	flutter run --debug --flavor dev

# Run in production mode
run-prod:
	flutter run --release --flavor prod

# Run all checks
check: format analyze test

# Initial project setup
setup: install generate l10n
	@echo "Project setup complete!"

# Watch for changes and regenerate
watch:
	flutter packages pub run build_runner watch --delete-conflicting-outputs

# Build runner clean
build-clean:
	flutter packages pub run build_runner clean

# Firebase setup
firebase-setup:
	flutterfire configure

# Update dependencies
update:
	flutter pub upgrade --major-versions

# Security audit
security:
	flutter pub deps
	flutter pub audit

# Performance profiling
profile:
	flutter run --profile

# Integration tests
integration-test:
	flutter drive --target=test_driver/app.dart

# Build for specific platforms
build-android:
	flutter build apk --release --split-per-abi

build-ios:
	flutter build ios --release --no-codesign

build-web:
	flutter build web --release

# Deploy commands
deploy-android:
	flutter build appbundle --release
	@echo "Upload the bundle to Google Play Console"

deploy-ios:
	flutter build ios --release
	@echo "Archive and upload to App Store Connect"

# Linting and formatting
lint:
	flutter analyze --fatal-infos --fatal-warnings

fix:
	dart fix --apply

# Documentation
docs:
	dart doc .

# Clean and rebuild everything
rebuild: clean install generate l10n build

# Git hooks setup
hooks:
	cp scripts/pre-commit .git/hooks/pre-commit
	chmod +x .git/hooks/pre-commit 