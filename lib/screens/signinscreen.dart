import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_confirmpassword/screens/signupscreen.dart';
import 'package:firebase_confirmpassword/screens/splashscreen.dart';
import 'package:flutter/material.dart';

import '../class/userid.dart';

class MySignInScreen extends StatefulWidget {
  const MySignInScreen({Key? key}) : super(key: key);

  @override
  State<MySignInScreen> createState() => _MySignInScreenState();
}

class _MySignInScreenState extends State<MySignInScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  Modal modal = Modal();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: height * .2,
              ),
              SizedBox(
                height: height * .1,
                child: Center(
                    child: Text(
                  'SignInScreen',
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                )),
              ),
              SizedBox(
                height: height * .1,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * .1,
                        width: width * .7,
                        child: TextFormField(
                          controller: emailTextEditingController,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                !value.contains('@') ||
                                !value.contains('.')) {
                              return 'Invalid Email';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            hintText: 'Email ',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * .1,
                        width: width * .7,
                        child: TextFormField(
                          controller: passwordTextEditingController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter some text';
                            }
                            if (value.length < 3) {
                              return 'Must be more than 2 charater';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            hintText: 'Password ',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: height * .1,
              ),
              SizedBox(
                height: height * .1,
                width: width * .7,
                child: ElevatedButton(
                  child: Text('SignIn'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String email;
                      String password;
                      email = emailTextEditingController.text;
                      password = passwordTextEditingController.text;
                      var authentication =
                          await auth.signInWithEmailAndPassword(
                              email: email, password: password);
                      try {
                        if (authentication != null) {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return MySplashScreen(
                                userId: modal.uid,
                              );
                            },
                          ));
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('successfull')));
                        }
                        emailTextEditingController.clear();
                        passwordTextEditingController.clear();
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())));
                      }
                    }
                  },
                ),
              ),
              SizedBox(
                height: height * .1,
              ),
              SizedBox(
                height: height * .1,
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return MySignUpScreen();
                          },
                        ),
                      );
                    },
                    child: Text('Go To SignUp')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
