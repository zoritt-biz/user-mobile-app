import 'package:flutter/material.dart';
import 'package:zoritt_mobile_app_user/src/screens/input/input_field_controller.dart';

class ResetPassword extends StatelessWidget {
  static const String pathName = "/reset_password";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reset")),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              children: [
                Image.asset(
                  "asset/images/reset.jpg",
                  width: 200.0,
                ),
                Text(
                  "Reset Password",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.0),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Text(
                  "Please enter your email address. you will receive a link to create a new password via email",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey,
                    height: 1.5,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                InputController(
                  hintText: "",
                  icon: Icons.email_outlined,
                  obscureElement: false,
                  controller: null,
                  validator: null,
                  keyboardType: TextInputType.emailAddress,
                  labelText: "Email Address",
                ),
                SizedBox(
                  height: 15.0,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xffFFA500),
                    ),
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(13),
                      child: Text(
                        "Send",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
