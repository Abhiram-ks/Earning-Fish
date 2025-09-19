 import 'package:flutter/material.dart';

Widget buildRadioTile(String title, bool? value, Function(bool?) onChanged) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<bool>(
                    title: const Text('Yes'),
                    value: true,
                    groupValue: value,
                    onChanged: onChanged,
                    dense: true,
                  ),
                ),
                Expanded(
                  child: RadioListTile<bool>(
                    title: const Text('No'),
                    value: false,
                    groupValue: value,
                    onChanged: onChanged,
                    dense: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }