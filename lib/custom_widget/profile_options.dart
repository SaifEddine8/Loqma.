import 'package:flutter/material.dart';
import 'package:loqma/constant/constant_colors.dart';
import 'package:loqma/constant/constant_style.dart';

class ProfileOptions extends StatelessWidget {
  IconData preIcon;
  
  String optionTitle;
  Function(BuildContext) onTap;
   ProfileOptions({super.key,required this.optionTitle,required this.preIcon,required this.onTap});

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return InkWell(
      onTap: ()=>onTap(context),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        elevation: 10,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
      
          height: height/8,
          width: .infinity,
          
          child: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Row(
                spacing: 10,
                children: [
                  Icon(preIcon,color: ConstantColors.secondaryColor),
                  Text(optionTitle,style: ConstantStyle.titeStyle.copyWith(fontWeight: .w600),),
                ],
              ),
              SizedBox(width: width/4,),
              
              Icon(Icons.arrow_forward_ios_sharp,)
            ],
          ),
        ),
      ),
    );
  }
}