import 'package:flutter/material.dart';
import 'package:loqma/constant/constant_colors.dart';
import 'package:loqma/constant/constant_style.dart';
import 'package:loqma/custom_widget/profile_options.dart';
import 'package:loqma/db/profile_options_db.dart';
import 'package:loqma/db/user_db.dart';
import 'package:loqma/provider/update_user_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
        final user=context.watch<UpdateUserProvider>().currentUser;
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstantColors.tertiaryColor,
        title: Text('My Profile',style: ConstantStyle.screentitleStyle,),
        centerTitle: true,
        
      ),
      backgroundColor: ConstantColors.tertiaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SafeArea(
          child: SizedBox(
            height: height,
            width: width,
            child: Column(
              mainAxisAlignment: .spaceAround,
              children: [
                
                Column(
                  children: [
                    CircleAvatar(
                      radius: MediaQuery.of(context).size.height/18,
                      backgroundImage: user!.profileImage != null?
                      FileImage(user.profileImage!)
                      :null,
                      child: user.profileImage == null
                      ?Icon(Icons.person)
                      :null,
                    ),
                    Text(user.fullName,style: ConstantStyle.titeStyle,),
                Text(user.location?.address??'Unkown'),
                  ],
                ),
                
                
                Column(
                  children: 
                    options.map((option)=>
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ProfileOptions(
                    optionTitle: option.title,
                    preIcon: option.icon,
                    onTap: option.onTap,
                    ),
                )).toList()
                  ,
                )
                
              ],
            ),
          ),
        ),
      ),
      
    );
  }
}