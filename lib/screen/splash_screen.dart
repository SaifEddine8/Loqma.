import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loqma/constant/constant_colors.dart';
import 'package:loqma/screen/onboarding_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState()
  {
    super.initState();
Timer(
      Duration(seconds:3),()=>
      Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>OnboardingScreen())
      )

    );  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstantColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('assets/Logo.png',
                width: 200,
                height: 200,
              ),
             CircularProgressIndicator(
               color: ConstantColors.secondaryColor,
             )
              
            ],
          ),
        ),
      ),
    );
  }
}