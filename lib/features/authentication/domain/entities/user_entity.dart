import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String? phoneNumber;
  final String firstName;
  final String lastName;
  final String? profileImageUrl;
  final bool isEmailVerified;
  final bool isPhoneVerified;
  final bool isBiometricEnabled;
  final bool isPinEnabled;
  final DateTime createdAt;
  final DateTime? lastLoginAt;
  final UserKycStatus kycStatus;
  final List<String> accountNumbers;

  const UserEntity({
    required this.id,
    required this.email,
    this.phoneNumber,
    required this.firstName,
    required this.lastName,
    this.profileImageUrl,
    required this.isEmailVerified,
    required this.isPhoneVerified,
    required this.isBiometricEnabled,
    required this.isPinEnabled,
    required this.createdAt,
    this.lastLoginAt,
    required this.kycStatus,
    required this.accountNumbers,
  });

  String get fullName => '$firstName $lastName';

  bool get isVerified => isEmailVerified && isPhoneVerified;

  bool get hasCompletedKyc => kycStatus == UserKycStatus.approved;

  bool get canAccessBankingServices => isVerified && hasCompletedKyc;

  UserEntity copyWith({
    String? id,
    String? email,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    String? profileImageUrl,
    bool? isEmailVerified,
    bool? isPhoneVerified,
    bool? isBiometricEnabled,
    bool? isPinEnabled,
    DateTime? createdAt,
    DateTime? lastLoginAt,
    UserKycStatus? kycStatus,
    List<String>? accountNumbers,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      isBiometricEnabled: isBiometricEnabled ?? this.isBiometricEnabled,
      isPinEnabled: isPinEnabled ?? this.isPinEnabled,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      kycStatus: kycStatus ?? this.kycStatus,
      accountNumbers: accountNumbers ?? this.accountNumbers,
    );
  }

  @override
  List<Object?> get props => [
        id,
        email,
        phoneNumber,
        firstName,
        lastName,
        profileImageUrl,
        isEmailVerified,
        isPhoneVerified,
        isBiometricEnabled,
        isPinEnabled,
        createdAt,
        lastLoginAt,
        kycStatus,
        accountNumbers,
      ];
}

enum UserKycStatus {
  notStarted,
  inProgress,
  pendingReview,
  approved,
  rejected,
  expired,
}

extension UserKycStatusExtension on UserKycStatus {
  String get displayName {
    switch (this) {
      case UserKycStatus.notStarted:
        return 'Not Started';
      case UserKycStatus.inProgress:
        return 'In Progress';
      case UserKycStatus.pendingReview:
        return 'Pending Review';
      case UserKycStatus.approved:
        return 'Approved';
      case UserKycStatus.rejected:
        return 'Rejected';
      case UserKycStatus.expired:
        return 'Expired';
    }
  }

  bool get isCompleted => this == UserKycStatus.approved;

  bool get requiresAction => [
        UserKycStatus.notStarted,
        UserKycStatus.rejected,
        UserKycStatus.expired,
      ].contains(this);
} 