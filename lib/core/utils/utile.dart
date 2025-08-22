import 'package:flutter/material.dart';

class Utils {
  static void errorDialog(BuildContext context, String error, {void Function()? onPressed}) => showDialog(
    context: context,
    builder:
        (context) => Dialog(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(error),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: () => Navigator.pop(context), child: const Text('dismiss')),
                    TextButton(onPressed: onPressed, child: const Text('Retry')),
                  ],
                ),
              ],
            ),
          ),
        ),
  );

  static Future<T?> loadingDialog<T>(
    BuildContext context, {
    String message = 'Loading...',
    bool barrierDismissible = false,
  }) => showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder:
        (context) => PopScope(
          canPop: barrierDismissible,
          child: Dialog(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(message, style: Theme.of(context).textTheme.bodyLarge, textAlign: TextAlign.center),
                ],
              ),
            ),
          ),
        ),
  );
}
