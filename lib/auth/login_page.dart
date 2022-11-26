import 'package:chat_app_firebase/auth/register_page.dart';
import 'package:chat_app_firebase/pages/homepage.dart';
import 'package:chat_app_firebase/services/auth_services.dart';
import 'package:chat_app_firebase/services/database_services.dart';
import 'package:chat_app_firebase/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:chat_app_firebase/helper/helper_function.dart';

class login extends StatefulWidget {
  login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final formkey = GlobalKey<FormState>();
  Authservices authservices = Authservices();
  bool isloading = false;
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    return Scaffold(
      body: isloading
          ? Center(
              child: CircularProgressIndicator(
                color: Color(0xFFee7b64),
              ),
            )
          : SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 80),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Text(
                          "Groupie",
                          style: TextStyle(
                              fontSize: 36, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Text(
                          "Login Now to see what they are talking!",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Image.asset(
                        "assets/images/loginimg.png",
                      ),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                            labelText: "Email",
                            prefixIcon: Icon(
                              Icons.email,
                              color: Color(0xFFee7b64),
                            )),
                        validator: (value) {
                          return RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value!)
                              ? null
                              : "Please Enter a valid Email";
                        },
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        obscureText: true,
                        // controller: passwo,
                        decoration: textInputDecoration.copyWith(
                            labelText: "Password",
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Color(0xFFee7b64),
                            )),
                        validator: (value) {
                          if (value!.length < 6) {
                            return "Password must be atleast 6 characters";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            login();
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Color(
                                0xFFee7b64,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: BorderSide(
                                    color: Color(
                                      0xFFee7b64,
                                    ),
                                  )),
                              minimumSize: Size(320, 45)),
                          child: Text(
                            "Sign in",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Text.rich(
                        TextSpan(
                            text: "Don't have an account?",
                            style: TextStyle(),
                            children: [
                              TextSpan(
                                text: "Register here",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    nextscreen(context, registerpage());
                                  },
                                style: TextStyle(
                                    decoration: TextDecoration.underline),
                              )
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  login() async {
    if (formkey.currentState!.validate()) {
      setState(() {
        isloading = true;
      });
      await authservices
          .loginwithusenameandpassword(email, password)
          .then((value) async {
        if (value == true) {
          QuerySnapshot snapshot =
              await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                  .gettinguserdata(email);
          await helperfunction.saveUserLoggedInStatus(true);
          await helperfunction.saveUserEmailSF(email);

          nextscreen(context, Homepage());
        } else {
          showSnackbar(context, Color(0xFFee7b64), value);
          setState(() {
            isloading = false;
          });
        }
      });
    }
  }
}
