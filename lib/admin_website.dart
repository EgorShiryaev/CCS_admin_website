// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AdminWebsite extends StatefulWidget {
  const AdminWebsite({Key? key}) : super(key: key);

  @override
  State<AdminWebsite> createState() => _AdminWebsiteState();
}

class _AdminWebsiteState extends State<AdminWebsite> {
  TextEditingController loginController = TextEditingController();
  TextEditingController passController = TextEditingController();

  bool passwordIsUnvisible = true;
  bool isLoading = false;

  changePasswordIsUnvisible() {
    setState(() {
      passwordIsUnvisible = !passwordIsUnvisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin website',
      theme: ThemeData.dark(),
      home: Scaffold(
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Welcome to Admin console Cinema Control System', style: Styles.header),
                  Text('Please enter your login and password', style: Styles.header2),
                  SizedBox(height: 50),
                  SizedBox(
                    width: 300,
                    child: Column(
                      children: [
                        TextField(
                          controller: loginController,
                          cursorColor: Styles.inputFocusColor,
                          decoration: Styles.loginInputDecoration,
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: passController,
                          obscureText: passwordIsUnvisible,
                          cursorColor: Styles.inputFocusColor,
                          decoration: Styles.createPasswordInputDecoration(
                            unvisibility: passwordIsUnvisible,
                            tapIconFunction: changePasswordIsUnvisible,
                          ),
                        ),
                        SizedBox(height: 10),
                        OutlinedButton(
                          onPressed: _signIn,
                          child: SizedBox(
                            width: 300,
                            child: Center(
                              child: Text(
                                'Sign in',
                                style: Styles.header2,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 300)
                ],
              ),
            ),
            isLoading
                ? Center(
                    child: Container(
                      width: 1000,
                      height: 1000,
                      color: Color.fromRGBO(255, 255, 255, 0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }

  _signIn() {
    log('Login: ${loginController.text}');
    log('Password: ${passController.text}');
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    setState(() {
      isLoading = true;
    });
  }
}

class Styles {
  static const header = TextStyle(fontSize: 40, color: Colors.white);
  static const header2 = TextStyle(fontSize: 32, color: Colors.white);

  static const inputFocusColor = Colors.white;
  static const inputColor = Colors.grey;

  static const loginInputDecoration = InputDecoration(
    labelText: 'Login',
    // Unfocused
    labelStyle: TextStyle(color: inputColor),
    border: OutlineInputBorder(borderSide: BorderSide(color: inputColor)),
    // Focused
    floatingLabelStyle: TextStyle(color: inputFocusColor),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
  );

  static createPasswordInputDecoration({required unvisibility, required tapIconFunction}) {
    return InputDecoration(
      labelText: 'Password',
      // Unfocused
      labelStyle: TextStyle(color: inputColor),
      border: OutlineInputBorder(borderSide: BorderSide(color: inputColor)),
      // Focused
      floatingLabelStyle: TextStyle(color: inputFocusColor),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      suffixIcon: IconButton(
        icon: Icon(
          unvisibility ? Icons.visibility : Icons.visibility_off,
          color: inputFocusColor,
        ),
        onPressed: tapIconFunction,
      ),
    );
  }
}
