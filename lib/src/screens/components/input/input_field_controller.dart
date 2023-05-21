import 'package:flutter/material.dart';

class InputController extends StatelessWidget {
  final String hintText;
  final String labelText;
  final IconData icon;
  final bool obscureElement;
  final TextEditingController controller;
  final Function validator;
  final TextInputType keyboardType;

  const InputController({
    Key key,
    @required this.hintText,
    @required this.icon,
    @required this.obscureElement,
    @required this.controller,
    @required this.validator,
    @required this.labelText,
    @required this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        cursorColor: Theme.of(context).primaryColor,
        obscureText: obscureElement,
        validator: validator,
        enableSuggestions: !obscureElement,
        autocorrect: !obscureElement,
        decoration: InputDecoration(
          hintText: hintText != null ? hintText : null,
          labelText: labelText != null ? labelText : null,
          focusColor: Colors.red,
          prefixIcon: Icon(
            icon,
            size: 25.0,
          ),
        ),
      ),
    );
  }
}
