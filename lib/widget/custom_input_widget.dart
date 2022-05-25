import 'package:flutter/material.dart';

class CustomInputWidget extends StatelessWidget {
  const CustomInputWidget({
    Key? key,
    required this.inputController,
    required this.hintText,
  }) : super(key: key);

  final TextEditingController inputController;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      controller: inputController,
      validator: (value) {
        if (value!.isEmpty) {
          return ("This field can't be empty ");
        }
        return null;
      },
      onSaved: (value) {
        inputController.text = value!;
      },
      decoration: InputDecoration(
        fillColor: const Color.fromARGB(255, 190, 244, 227),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 2.0,
          ),
        ),
        hintText: hintText,
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      ),
    );
  }
}
