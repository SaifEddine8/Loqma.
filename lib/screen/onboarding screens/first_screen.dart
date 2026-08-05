import 'package:flutter/material.dart';
import 'package:loqma/constant/constant_colors.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 30,
                children: [
                  Image.asset('assets/Logo.png',
                      width: 200,
                      height: 200,
                    ),
                   
                    Column(
                      children: [
                        Text("Share,Save and Reduce waste",style:TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: ConstantColors.primaryColor
                        )),
                        Text("A platform that connects those with surplus food with those who need it\nin order to preserve blessings and earn reward.",
                    style:TextStyle(
                      fontSize: 16,
                      color: ConstantColors.primaryColor
                    )),
                      ],
                    ),
                    
                    
                    
                    
            
              
                  
                ],
              ),
            );
   
  }
}