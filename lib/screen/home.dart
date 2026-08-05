import 'package:flutter/material.dart';
import 'package:loqma/constant/constant_colors.dart';
import 'package:loqma/constant/constant_style.dart';
import 'package:loqma/custom_widget/item_card.dart';
import 'package:loqma/db/offers_db.dart';
import 'package:loqma/db/user_db.dart';
import 'package:loqma/models/offer_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

  
class _HomeScreen extends State<HomeScreen> {
  String categoryName='All';
  int selectedCategory=0;
  String search='';
  @override
void initState() {
  super.initState();
  offersNotifier.addListener(_onOffersChanged);
}

void _onOffersChanged() {
  setState(() {});
}
@override
void dispose() {
  offersNotifier.removeListener(_onOffersChanged);
  super.dispose();
}
  @override
  Widget build(BuildContext context) {



    offersNotifier.value=offersNotifier.value.where((item)=>item.expiryDate.isAfter(DateTime.now())).toList();

    List<Offer> filterProducts=offersNotifier.value.where((item){
    final filterFromCategory=categoryName=='All'|| item.category==categoryName;
    final filterFromSearch=item.title.toLowerCase().contains(search.toLowerCase());
    return filterFromCategory && filterFromSearch && item.expiryDate.isAfter(DateTime.now()) ;
    
    
    
    
    
    //  if(categoryName=='All')
    //           {
    //             return true;
    //           }
    //           return item.category==categoryName;
    
  }
  ).toList();
   return Scaffold(
          backgroundColor: ConstantColors.tertiaryColor,

    appBar: AppBar(
      backgroundColor: ConstantColors.tertiaryColor,
      title: Text('Loqma',style: ConstantStyle.screentitleStyle,),
      centerTitle: true,
      leading: Icon(Icons.notifications),
    ),
    body:Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        height: .infinity,
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30)
                ),
                fillColor: ConstantColors.tertiaryColor,
                filled: true,
                prefixIcon: Icon(Icons.search),
                hintText: 'Offer.....'
        
              ),
              onChanged: (value) => setState(() {
                search=value.toLowerCase();
              }),
            ),
            SizedBox(
              height: 70,
              child: ListView.builder(
                padding: EdgeInsets.all(16),
                itemExtent: 150,
              itemCount: categories.length,
              scrollDirection: .horizontal,
              itemBuilder:(context,index)=>
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ElevatedButton(
                  
                  onPressed: (){
                    setState(() {
                      selectedCategory=index;
                      categoryName=categories[index];
                    });
                
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedCategory==index?ConstantColors.primaryColor:ConstantColors.tertiaryColor
                ),
                 child:selectedCategory==index?Text(categories[index],style: TextStyle(color: ConstantColors.tertiaryColor),):Text(categories[index],style: ConstantStyle.listItem,)
                ,
                ),
              )
               ),
            ),
            
            Expanded(
              child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 10,mainAxisSpacing: 10,childAspectRatio: 0.75), 
              itemCount: filterProducts.length,
              itemBuilder:(context,index)=> ItemCard(offer: filterProducts[index],)
               ),
            )
            ],
        ),
      ),
    )
   );
    
  }
}