import 'package:firebase_confirmpassword/screens/signinscreen.dart';
import 'package:firebase_confirmpassword/screens/signupscreen.dart';
import 'package:flutter/material.dart';

class MyFirstScreen extends StatefulWidget {
  const MyFirstScreen({Key? key}) : super(key: key);

  @override
  State<MyFirstScreen> createState() => _MyFirstScreenState();
}

class _MyFirstScreenState extends State<MyFirstScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: height * .2,
            ),
            SizedBox(
              height: height * .1,
              child: Center(
                  child: Text(
                'Choose Screen',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              )),
            ),
            SizedBox(
              height: height * .305,
            ),
            SizedBox(
              height: height * .1,
              width: width * .7,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return MySignUpScreen();
                    },
                  ));
                },
                child: Center(
                  child: Text('SignUpScreen'),
                ),
              ),
            ),
            SizedBox(
              height: height * .05,
            ),
            SizedBox(
              height: height * .1,
              width: width * .7,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return MySignInScreen();
                    },
                  ));
                },
                child: Center(
                  child: Text('SignInScreen'),
                ),
              ),
            ),
            SizedBox(
              height: height * .1,
            ),
          ],
        ),
      ),
    );
  }
}
