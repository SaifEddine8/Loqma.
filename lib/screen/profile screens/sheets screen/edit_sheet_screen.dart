import 'package:flutter/material.dart';
import 'package:loqma/constant/constant_colors.dart';
import 'package:loqma/constant/constant_style.dart';
import 'package:loqma/custom_widget/location_picker_screen.dart';
import 'package:loqma/custom_widget/text_from_field_class.dart';
import 'package:loqma/db/user_db.dart';
import 'package:loqma/models/address_model.dart';
import 'package:loqma/models/user_model.dart';
import 'package:loqma/provider/update_user_provider.dart';
import 'package:loqma/utils.dart';
import 'package:provider/provider.dart';

class EditSheetScreen extends StatefulWidget {
  const EditSheetScreen({super.key});

  @override
  State<EditSheetScreen> createState() => _EditSheetScreenState();
}

class _EditSheetScreenState extends State<EditSheetScreen> {
  final _formkey=GlobalKey<FormState>();
    TextEditingController fullNameController=TextEditingController();
    TextEditingController emailController=TextEditingController();
    TextEditingController phoneController=TextEditingController();
    TextEditingController addressController=TextEditingController();
    AddressModel? selectedAddress;
  @override
  Widget build(BuildContext context) {
    final userProvider=context.read<UpdateUserProvider>();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 20,
            children: [
            Text('Edit Profile',style: ConstantStyle.titeStyle,),
            Form(
              key: _formkey,
              child: SizedBox(
                height: MediaQuery.of(context).size.height/2,
                child: Column(
                  mainAxisAlignment: .spaceAround,
                  children: [
                    TextFromFieldClass(controller: fullNameController,validator: (value) {
                      if(value==null||value.isEmpty)
                      {
                        return null;
                      }
                      
                        return Utils.checkUsername(value)?null:'invalid username';
                      
                      } 
                      ,hint: currentUser!.fullName,),
                    TextFromFieldClass(controller: emailController,validator: (value) {
                      if(value==null||value.isEmpty)
                      {
                        return null;
                      }
                      
                        return Utils.checkEmail(value)?null:'invalid email';
                      
                      }
                      ,hint: currentUser!.email,sufIcon: Icon(Icons.email),),
                    TextFromFieldClass(controller: phoneController,validator: (value) {
                      if(value==null||value.isEmpty)
                      {
                        return null;
                      }
                      
                        return Utils.checkPhone(value)?null:'invalid phone';
                      
                      }
                       ,hint: currentUser!.phone,),
                    TextFormField(
                      controller: addressController,
                      readOnly: true,
                      onTap: ()async{
                        final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LocationPickerScreen(),
              
                        ),
                        
                      );
                      if(result != null)  {selectedAddress=result;addressController.text=selectedAddress!.address;}
                
                
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        
                          hintText: selectedAddress==null? currentUser!.location!.address:addressController.text,
                          prefixIcon: Icon(Icons.location_on),
                          suffixIcon: Icon(Icons.arrow_drop_down)
                      ),
                
                      ),
                  ],
                ),

              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if(_formkey.currentState!.validate())
                  {
                    // Perform save action here
                    UserModel updatedUser = UserModel(
                      
                      fullName: fullNameController.text.isNotEmpty ? fullNameController.text : userProvider.currentUser!.fullName,
                      password: userProvider.currentUser!.password, // Keep the existing password
                      email: emailController.text.isNotEmpty ? emailController.text : userProvider.currentUser!.email,
                      phone: phoneController.text.isNotEmpty ? phoneController.text : userProvider.currentUser!.phone,
                      location: selectedAddress != null ? AddressModel(address: selectedAddress!.address,latitude: selectedAddress!.latitude,longitude: selectedAddress!.longitude) : userProvider.currentUser!.location,
                      profileImage: userProvider.currentUser!.profileImage, // Keep the existing profile image
                    );
                    int userIndex = users.indexWhere((user) => user.id == userProvider.currentUser!.id);
                    userProvider.updateUser(updatedUser);
                    users[userIndex] = userProvider.currentUser!;
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Profile updated successfully')),
                    );
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  
                  backgroundColor: ConstantColors.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  
                  ),
                                ),
                child: Text('Save',style: ConstantStyle.titeStyle.copyWith(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

