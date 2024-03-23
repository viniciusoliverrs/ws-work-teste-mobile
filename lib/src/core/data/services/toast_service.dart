import 'package:flutter/material.dart';

enum MessageTypes {
  success(color: Colors.green, icon: Icons.check_circle_outline_outlined),
  info(color: Colors.blue, icon: Icons.info_outline),
  warning(color: Colors.orange, icon: Icons.warning_outlined),
  error(color: Colors.red, icon: Icons.error),
  diagnosticError(color: Colors.red, icon: Icons.error_outline),
  storeUpdateAvailable(color: Colors.blue, icon: Icons.info_outline);

  const MessageTypes({required this.color, required this.icon});
  final Color color;
  final IconData icon;
}

class ToastService {
  static void show(
    BuildContext context, {
    required String message,
    MessageTypes messageType = MessageTypes.error,
  })  {
    final size = MediaQuery.sizeOf(context);
    final snackBar = SnackBar(
      closeIconColor: Colors.white,
      showCloseIcon: messageType != MessageTypes.diagnosticError && messageType != MessageTypes.storeUpdateAvailable,
      dismissDirection: DismissDirection.horizontal,
      duration: const Duration(seconds: 10),
      behavior: SnackBarBehavior.floating,
      backgroundColor: messageType.color,
      content: Column(
        children: [
          Row(
            children: [
              Icon(
                messageType.icon,
                color: Colors.white,
              ),
              SizedBox(width: size.width * 0.02),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
        ],
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
