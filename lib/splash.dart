import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';


Size? mq;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  dynamic checkUser() async {
  Navigator.push(context, MaterialPageRoute(builder: (_)=> HomePage()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 8), () => checkUser());
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          Center(child: Image.asset('assets/images/iron.jpg')),

          CircularProgressIndicator(color: Colors.white,),
          Text("Loading....")
        ],
      ),
    );
  }
}
