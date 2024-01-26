import 'package:flutter/material.dart';
import 'package:get/get.dart';

void customSnackBar({
  required String title,
  required String message,
  required BuildContext context,
}) {
  Get.snackbar(
    title,
    message,
    icon: Icon(Icons.check,
        color: Theme.of(context).colorScheme.tertiary),
    duration: const Duration(seconds: 3),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Theme.of(context).colorScheme.tertiaryContainer.withOpacity(0.5),
  );
}