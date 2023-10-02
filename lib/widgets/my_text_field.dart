import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Function()? onTap;
  final int? maxLength;
  final bool? readOnly;
  final bool isEmpty;
  const MyTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.keyboardType,
    this.maxLength,
    this.onTap,
    this.readOnly,
    required this.isEmpty,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: onTap,
      cursorColor: Colors.white,
      keyboardType: keyboardType,
      controller: controller,
      maxLength: maxLength,
      readOnly: readOnly ?? false,
      style: const TextStyle(
          color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 4.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          borderSide:
              BorderSide(color: isEmpty ? Colors.red : Colors.grey, width: 1.0),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
            color: Colors.grey, fontSize: 17, fontWeight: FontWeight.w500),
        counterStyle: const TextStyle(color: Colors.white),
      ),
    );
  }
}
