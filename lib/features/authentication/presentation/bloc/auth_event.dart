abstract class AuthEvent {}

class AuthInitialized extends AuthEvent {}

class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;

  AuthLoginRequested({
    required this.email,
    required this.password,
  });
}

class AuthBiometricLoginRequested extends AuthEvent {}

class AuthPinLoginRequested extends AuthEvent {
  final String pin;

  AuthPinLoginRequested({required this.pin});
}

class AuthSignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String? phoneNumber;

  AuthSignUpRequested({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
  });
}

class AuthLogoutRequested extends AuthEvent {}

class AuthPasswordResetRequested extends AuthEvent {
  final String email;

  AuthPasswordResetRequested({required this.email});
}

class AuthEmailVerificationRequested extends AuthEvent {}

class AuthPhoneVerificationRequested extends AuthEvent {
  final String phoneNumber;

  AuthPhoneVerificationRequested({required this.phoneNumber});
}

class AuthVerifyPhoneOtp extends AuthEvent {
  final String otp;

  AuthVerifyPhoneOtp({required this.otp});
}

class AuthBiometricToggled extends AuthEvent {
  final bool enabled;

  AuthBiometricToggled({required this.enabled});
}

class AuthPinSetupRequested extends AuthEvent {
  final String pin;

  AuthPinSetupRequested({required this.pin});
}

class AuthPinChangeRequested extends AuthEvent {
  final String currentPin;
  final String newPin;

  AuthPinChangeRequested({
    required this.currentPin,
    required this.newPin,
  });
}

class AuthPasswordChangeRequested extends AuthEvent {
  final String currentPassword;
  final String newPassword;

  AuthPasswordChangeRequested({
    required this.currentPassword,
    required this.newPassword,
  });
}

class AuthSessionExpired extends AuthEvent {}

class AuthUserUpdated extends AuthEvent {
  final String firstName;
  final String lastName;
  final String? phoneNumber;

  AuthUserUpdated({
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
  });
} 