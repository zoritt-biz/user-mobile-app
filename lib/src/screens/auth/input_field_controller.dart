import 'package:flutter/material.dart';

class InputController extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool obscureElement;
  final TextEditingController controller;
  final Function validator;

  const InputController({
    Key key,
    @required this.hintText,
    @required this.icon,
    @required this.obscureElement,
    @required this.controller,
    @required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextFormField(
        controller: controller,
        cursorColor: Theme.of(context).primaryColor,
        obscureText: obscureElement,
        validator: validator,
        enableSuggestions: !obscureElement,
        autocorrect: !obscureElement,
        decoration: InputDecoration(
          labelText: hintText,
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
