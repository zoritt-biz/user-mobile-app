import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/bloc.dart';
import 'package:zoritt_mobile_app_user/src/screens/input/custom_button.dart';
import 'package:zoritt_mobile_app_user/src/screens/input/input_field_controller.dart';

class SignIn extends StatefulWidget {
  static const String pathName = '/sign_in';

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String username;
  String password;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      builder: (loginCtx, loginState) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Sign in"),
          ),
          body: loginState is LoginLoading || loginState is LoginSuccessful
              ? Center(child: CircularProgressIndicator())
              : body(context),
        );
      },
      listener: (context, state) {
        if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Something went wrong")),
          );
        }
        if (state is LoginSuccessful) {
          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        }
      },
    );
  }

  Widget body(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.only(right: 20, left: 20),
        children: [
          SizedBox(
            height: 40.0,
          ),
          Center(
            child: Text(
              "Sign in to your account",
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
            hintText: "Email Address",
            icon: Icons.email_outlined,
            validator: _emailValidator,
            controller: emailController,
            obscureElement: false,
            labelText: null,
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(
            height: 10.0,
          ),
          InputController(
            labelText: null,
            hintText: "Password",
            icon: Icons.lock_outline_sharp,
            obscureElement: true,
            validator: _passwordValidator,
            controller: passwordController,
            keyboardType: TextInputType.text,
          ),
          SizedBox(
            height: 10.0,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, "/reset_password");
              },
              child: Text(
                "Forget Password?",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xff4267B2),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 35.0,
          ),
          CustomButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                context.read<LoginBloc>().logInWithCredentials(
                      email: emailController.text.trim(),
                      password: passwordController.text,
                    );
              }
            },
            text: "Sign In",
          ),
          SizedBox(
            height: 35.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have a account?",
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/sign_up");
                },
                child: Text(
                  "Register",
                  style: TextStyle(
                    color: Colors.blue[700],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

// Row(
//   children: [
//     Expanded(
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           primary: Color(0xff4267B2),
//           elevation: 0.0,
//           side: BorderSide(
//             color: Color(0xff4267B2),
//           ),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(5.0),
//           ),
//         ),
//         onPressed: () {},
//         child: Container(
//           height: 20,
//           width: 20,
//           child: SvgPicture.asset(
//             "assets/images/facebook.svg",
//             color: Colors.white,
//           ),
//         ),
//       ),
//     ),
//     SizedBox(
//       width: 10.0,
//     ),
//     Expanded(
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           primary: Colors.white,
//           elevation: 0.0,
//           side: BorderSide(
//             color: Colors.black26,
//           ),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(5.0),
//           ),
//         ),
//         onPressed: () {
//           // context.read<LoginBloc>().logInWithGoogle();
//         },
//         child: Container(
//           height: 20,
//           width: 20,
//           child: SvgPicture.asset(
//             "assets/images/google.svg",
//             fit: BoxFit.fill,
//           ),
//         ),
//       ),
//     ),
//   ],
// ),
