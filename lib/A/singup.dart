
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/A/Login.dart';
import 'package:flutter_application_2/widget/costumer_butten.dart';
import 'package:flutter_application_2/widget/cusmer_textfield.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


// ignore: camel_case_types
class Sing_up extends StatefulWidget {
  const Sing_up({super.key});

  @override
  State<Sing_up> createState() => _Sing_upState();
}

// ignore: camel_case_types
class _Sing_upState extends State<Sing_up> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _confirmPasswordController =
      TextEditingController();

    final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

    void _showSnackBar(BuildContext context, String message, Color backgroundColor, Duration duration) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(child: Text(message,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
        backgroundColor: backgroundColor,
        duration: duration,
      ),
    );
  }
 Future<void> _signUp() async {
    try {
      final String email = _emailController.text;
      final String password = _passwordController.text;
      final String confirmPassword = _confirmPasswordController.text;

      if (password != confirmPassword) {
         _showSnackBar(context, "Passwords do not match", Colors.red, Duration(seconds: 2));
        return;
      }

      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

     _showSnackBar(context, "Sign up successful!", Colors.green, Duration(seconds: 1));
    } catch (e) {
      _showSnackBar(context, "Sign up failed", Colors.red, Duration(seconds: 2));
    }
  }
  

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox
          (height: MediaQuery.of(
            context).size.height,
              width: double.infinity,
              child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height:50 ,
                  width: 50,
                  decoration: BoxDecoration(border: Border.all(width: 1,color: Colors.black ),
                  borderRadius:    BorderRadius.circular(10),
                  
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_outlined),
                  onPressed: (){Navigator.pop(context);}, ),
                  ),
              ),
            ) ,const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text("Hello!  Register to get \nStarted",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              
                costextfield(myController: _emailController ,hintText: "Email", isPassword: false,),
                costextfield(myController: _passwordController,hintText: "Password", isPassword: false,),
                costextfield(myController: _confirmPasswordController,hintText: "Confirm Password", isPassword: true,),
                
                  CustomizedButton(
                  buttonText: "Register",
                  buttonColor: Colors.teal,
                  textColor: Colors.white,
                  onPressed:()async{

                    try{
                    _signUp();
                     
                     

                    } 
                    
                    catch(e){
                       _showSnackBar(context, "Sign up failed", Colors.red, Duration(seconds: 2));
                    }
                    // Navigator.push(context,  MaterialPageRoute(
                    //             builder: (context) => const Lock_screen()));
                                
                  },
                ),
                   Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 1,
                          width: MediaQuery.of(context).size.height * 0.17,
                          color: Colors.grey,
                        ),
                      ),
                      const Text("Register with"),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 1,
                          width: MediaQuery.of(context).size.height * 0.16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [  
                
                Container(height:50,
                      width: 100,
                        decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1,color: Colors.black)),
                          
                          child: IconButton(
                            icon: Icon( FontAwesomeIcons.facebookF ,color: Colors.blue,),
                            onPressed: (){}, ),
                      ),
                        Container(height:50,
                      width: 100,
                        decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1,color: Colors.black)),
                          
                          child: IconButton(
                            icon: Icon(  FontAwesomeIcons.google ,color: Colors.black,),
                            onPressed: (){}, ),
                      ),
                        Container(height:50,
                      width: 100,
                        decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1,color: Colors.black)),
                          
                          child: IconButton(
                            icon: Icon( FontAwesomeIcons.apple ,color: Colors.black,),
                            onPressed: (){}, ),
                      ),
                        
                      
                      
                      
                      ]
                      
                      
                      ,),
                      const SizedBox(
                  height:60,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(36, 60, 8, 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?",
                          style: TextStyle(
                            color: Color(0xff1E232C),
                            fontSize: 15,
                          )),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const Lock_screen()));
                        },
                        child: const Text("  Login Now",
                            style: TextStyle(
                              color: Color(0xff35C2C1),
                              fontSize: 15,
                            )),
                      ),
                    ],
                  ),)
            ],
            
            ),
            
              ),
        ),),
    );
  }
}