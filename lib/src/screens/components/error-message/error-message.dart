import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final Function onPressed;

  const ErrorMessage({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Connection error. Please"),
            TextButton(
              onPressed: onPressed,
              child: Text("Retry!"),
            )
          ],
        ),
      ),
    );
  }
}
