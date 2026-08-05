import 'package:flutter/material.dart';
import 'package:loqma/provider/update_user_provider.dart';
import 'package:loqma/screen/bottom_nav_screen.dart';
import 'package:loqma/constant/constant_colors.dart';
import 'package:loqma/constant/constant_style.dart';
import 'package:loqma/custom_widget/text_from_field_class.dart';
import 'package:loqma/db/user_db.dart';
import 'package:loqma/models/user_model.dart';
import 'package:loqma/screen/home.dart';
import 'package:loqma/utils.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool hasAccount=true;
  String selectedType='Recipient';
  TextEditingController usernameController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController emailController=TextEditingController();
    TextEditingController phoneController=TextEditingController();

  bool passScure=true;

  final _formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      
      ),
      body:Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: SizedBox(
            width: .infinity,
            child: Column(
              spacing: 20,
              children: [
                Lottie.network(hasAccount?'https://lottie.host/a84f6b75-d1b8-4189-bf3c-0445ffd99c6b/wAF8ZfG3fn.json':'https://lottie.host/e5e81888-f44b-407e-9f75-7a021b2a1fc0/JMUgYAHkES.json',
                width: 200,height: 200),
                
                
                Form(
                  key: _formkey,
                  child: Column(
                    spacing: 20,
                    children: [
                      if(!hasAccount)
                      TextFromFieldClass(hint:'Username',lable:'name',controller: usernameController,
                      validator: (value){
                        if(Utils.checkUsername(value!))
                        {
                          return null;
                        }
                        else 
                        {
                          return 'Username incorrect';
                        }
                      }
                      ,
                      ),
                      TextFromFieldClass(hint: 'username@domain.com',lable: 'Email',preIcon: Icons.email,controller:emailController,
                validator: (value)
                {if(Utils.checkEmail(value!))
                {
                  return null;
                }
                else
                {return 'Email incorrect';}
                }
                ),
                TextFromFieldClass(hint: '*********',lable: 'Password',preIcon: Icons.password,
                sufIcon: InkWell(
                  onTap: ()=>setState(() {
                    passScure=!passScure;
                  }),
                  child: passScure?Icon(Icons.visibility):Icon(Icons.visibility_off)),
                  controller: passwordController,obScure: passScure,
                  validator: (value) {
                    if(Utils.checkPassword(value!))
                    {
                      return null;
                    }
                    else
                    {return 'Password incorrect'; }
                  },
                  ),
                  if(!hasAccount)
                  
                    TextFromFieldClass(hint: '079*******', lable: 'phone', controller:phoneController , validator: (value){
                    if(Utils.checkPhone(value!))
                    {
                      return null;
                    }
                    else
                    {
                      return 'phone number incorrect';
                    }

                  }),
                  
                  
                  

                  
                 
                    ],
                  ),
                ),
               


                
                
                ElevatedButton(
                  onPressed: (){
                    if(hasAccount)
                      
                    
                     { if(_formkey.currentState!.validate())
                    {
                     
                      currentUser=users.firstWhere((user)=>user.email==emailController.text&&user.password==passwordController.text);
                      context.read<UpdateUserProvider>().setUser(currentUser!);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavScreen()));

                    }}
                    
                    else
                    
                      {
                        if(_formkey.currentState!.validate())
                    {
                      users.add(
                      UserModel(email: emailController.text, password: passwordController.text, fullName: usernameController.text,phone: phoneController.text));
                       }}
                      

                  }, 
                style:ElevatedButton.styleFrom(
                  backgroundColor: ConstantColors.primaryColor,
                  minimumSize: Size(double.infinity,48)
                ),
                child: Text(hasAccount?'Login':'Register',style: TextStyle(
                  color: Colors.white
                ),),
                ),
                Row(
                  mainAxisAlignment: .center,
                  children: [
                    
                    Text(hasAccount?'Are you want to create new account? ':'Are you have an account? '),
                    TextButton(onPressed: (){
                      setState(() {
                        hasAccount=!hasAccount;
                        passwordController.clear();
                        emailController.clear();
                        usernameController.clear();
                        
                      });
                    }, child: Text(hasAccount?'register':'login',style: ConstantStyle.textButtonStyle,)),
                    ],
                )
               
          
              ],
            ),
          ),
        ),
      )
    );
  }
 




}