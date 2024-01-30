import 'package:flutter/material.dart';

// text Field 의 제목
Column formTitle({
  required String title,
  required bool isRequired,
}) {
  return Column(
    children: [
      Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          isRequired == true
              ? const Text(
            '*',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.red),
          )
              : const SizedBox()
        ],
      ),
      const Padding(padding: EdgeInsets.only(bottom: 10)),
    ],
  );
}