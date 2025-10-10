import 'package:flutter/material.dart';

class Utils {
  static void errorDialog(
    BuildContext context,
    String error, {
    void Function()? onPressed,
    String title = 'Error',
    String dismissText = 'Dismiss',
    String retryText = 'Retry',
    Color? accentColor,
    IconData? icon,
  }) => showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black54,
    builder:
        (context) => _ModernErrorDialog(
          error: error,
          title: title,
          dismissText: dismissText,
          retryText: retryText,
          onRetry: onPressed,
          accentColor: accentColor,
          icon: icon,
        ),
  );

  // Success dialog with modern design
  static void successDialog(
    BuildContext context,
    String message, {
    String title = 'Success',
    String buttonText = 'OK',
    VoidCallback? onPressed,
    Color? accentColor,
    IconData? icon,
  }) => showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black54,
    builder:
        (context) => _ModernSuccessDialog(
          message: message,
          title: title,
          buttonText: buttonText,
          onPressed: onPressed,
          accentColor: accentColor,
          icon: icon,
        ),
  );

  // Confirmation dialog with modern design
  static Future<bool?> confirmationDialog(
    BuildContext context,
    String message, {
    String title = 'Confirm',
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    Color? accentColor,
    IconData? icon,
  }) => showDialog<bool>(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black54,
    builder:
        (context) => _ModernConfirmationDialog(
          message: message,
          title: title,
          confirmText: confirmText,
          cancelText: cancelText,
          accentColor: accentColor,
          icon: icon,
        ),
  );

  // Info dialog with modern design
  static void infoDialog(
    BuildContext context,
    String message, {
    String title = 'Information',
    String buttonText = 'OK',
    VoidCallback? onPressed,
    Color? accentColor,
    IconData? icon,
  }) => showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black54,
    builder:
        (context) => _ModernInfoDialog(
          message: message,
          title: title,
          buttonText: buttonText,
          onPressed: onPressed,
          accentColor: accentColor,
          icon: icon,
        ),
  );

  static Future<T?> loadingDialog<T>(
    BuildContext context, {
    String message = 'Loading...',
    bool barrierDismissible = false,
    Color? accentColor,
    bool showProgress = true,
    Duration? autoDismissDuration,
  }) => showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierColor: Colors.black54,
    builder:
        (context) => PopScope(
          canPop: barrierDismissible,
          child: _ModernLoadingDialog(
            message: message,
            accentColor: accentColor,
            showProgress: showProgress,
            autoDismissDuration: autoDismissDuration,
          ),
        ),
  );
}

// Modern Loading Dialog Widget
class _ModernLoadingDialog extends StatefulWidget {
  final String message;
  final Color? accentColor;
  final bool showProgress;
  final Duration? autoDismissDuration;

  const _ModernLoadingDialog({required this.message, this.accentColor, this.showProgress = true, this.autoDismissDuration});

  @override
  State<_ModernLoadingDialog> createState() => _ModernLoadingDialogState();
}

class _ModernLoadingDialogState extends State<_ModernLoadingDialog> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _rotateController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this);

    _rotateController = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);

    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut));

    _rotateAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _rotateController, curve: Curves.linear));

    _pulseController.repeat(reverse: true);
    _rotateController.repeat();

    // Auto dismiss if duration is provided
    if (widget.autoDismissDuration != null) {
      Future.delayed(widget.autoDismissDuration!).then((_) {
        if (mounted && Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      });
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rotateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accentColor = widget.accentColor ?? theme.colorScheme.primary;

    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 40),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(color: Colors.black.withAlpha(25), blurRadius: 20, offset: const Offset(0, 10), spreadRadius: 0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Animated loading indicator
              if (widget.showProgress) ...[
                AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _pulseAnimation.value,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [accentColor.withAlpha(25), accentColor.withAlpha(75)],
                          ),
                        ),
                        child: Center(
                          child: AnimatedBuilder(
                            animation: _rotateAnimation,
                            builder: (context, child) {
                              return Transform.rotate(
                                angle: _rotateAnimation.value * 2 * 3.14159,
                                child: Icon(Icons.refresh_rounded, color: accentColor, size: 40),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
              ],

              // Message text with modern typography
              Text(
                widget.message,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.2,
                ),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),

              // Subtle progress dots
              if (widget.showProgress) ...[
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    return AnimatedBuilder(
                      animation: _pulseController,
                      builder: (context, child) {
                        final delay = index * 0.2;
                        final animationValue = (_pulseController.value + delay) % 1.0;
                        final scale = 0.5 + (0.5 * animationValue);

                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: 8 * scale,
                          height: 8 * scale,
                          decoration: BoxDecoration(color: accentColor.withAlpha(150), shape: BoxShape.circle),
                        );
                      },
                    );
                  }),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// Modern Error Dialog Widget
class _ModernErrorDialog extends StatelessWidget {
  final String error;
  final String title;
  final String dismissText;
  final String retryText;
  final VoidCallback? onRetry;
  final Color? accentColor;
  final IconData? icon;

  const _ModernErrorDialog({
    required this.error,
    required this.title,
    required this.dismissText,
    required this.retryText,
    this.onRetry,
    this.accentColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final errorColor = accentColor ?? theme.colorScheme.error;
    final errorIcon = icon ?? Icons.error_outline_rounded;

    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 40),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(color: Colors.black.withAlpha(25), blurRadius: 20, offset: const Offset(0, 10), spreadRadius: 0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Error icon with background
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(shape: BoxShape.circle, color: errorColor.withAlpha(25)),
                child: Icon(errorIcon, size: 40, color: errorColor),
              ),

              const SizedBox(height: 24),

              // Error title
              Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              // Error message
              Text(
                error,
                style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface.withAlpha(181), height: 1.4),
                textAlign: TextAlign.center,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 32),

              // Action buttons
              Row(
                children: [
                  // Dismiss button
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        side: BorderSide(color: theme.colorScheme.outline.withAlpha(75)),
                      ),
                      child: Text(
                        dismissText,
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.onSurface,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  if (onRetry != null) ...[
                    const SizedBox(width: 16),

                    // Retry button
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          onRetry?.call();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: errorColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 0,
                        ),
                        child: Text(
                          retryText,
                          style: theme.textTheme.labelLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Modern Info Dialog Widget
class _ModernInfoDialog extends StatelessWidget {
  final String message;
  final String title;
  final String buttonText;
  final VoidCallback? onPressed;
  final Color? accentColor;
  final IconData? icon;

  const _ModernInfoDialog({
    required this.message,
    required this.title,
    required this.buttonText,
    this.onPressed,
    this.accentColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final infoColor = accentColor ?? theme.colorScheme.primary;
    final infoIcon = icon ?? Icons.info_outline_rounded;

    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 40),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(color: Colors.black.withAlpha(25), blurRadius: 20, offset: const Offset(0, 10), spreadRadius: 0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Info icon with background
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(shape: BoxShape.circle, color: infoColor.withAlpha(25)),
                child: Icon(infoIcon, size: 40, color: infoColor),
              ),

              const SizedBox(height: 24),

              // Info title
              Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              // Info message
              Text(
                message,
                style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface.withAlpha(181), height: 1.4),
                textAlign: TextAlign.center,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 32),

              // Action button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    onPressed?.call();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: infoColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: Text(
                    buttonText,
                    style: theme.textTheme.labelLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Modern Confirmation Dialog Widget
class _ModernConfirmationDialog extends StatelessWidget {
  final String message;
  final String title;
  final String confirmText;
  final String cancelText;
  final Color? accentColor;
  final IconData? icon;

  const _ModernConfirmationDialog({
    required this.message,
    required this.title,
    required this.confirmText,
    required this.cancelText,
    this.accentColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final confirmColor = accentColor ?? theme.colorScheme.primary;
    final confirmIcon = icon ?? Icons.help_outline_rounded;

    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 40),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(color: Colors.black.withAlpha(25), blurRadius: 20, offset: const Offset(0, 10), spreadRadius: 0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Confirmation icon with background
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(shape: BoxShape.circle, color: confirmColor.withAlpha(25)),
                child: Icon(confirmIcon, size: 40, color: confirmColor),
              ),

              const SizedBox(height: 24),

              // Confirmation title
              Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              // Confirmation message
              Text(
                message,
                style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface.withAlpha(181), height: 1.4),
                textAlign: TextAlign.center,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 32),

              // Action buttons
              Row(
                children: [
                  // Cancel button
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context, false),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        side: BorderSide(color: theme.colorScheme.outline.withAlpha(75)),
                      ),
                      child: Text(
                        cancelText,
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.onSurface,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Confirm button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context, true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: confirmColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                      child: Text(
                        confirmText,
                        style: theme.textTheme.labelLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Modern Success Dialog Widget
class _ModernSuccessDialog extends StatelessWidget {
  final String message;
  final String title;
  final String buttonText;
  final VoidCallback? onPressed;
  final Color? accentColor;
  final IconData? icon;

  const _ModernSuccessDialog({
    required this.message,
    required this.title,
    required this.buttonText,
    this.onPressed,
    this.accentColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final successColor = accentColor ?? Colors.green;
    final successIcon = icon ?? Icons.check_circle_outline_rounded;

    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 40),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(color: Colors.black.withAlpha(25), blurRadius: 20, offset: const Offset(0, 10), spreadRadius: 0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Success icon with background
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(shape: BoxShape.circle, color: successColor.withAlpha(25)),
                child: Icon(successIcon, size: 40, color: successColor),
              ),

              const SizedBox(height: 24),

              // Success title
              Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              // Success message
              Text(
                message,
                style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface.withAlpha(181), height: 1.4),
                textAlign: TextAlign.center,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 32),

              // Action button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    onPressed?.call();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: successColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: Text(
                    buttonText,
                    style: theme.textTheme.labelLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
