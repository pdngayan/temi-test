import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

enum MessageType { success, error, warning, info }

class MessageService {
  static void showSnackbar(
    BuildContext context,
    String message, {
    MessageType type = MessageType.info,
    Duration duration = const Duration(seconds: 3),
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    // Adjust duration based on message type
    Duration adjustedDuration = duration;
    switch (type) {
      case MessageType.success:
        adjustedDuration = const Duration(seconds: 3);
        break;
      case MessageType.error:
        adjustedDuration = const Duration(seconds: 5);
        break;
      case MessageType.warning:
        adjustedDuration = const Duration(seconds: 5);
        break;
      case MessageType.info:
        adjustedDuration = const Duration(seconds: 4);
        break;
    }

    final snackBar = SnackBar(
      content: _buildMessageContent(message, type),
      backgroundColor: _getBackgroundColor(type),
      duration: adjustedDuration,
      action: actionLabel != null
          ? SnackBarAction(
              label: actionLabel,
              onPressed: onAction ?? () {},
              textColor: Colors.white,
            )
          : null,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.all(16),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Widget _buildMessageContent(String message, MessageType type) {
    return Row(
      children: [
        Icon(
          _getIcon(type),
          color: Colors.white,
          size: 24,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  static Color _getBackgroundColor(MessageType type) {
    switch (type) {
      case MessageType.success:
        return AppColors.success;
      case MessageType.error:
        return AppColors.error;
      case MessageType.warning:
        return AppColors.warning;
      case MessageType.info:
        return AppColors.info;
    }
  }

  static IconData _getIcon(MessageType type) {
    switch (type) {
      case MessageType.success:
        return Icons.check_circle;
      case MessageType.error:
        return Icons.error;
      case MessageType.warning:
        return Icons.warning;
      case MessageType.info:
        return Icons.info;
    }
  }

  // Banking specific message helpers
  static void showPaymentSuccess(
    BuildContext context,
    String amount, {
    String? reference,
    VoidCallback? onViewReceipt,
  }) {
    showSnackbar(
      context,
      'Payment of $amount completed successfully${reference != null ? ' (Ref: $reference)' : ''}',
      type: MessageType.success,
      actionLabel: onViewReceipt != null ? 'View Receipt' : null,
      onAction: onViewReceipt,
    );
  }

  static void showPaymentError(
    BuildContext context,
    String error, {
    VoidCallback? onRetry,
  }) {
    showSnackbar(
      context,
      'Payment failed: $error',
      type: MessageType.error,
      actionLabel: onRetry != null ? 'Retry' : null,
      onAction: onRetry,
    );
  }

  static void showKycRequired(
    BuildContext context, {
    VoidCallback? onStartKyc,
  }) {
    showSnackbar(
      context,
      'Please complete KYC verification to continue',
      type: MessageType.warning,
      actionLabel: onStartKyc != null ? 'Start KYC' : null,
      onAction: onStartKyc,
    );
  }

  static void showNetworkError(
    BuildContext context, {
    VoidCallback? onRetry,
  }) {
    showSnackbar(
      context,
      'Network connection failed. Please check your internet connection.',
      type: MessageType.error,
      actionLabel: onRetry != null ? 'Retry' : null,
      onAction: onRetry,
    );
  }

  static void showSessionExpired(
    BuildContext context, {
    VoidCallback? onLogin,
  }) {
    showSnackbar(
      context,
      'Your session has expired. Please login again.',
      type: MessageType.warning,
      actionLabel: onLogin != null ? 'Login' : null,
      onAction: onLogin,
    );
  }

  static void showLowBalance(
    BuildContext context, {
    VoidCallback? onAddFunds,
  }) {
    showSnackbar(
      context,
      'Your account balance is low',
      type: MessageType.warning,
      actionLabel: onAddFunds != null ? 'Add Funds' : null,
      onAction: onAddFunds,
    );
  }

  static void showTransactionLimit(
    BuildContext context,
    String limit,
  ) {
    showSnackbar(
      context,
      'Transaction amount exceeds your daily limit of $limit',
      type: MessageType.warning,
    );
  }

  static void showMaintenanceMode(BuildContext context) {
    showSnackbar(
      context,
      'System maintenance in progress. Some services may be unavailable.',
      type: MessageType.info,
      duration: const Duration(seconds: 6),
    );
  }
} 