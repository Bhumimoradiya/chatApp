import 'package:chat_app_firebase/auth/login_page.dart';
import 'package:chat_app_firebase/pages/homepage.dart';
import 'package:chat_app_firebase/services/auth_services.dart';
import 'package:chat_app_firebase/widgets/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class profile_page extends StatefulWidget {
  String username;
  String email;
  profile_page({Key? key, required this.email, required this.username})
      : super(key: key);

  @override
  State<profile_page> createState() => _profile_pageState();
}

class _profile_pageState extends State<profile_page> {
  Authservices authservices = Authservices();
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 238, 123, 100),
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 78.0),
          child: Text(
            "Profile",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Icon(
                Icons.account_circle,
                size: 130,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.username,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 20,
            ),
            ListTile(
              onTap: () {
                nextscreen(context, Homepage());
              },
              selected: true,
              title: Text(
                "Groups",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              leading: Icon(
                Icons.group,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              onTap: () {},
              selectedColor: Color.fromARGB(255, 238, 123, 100),
              // selectedColor: Color.fromARGB(255, 238, 123, 100),
              selected: true,
              title: Text(
                "Profile",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              leading: Icon(
                Icons.person,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              onTap: () async {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (contex) {
                      return AlertDialog(
                        title: Text("Logout"),
                        content: Text("Are you sure you want to logout ??"),
                        actions: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.cancel,
                                color: Colors.red,
                              )),
                          IconButton(
                              onPressed: () async {
                                await auth.signOut();
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(builder: (_) => login()),
                                    (route) => false);
                              },
                              icon: Icon(
                                Icons.done,
                                color: Colors.green,
                              ))
                        ],
                      );
                    });
                Colors.deepOrange.shade300;
              },
              // selectedColor: Color.fromARGB(255, 238, 123, 100),
              selected: true,
              title: Text(
                "Logout",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 150),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.account_circle,
                color: Colors.grey.shade700,
                size: 180,
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Full Name",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    widget.username,
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Email",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    widget.email,
                    style: TextStyle(fontSize: 16),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
