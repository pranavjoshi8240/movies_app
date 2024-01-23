import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:movies_app/screens/home_screen.dart';
import 'package:movies_app/screens/signIn.dart';

import '../main.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //FirstLoginTokenController getFirstToken = Get.find<FirstLoginTokenController>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(seconds: 2),(){
      goToNext();
    });
  }

  Future<void> goToNext() async {
    bool? token =  sharedPreferences.getBool("isLoggedIn");
    if ( token == true ) {
      Get.off(()=> const HomeScreen());
    }else{
      Get.off(()=>const SignInScreen());
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Container(
          width: double.infinity,
          height: double.infinity,
         child: FlutterLogo(),
        ),
      ),
    );
  }
}
