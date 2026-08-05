import 'package:flutter/material.dart';
import 'package:loqma/constant/constant_colors.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 30,
                children: [ 
                  
                  Image.asset('assets/onBoarding/second_screen.jpg',
                      width: 200,
                      height: 200,
                    ),
                  
                  Column(
                    children: [
                      Text("Share your surplus food",style:TextStyle(
                        color: ConstantColors.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        
                      
                      )), 
                      Text("Add any leftover food you wish to donate or at discounted prices",style:TextStyle(
                        color: ConstantColors.primaryColor,
                    fontSize: 16,
                    
                  )),
                    ],
                  ),
                 
                 
                  
                    
            
              
                  
                ],
              ),
            );
  }
}