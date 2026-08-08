import 'package:flutter/material.dart';
import 'package:loqma/provider/offer%20providers/cart_provider.dart';
import 'package:loqma/provider/update_user_provider.dart';
import 'package:loqma/screen/bottom_nav_screen.dart';
import 'package:loqma/screen/login_screen.dart';
import 'package:loqma/provider/offer%20providers/favorite_offer_provider.dart';
import 'package:loqma/provider/offer%20providers/offer%20status/available_status_provider.dart';
import 'package:loqma/provider/offer%20providers/offer%20status/delivered_status_provider.dart';
import 'package:loqma/provider/offer%20providers/offer%20status/expired_status_provider.dart';
import 'package:loqma/provider/offer%20providers/offer%20status/reserved_status_provider.dart';

import 'package:loqma/provider/user%20providers/user_type_provider.dart';
import 'package:loqma/provider/user%20providers/volunteer_type_provider.dart';
import 'package:loqma/screen/home.dart';
import 'package:loqma/screen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) =>AvailableStatusProvider() ,),
      ChangeNotifierProvider(create: (context) =>DeliveredStatusProvider() ,),
      ChangeNotifierProvider(create: (context) =>ExpiredStatusProvider() ,),
      ChangeNotifierProvider(create: (context) =>ReservedStatusProvider() ,),
      ChangeNotifierProvider(create: (context) =>UpdateUserProvider() ,),
      ChangeNotifierProvider(create: (context)=>CartProvider()),
      ChangeNotifierProvider(create: (context) =>UserTypeProvider() ,),
      ChangeNotifierProvider(create: (context) =>VolunteerTypeProvider() ,),
      ChangeNotifierProvider(create: (context)=>FavoriteOfferProvider())
    ],
    child: MaterialApp(
    
      home:SplashScreen()
    
    ),
  )
  );
}

