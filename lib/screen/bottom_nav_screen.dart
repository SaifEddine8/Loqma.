import 'package:flutter/material.dart';
import 'package:loqma/constant/constant_colors.dart';
import 'package:loqma/screen/add_food_screen.dart';
import 'package:loqma/screen/favorite_screen.dart';
import 'package:loqma/screen/home.dart';
import 'package:loqma/screen/profile_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}
Map<String,IconData> navItem={
    'Home':Icons.home,
    'Add Food':Icons.add,
    'Favorite':Icons.favorite,
    'Profile':Icons.person



    
};
List<Widget>screens=[
  HomeScreen(),
  AddFoodScreen(),
  FavoriteScreen(),
  ProfileScreen()
];
class _BottomNavScreenState extends State<BottomNavScreen> {
  int index=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: ConstantColors.tertiaryColor,


      body: IndexedStack(
        children: screens,
        
        index: index,
      
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: .fixed,
        // backgroundColor: ConstantColors.primaryColor,
        selectedItemColor: ConstantColors.primaryColor,
        // unselectedIcon,
        currentIndex: index,
        items:navItem.entries.map((item)=>
        BottomNavigationBarItem(
          // backgroundColor: Colors.white,
          

          icon:Icon(item.value),
          label:item.key
        )
        ).toList(),
        onTap: (value) => 
        setState(() {
          index=value;
        }),

      )
      );
      }
}