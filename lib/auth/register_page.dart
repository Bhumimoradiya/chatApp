import 'package:chat_app_firebase/auth/login_page.dart';
import 'package:chat_app_firebase/helper/helper_function.dart';
import 'package:chat_app_firebase/pages/homepage.dart';
import 'package:chat_app_firebase/services/auth_services.dart';
import 'package:chat_app_firebase/widgets/widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class registerpage extends StatefulWidget {
  registerpage({Key? key}) : super(key: key);

  @override
  State<registerpage> createState() => _registerpageState();
}

class _registerpageState extends State<registerpage> {
  final formkey = GlobalKey<FormState>();
  bool isloading = false;
  String email = '';
  String password = '';
  String fullname = '';
  Authservices authservices = Authservices();

  @override
  Widget build(BuildContext context) {
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
                        padding: const EdgeInsets.only(top: 3),
                        child: Text(
                          "Create your now to chat and explore",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Image.asset(
                        "assets/images/registerimg.png",
                      ),
                      TextFormField(
                        // controller: passwo,
                        decoration: textInputDecoration.copyWith(
                            labelText: "Full Name",
                            prefixIcon: Icon(
                              Icons.person,
                              color: Color(0xFFee7b64),
                            )),
                        validator: (value) {
                          if (value!.isNotEmpty) {
                            return null;
                          } else {
                            return "Name cannot be empty";
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            fullname = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
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
                            register();
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
                            "Register",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Text.rich(
                        TextSpan(
                            text: "Already have an account?",
                            style: TextStyle(),
                            children: [
                              TextSpan(
                                text: "Login now",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    nextscreenreplace(context, login());
                                  },
                                style: TextStyle(
                                    decoration: TextDecoration.underline),
                              )
                            ]),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
 
  register() async {
    if (formkey.currentState!.validate()) {
      setState(() {
        isloading = true;
      });
        await authservices
          .registerUserWithEmailandPassword(fullname, email, password)
          .then((value) async {
        if (value == true) {
          await helperfunction.saveUserLoggedInStatus(true);
          await helperfunction.saveUserEmailSF(email);
          await helperfunction.saveUserNameSF(fullname);
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
