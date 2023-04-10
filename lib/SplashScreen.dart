import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:siddikbhai_c/Constants.dart';

import 'main.dart';


class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset(
          'assets/images/ll.png',),
      logoWidth: 150,
      title: Text(
        "আঁরা চাটগাঁর হতা হই",
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      gradientBackground:  LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.centerRight,
        colors: [
          Constants.PRIMARYCOLOR,
          Constants.PRIMARYCOLOR3,
        ],
      ),
      loaderColor: Colors.white,
      showLoader: true,
      loadingText: Text("CHATGA",style: TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),),
      navigator: Home(),
      durationInSeconds: 3,
    );
  }
}