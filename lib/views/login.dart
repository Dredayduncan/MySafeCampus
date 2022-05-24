import 'package:flutter/material.dart';
import 'package:my_safe_campus/constants.dart';
import 'package:my_safe_campus/services/auth.dart';
import 'package:my_safe_campus/views/homeScreen.dart';
import 'package:my_safe_campus/views/loading_screen.dart';
import 'package:my_safe_campus/widgets/custom_button.dart';
import 'package:my_safe_campus/widgets/custom_textfield.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // form key
  final formKey = GlobalKey<FormState>();
  final Auth auth = Auth();

  // form field controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  // controller values
  String _emailValue = '';
  String _passValue = '';

  // boolean state to trigger loading screen
  bool _isLoading = false;

  // Validation Regex
  final RegExp emailReg = RegExp(r'^[a-z]{2}[a-z]+(@ashesi.edu.gh)$');

  @override
  Widget build(BuildContext context) => _isLoading
      ? const LoadingScreen()
      : Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    // margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    width: double.infinity,
                    height: 350,
                    child: Image(
                      image: AssetImage("assets/images/Mansplaining-bro.png"),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: Text(
                      "Let's log you in.",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Facilisi tempor fringilla.",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: _emailController,
                            hintText: 'Email',
                            icon: Icons.email,
                            onChanged: (value) {
                              setState(() {
                                _emailValue = _emailController.text;
                              });
                            },
                            validator: (emailValue) {
                              if (emailValue!.isEmpty ||
                                  !emailReg.hasMatch(emailValue)) {
                                return "Please input the correct Ashesi email";
                              }

                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: _passController,
                            hintText: 'Password',
                            icon: Icons.lock,
                            onChanged: (value) {
                              setState(() {
                                _passValue = _passController.text;
                              });
                            },
                            validator: (passValue) {
                              if (passValue!.isEmpty) {
                                return "Please input the correct password";
                              }

                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          CustomButton(
                            onPressed: () {
                              if (!formKey.currentState!.validate()) {
                                return;
                              } else {
                                // set isLoading to true
                                setState(() {
                                  _isLoading = true;
                                });
                                auth
                                    .signInWithEmailAndPassword(
                                        _emailValue, _passValue)
                                    .then((value) async {
                                  if (value == null) {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    return showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: const Text('Error'),
                                        content: const Text(
                                            'Your username or password is incorrect'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, 'OK'),
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                  }

                                  await Future.delayed(
                                    const Duration(seconds: 2),
                                  );

                                  // set isLoading to false
                                  setState(() {
                                    _isLoading = false;
                                  });

                                  return Navigator.of(context,
                                          rootNavigator: true)
                                      .pushReplacementNamed('/home');
                                });
                              }
                            },
                            btnName: 'Sign In',
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
}
