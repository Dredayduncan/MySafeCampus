import 'package:flutter/material.dart';
import 'package:my_safe_campus/constants.dart';
import 'package:my_safe_campus/services/auth.dart';
import 'package:my_safe_campus/views/homeScreen.dart';
import 'package:my_safe_campus/widgets/custom_button.dart';

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
  
  // Validation Regex
  final RegExp emailReg = RegExp(r'^[a-z]{2}[a-z]+(@ashesi.edu.gh)$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      TextFormField(
                        controller: _emailController,
                        onChanged: (value) {
                          setState(() {
                            _emailValue = _emailController.text;
                          });
                        },
                        validator: (emailValue) {
                          if (emailValue!.isEmpty || !emailReg.hasMatch(emailValue)){
                            return "Please input the correct Ashesi email";
                          }

                          return null;
                        },
                        style: const TextStyle(color: kDarkTextColor),
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Colors.grey,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.withOpacity(0.3)),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.withOpacity(0.3)),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.withOpacity(0.3),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _passController,
                        onChanged: (value) {
                          setState(() {
                            _passValue = _passController.text;
                          });
                        },
                        validator: (passValue) {
                          if (passValue!.isEmpty){
                            return "Please input the correct password";
                          }

                          return null;
                        },
                        style: const TextStyle(color: kDarkTextColor),
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.grey,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.withOpacity(0.3)),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.withOpacity(0.3)),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.withOpacity(0.3),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        onPressed: () {
                          if (!formKey.currentState!.validate()){
                            return;
                          }
                          else{
                            auth.signInWithEmailAndPassword(
                                _emailValue,
                                _passValue
                            ).
                            then((value) async {
                              if (value == null){
                                return showDialog(
                                  context: context,
                                  builder: (BuildContext context) => AlertDialog(
                                    title: const Text('Error'),
                                    content: const Text('Your username or password is incorrect'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => Navigator.pop(context, 'OK'),
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              }

                              return Navigator.push(
                                  context, MaterialPageRoute(
                                  builder: (context) => HomeScreen(auth: auth))
                              );

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
}
