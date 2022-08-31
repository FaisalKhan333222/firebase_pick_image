import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_confirmpassword/screens/signinscreen.dart';
import 'package:flutter/material.dart';

import '../class/userid.dart';

class MySignUpScreen extends StatefulWidget {
  const MySignUpScreen({Key? key}) : super(key: key);

  @override
  State<MySignUpScreen> createState() => _MySignUpScreenState();
}

class _MySignUpScreenState extends State<MySignUpScreen> {
  static final RegExp nameRegExp = RegExp('[a-zA-Z]');
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    Modal userId = Modal();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * .1,
              ),
              SizedBox(
                height: height * .1,
                child: Center(
                    child: Text(
                  'SignUpScreen',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
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
                          controller: nameTextEditingController,
                          validator: (value) => value!.isEmpty
                              ? 'Enter Your Name'
                              : (nameRegExp.hasMatch(value)
                                  ? null
                                  : 'Enter a Valid Name'),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            hintText: 'Name ',
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
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                !value.contains('@') ||
                                !value.contains('.')) {
                              return 'Invalid Email';
                            }
                            return null;
                          },
                          controller: emailTextEditingController,
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter some text';
                            }
                            if (value.length < 3) {
                              return 'Must be more than 2 charater';
                            }
                            return null;
                          },
                          controller: passwordTextEditingController,
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
                      SizedBox(
                        height: height * .1,
                        width: width * .7,
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter some text';
                            }
                            if (value.length < 3) {
                              return 'Must be more than 2 charater';
                            }
                            return null;
                          },
                          controller: confirmPasswordTextEditingController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            hintText: 'ConfirmPassword',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * .1,
                      ),
                      SizedBox(
                        height: height * .1,
                        width: width * .7,
                        child: ElevatedButton(
                          child: Text('SignUp'),
                          onPressed: () async {
                            createUser(emailTextEditingController.text,
                                passwordTextEditingController.text);
                          },
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: height * .1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void createUser(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
        User? user = auth.currentUser;
        Modal modal = Modal();
        modal.uid = user!.uid;
        print(modal.uid);
        modal.email = user.email;
        modal.name = nameTextEditingController.text;
        firebaseFirestore.collection('user').doc(user.uid).set(modal.toMap());
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return MySignInScreen();
          },
        ));
        emailTextEditingController.clear();
        passwordTextEditingController.clear();
        nameTextEditingController.clear();
        confirmPasswordTextEditingController.clear();
      }).catchError((e) {
        print(e.toString());
      });
    }
  }
}
