import 'package:chat_app_firebase/auth/login_page.dart';
import 'package:chat_app_firebase/auth/register_page.dart';
import 'package:chat_app_firebase/helper/helper_function.dart';
import 'package:chat_app_firebase/pages/profile_page.dart';
import 'package:chat_app_firebase/pages/searchpage.dart';
import 'package:chat_app_firebase/services/auth_services.dart';
import 'package:chat_app_firebase/services/database_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../widgets/widget.dart';

class Homepage extends StatefulWidget {
  Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool _isloading = false;
  String username = '';
  String email = '';
  String groupName = '';
  // Authservices authservices = Authservices();
  FirebaseAuth auth = FirebaseAuth.instance;
  Stream? groups;
  @override
  void initState() {
    super.initState();
    gettinguserdata();
  }

  gettinguserdata() async {
    await helperfunction.getUserEmailSF().then((value) {
      setState(() {
        email = value!;
      });
    });
    await helperfunction.getUserNameSF().then((value) {
      setState(() {
        username = value!;
      });
    });
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getusergroups()
        .then((snapshot) {
      setState(() {
        groups = snapshot;
      });
    });
  }

  // signOut() async {
  //   await auth.signOut().whenComplete(() {
  //     nextscreen(context, login());
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                  onPressed: () {
                    nextscreen(context, searchpage());
                  },
                  icon: Icon(Icons.search))),
        ],
        title: Text("Groups"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 238, 123, 100),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Icon(
                Icons.account_circle,
                size: 130,
                color: Colors.blueGrey,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              username,
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
              onTap: () {},
              selectedColor: Color.fromARGB(255, 238, 123, 100),
              selected: true,
              title: Text(
                "Groups",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              leading: Icon(Icons.group),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              onTap: () {
                nextscreenreplace(
                    context,
                    profile_page(
                      email: email,
                      username: username,
                    ));
              },
              // selectedColor: Color.fromARGB(255, 238, 123, 100),
              selected: true,
              title: Text(
                "Profile",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              leading: Icon(
                Icons.person,
                color: Colors.grey,
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
                // await auth.signOut().whenComplete(() {
                //   nextscreen(context, login());
                // });
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
      body: grouplist(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          popupdialog(context);
        },
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 238, 123, 100),
        child: Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }

  popupdialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Create a group",
              textAlign: TextAlign.left,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _isloading == true
                    ? Center(
                        child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 238, 123, 100),
                      ))
                    : TextField(
                        onChanged: ((value) {
                          groupName = value;
                        }),
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFee7b64),
                                width: 2,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(22))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFee7b64),
                                width: 2,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(22))),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 238, 123, 100),
                                // width: 2,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(22))),
                        )),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 238, 123, 100),
                ),
                child: Text("CANCEL",
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
              ElevatedButton(
                onPressed: () {
                  if (groupName != '') {
                    setState(() {
                      _isloading = true;
                    });
                    DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                        .creategroup(username,
                            FirebaseAuth.instance.currentUser!.uid, groupName)
                        .whenComplete(() {
                      _isloading = false;
                    });
                    Navigator.of(context).pop();
                    showSnackbar(
                        context, Colors.green, 'Group created successfully.');
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 238, 123, 100),
                ),
                child: Text("CREATE",
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
            ],
          );
        });
  }

  grouplist() {
    return StreamBuilder(
      stream: groups,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (condition) {
            
          }else{

          return nogroupwidget();
          }
        }
        // else {
        //     return nogroupwidget();
        //          }
        else {
          return Center(
              child: CircularProgressIndicator(
            color: Color.fromARGB(255, 238, 123, 100),
          ));
        }
      },
    );
  }

  nogroupwidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              popupdialog(context);
            },
            child: Icon(
              Icons.add_circle,
              color: Colors.grey.shade700,
              size: 65,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "You've not joined any groups, tap on the add icon to create a group or also search from top search button",
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
