// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:firenzery/app/pages/home/components/search_form.dart';
import 'package:firenzery/constants.dart';
import 'package:flutter/material.dart';

class TextFormComponent extends StatelessWidget {
  const TextFormComponent(
      {Key? key,
      required this.valid,
      required this.change,
      this.controller,
      this.text,
      this.keyboardType,
      this.inputFormatters,
      this.isObscured})
      : super(key: key);

  final valid, change, inputFormatters, keyboardType, controller;
  final bool? isObscured;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: text,
          border: outlineInputBorder,
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          errorBorder: outlineInputBorder,
          suffixIcon: const Padding(
            padding: EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding / 2),
            child: SizedBox(
              width: 48,
              height: 48,
            ),
          ),
        ),
        keyboardType: keyboardType,
        controller: controller,
        inputFormatters: inputFormatters,
        obscureText: isObscured ?? false,
        validator: valid,
        onChanged: change);
  }
}
