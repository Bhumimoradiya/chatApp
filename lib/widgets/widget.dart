import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  labelStyle: TextStyle(color: Colors.black),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFFee7b64),
        width: 2,
      ),
      borderRadius: BorderRadius.all(Radius.circular(12))),
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFFee7b64),
        width: 2,
      ),
      borderRadius: BorderRadius.all(Radius.circular(12))),
  errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromARGB(255, 238, 123, 100),
        // width: 2,
      ),
      borderRadius: BorderRadius.all(Radius.circular(12))),
);
void nextscreen(context,page){
  Navigator.push(context, MaterialPageRoute(builder: (_)=>page));
}

void nextscreenreplace(context,page){
  Navigator.push(context, MaterialPageRoute(builder: (_)=>page));
}
void showSnackbar(context,color ,message){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: 
    Text(message),backgroundColor:color,
    duration: Duration(seconds: 2),
    action: SnackBarAction(label: "Ok", onPressed: () {  },textColor: Colors.white,),)
  );
}
