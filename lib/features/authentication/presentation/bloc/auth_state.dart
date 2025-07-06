import '../../domain/entities/user_entity.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final UserEntity user;

  AuthAuthenticated({required this.user});
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;
  final String? errorCode;

  AuthError({
    required this.message,
    this.errorCode,
  });
}

class AuthLoginFailure extends AuthState {
  final String message;
  final int attemptCount;
  final bool isAccountLocked;
  final Duration? lockoutDuration;

  AuthLoginFailure({
    required this.message,
    required this.attemptCount,
    required this.isAccountLocked,
    this.lockoutDuration,
  });
}

class AuthSignUpSuccess extends AuthState {
  final UserEntity user;
  final bool requiresEmailVerification;
  final bool requiresPhoneVerification;

  AuthSignUpSuccess({
    required this.user,
    required this.requiresEmailVerification,
    required this.requiresPhoneVerification,
  });
}

class AuthPasswordResetEmailSent extends AuthState {
  final String email;

  AuthPasswordResetEmailSent({required this.email});
}

class AuthEmailVerificationSent extends AuthState {}

class AuthPhoneVerificationSent extends AuthState {
  final String phoneNumber;

  AuthPhoneVerificationSent({required this.phoneNumber});
}

class AuthPhoneVerified extends AuthState {}

class AuthBiometricSetupRequired extends AuthState {}

class AuthBiometricEnabled extends AuthState {}

class AuthBiometricDisabled extends AuthState {}

class AuthBiometricError extends AuthState {
  final String message;

  AuthBiometricError({required this.message});
}

class AuthPinSetupRequired extends AuthState {}

class AuthPinSetupSuccess extends AuthState {}

class AuthPinChangeSuccess extends AuthState {}

class AuthPasswordChangeSuccess extends AuthState {}

class AuthSessionExpired extends AuthState {}

class AuthKycRequired extends AuthState {
  final UserEntity user;

  AuthKycRequired({required this.user});
}

class AuthAccountLocked extends AuthState {
  final Duration lockoutDuration;
  final DateTime lockedUntil;

  AuthAccountLocked({
    required this.lockoutDuration,
    required this.lockedUntil,
  });
}

class AuthNetworkError extends AuthState {
  final String message;

  AuthNetworkError({required this.message});
}

class AuthValidationError extends AuthState {
  final Map<String, String> fieldErrors;

  AuthValidationError({required this.fieldErrors});
}

class AuthUserProfileUpdated extends AuthState {
  final UserEntity user;

  AuthUserProfileUpdated({required this.user});
} 