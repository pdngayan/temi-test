import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class LoadingIndicator extends StatelessWidget {
  final String? message;
  final double size;
  final Color? color;
  final bool showMessage;

  const LoadingIndicator({
    Key? key,
    this.message,
    this.size = 40.0,
    this.color,
    this.showMessage = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(
                color ?? AppColors.primary,
              ),
            ),
          ),
          if (showMessage && message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}

class FullScreenLoading extends StatelessWidget {
  final String? message;
  final bool canDismiss;

  const FullScreenLoading({
    Key? key,
    this.message,
    this.canDismiss = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => canDismiss,
      child: Container(
        color: Colors.black54,
        child: LoadingIndicator(
          message: message ?? 'Loading...',
          size: 60,
        ),
      ),
    );
  }
} 