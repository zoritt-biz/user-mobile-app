import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

class FirstPage extends StatelessWidget {
  static const String pathName = "/first_page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 150),
        child: ListView(
          children: [
            Text(
              "Zorit for business",
              style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
              textAlign: TextAlign.center,
            ),
            Container(
              margin: EdgeInsets.only(top: 30, bottom: 30),
              child: Text(
                "By continuing, I agree to Zorit's Terms of Service and acknowledge Zorit's Privacy Policy.",
                style: TextStyle(
                  color: Colors.grey[500],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/sign_up');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).accentColor,
                  ),
                  elevation: MaterialStateProperty.all<double>(1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(13),
                  child: Text(
                    "Create a business account for free",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/sign_in');
              },
              style: ButtonStyle(
                  side: MaterialStateProperty.all<BorderSide>(
                      BorderSide(color: Colors.grey[400]))),
              child: Padding(
                padding: EdgeInsets.all(13),
                child: Text(
                  "Log in to your business account",
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
