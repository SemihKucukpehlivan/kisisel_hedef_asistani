import 'package:flutter/material.dart';

class TextInputContainer extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;
  final VoidCallback? onTap;
  final bool? isEnabled;
  final int? lines;
  const TextInputContainer(
      {super.key,
      required this.label,
      required this.controller,
      required this.hintText,
      this.onTap,
      this.lines,
      this.isEnabled});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextFormField(
          maxLines: lines,
          onTap: onTap,
          controller: controller,
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(fontStyle: FontStyle.italic),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              filled: true,
              fillColor: Colors.grey.shade200),
        ),
      ],
    );
  }
}
