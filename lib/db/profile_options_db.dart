import 'package:flutter/material.dart';
import 'package:loqma/db/user_db.dart';
import 'package:loqma/models/profile_option_model.dart';
import 'package:loqma/models/user_model.dart';
import 'package:loqma/screen/profile%20screens/my_offers_screen.dart';
import 'package:loqma/screen/profile%20screens/sheets%20screen/change_password_sheet_screen.dart';
import 'package:loqma/screen/login_screen.dart';
import 'package:loqma/screen/profile%20screens/sheets%20screen/edit_sheet_screen.dart';

List<ProfileOptionModel>options=[
  
  ProfileOptionModel(
      title: 'Edit Profile',
      icon: Icons.edit_outlined,
      onTap: (context) {
        showBottomSheet(
          context: context,

          builder: (context) {
          return EditSheetScreen();  
          },
          );
      },
    ),

    ProfileOptionModel(
      title: 'My Offers',
      icon: Icons.fastfood_outlined,
      onTap: (context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyOffersScreen(),
          ),
        );
      },
    ),

    ProfileOptionModel(
      title: 'Change Password',
      icon: Icons.lock,
      onTap: (context) {
        showBottomSheet(
          context: context,

          builder: (context) {
          return ChangePasswordSheetScreen();  
          },
          );
      },

        
      
    ),

    ProfileOptionModel(
    title: 'Logout',
    icon: Icons.logout,
    onTap: (context) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) =>  LoginScreen(),
        ),
        (route) => false,

      );
      currentUser=null;
    },
  ),
];