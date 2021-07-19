import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/bloc.dart';
import 'package:zoritt_mobile_app_user/src/screens/input/custom_button.dart';
import 'package:zoritt_mobile_app_user/src/screens/input/input_field_controller.dart';

class SignUp extends StatefulWidget {
  static const String pathName = '/sign_up';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String username = "";
  String password = "";
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _passwordValidator(String value) {
    if (value.isEmpty) {
      return "invalid input";
    }
    if (value.length < 6) {
      return "password should have at least 6 char";
    }
    return null;
  }

  String _usernameValidator(String value) {
    if (value.isEmpty) {
      return "invalid input";
    }
    return null;
  }

  String _emailValidator(String value) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    if (value.isEmpty || !emailValid) {
      return "invalid input";
    }
    return null;
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(
      builder: (signUpCtx, signUpState) {
        return Scaffold(
          // backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(title: Text("Sign up")),
          body: signUpState is SignUpLoading || signUpState is SignUpSuccessful
              ? Center(child: CircularProgressIndicator())
              : body(context),
        );
      },
      listener: (signUpCtx, signUpState) {
        if (signUpState is SignUpFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Something went wrong")),
          );
        }
        if (signUpState is SignUpSuccessful) {
          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        }
      },
    );
  }

  Widget body(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: ListView(
          padding: const EdgeInsets.only(right: 20, left: 20, bottom: 0),
          children: [
            SizedBox(
              height: 40.0,
            ),
            Center(
              child: Text(
                "Create your account",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            InputController(
              hintText: "First Name",
              labelText: null,
              icon: Icons.account_circle,
              controller: firstNameController,
              obscureElement: false,
              validator: _usernameValidator,
              keyboardType: TextInputType.text,
            ),
            SizedBox(
              height: 10.0,
            ),
            SizedBox(
              height: 10.0,
            ),
            InputController(
              hintText: "Last Name",
              labelText: null,
              icon: Icons.account_circle,
              controller: lastNameController,
              obscureElement: false,
              validator: _usernameValidator,
              keyboardType: TextInputType.text,
            ),
            SizedBox(
              height: 10.0,
            ),
            InputController(
              hintText: "Email Address",
              labelText: null,
              icon: Icons.email_outlined,
              validator: _emailValidator,
              controller: emailController,
              obscureElement: false,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 10.0,
            ),
            InputController(
              hintText: "Phone Number",
              labelText: null,
              icon: Icons.phone,
              validator: _usernameValidator,
              controller: phoneNumberController,
              obscureElement: false,
              keyboardType: TextInputType.phone,
            ),
            SizedBox(
              height: 10.0,
            ),
            InputController(
              hintText: "Password",
              labelText: null,
              icon: Icons.lock_outline_sharp,
              obscureElement: true,
              validator: _passwordValidator,
              controller: passwordController,
              keyboardType: TextInputType.text,
            ),
            SizedBox(
              height: 10.0,
            ),
            InputController(
              hintText: "Confirm Password",
              labelText: null,
              icon: Icons.lock_outline_sharp,
              obscureElement: true,
              validator: _passwordValidator,
              controller: confirmPasswordController,
              keyboardType: TextInputType.text,
            ),
            SizedBox(
              height: 40.0,
            ),
            CustomButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  context.read<SignUpBloc>().signUp(
                        email: emailController.text.trim(),
                        password: passwordController.text,
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        phoneNumber: phoneNumberController.text,
                      );
                }
              },
              text: "Sign Up",
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Do you have an account?",
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/sign_in");
                  },
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                      color: Colors.blue[700],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
