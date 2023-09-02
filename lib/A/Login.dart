
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/A/forget.dart';
import 'package:flutter_application_2/A/singup.dart';
import 'package:flutter_application_2/pdf_to_text.dart';
import 'package:flutter_application_2/servsec/firebase.dart';
import 'package:flutter_application_2/widget/costumer_butten.dart';
import 'package:flutter_application_2/widget/cusmer_textfield.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';



// ignore: camel_case_types
class Lock_screen extends StatefulWidget {
  const Lock_screen({super.key});

  @override
  State<Lock_screen> createState() => _Lock_screenState();
}

// ignore: camel_case_types
class _Lock_screenState extends State<Lock_screen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
   void _showSnackBar(BuildContext context, String message, Color backgroundColor, Duration duration) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(child: Text(message,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
        backgroundColor: backgroundColor,
        duration: duration,
      ),
    );
  }
    final FirebaseAuth _auth = FirebaseAuth.instance;
  void _clearTextField() {
    _emailController.clear();
    _passwordController.clear();

  }

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
        body: Container
        (height: MediaQuery.of(
          context).size.height,
      width: double.infinity,
      child: SingleChildScrollView(
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
                  child: Text("Welcome Back! Glad \nto see you again",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                costextfield(myController: _emailController,hintText: "Enter Your Email", isPassword: false,),
                costextfield(myController: _passwordController,hintText: "Enter Your Password", isPassword: true,),
                 Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const forger_pass()));
                      },
                      child: const Text("Forgot Password?",
                          style: TextStyle(
                            color: Color(0xff6A707C),
                            fontSize: 15,
                          )),
                    ),
                  ),
                ),
                  CustomizedButton(
                  buttonText: "Login",
                  buttonColor: Colors.teal,
                  textColor: Colors.white,
                  onPressed:()async{
                    try {
                    await FirebaseAuthService().login(
                        _emailController.text.trim(),
                        _passwordController.text.trim());
                        _clearTextField();
                    if (FirebaseAuth.instance.currentUser != null) {
                      if (!mounted) return;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Pdf_to_text()));
                    }else showDialog(context: context, builder: (context)=> AlertDialog(
                          backgroundColor: Colors.white,
       
                              title: Text(
                                        "Invalid Username or password. Please register again or make sure that username and password is correct",style: TextStyle(color: Colors.red),),
                                    actions: [
                                      ElevatedButton(
                                        child: Text("Register Now"),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Sing_up()));
                                        },
                                      )
                                    ]
                        ));
                        // ignore: use_build_context_synchronously
                      
       
                      }on FirebaseException catch(e){
                         _showSnackBar(context, "Sign up failed", Colors.red, Duration(seconds: 2));
      
                      }
                    // Navigator.push(context,  MaterialPageRoute(
                    //             builder: (context) => const Lock_screen()));
                                
                  },
                ),
                   Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 1,
                          width: MediaQuery.of(context).size.height * 0.15,
                          color: Colors.grey,
                        ),
                      ),
                      const Text("Or Login with"),
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
                            onPressed: ()async{

                              
                            }, ),
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
                  height:140,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(38, 50, 8, 8.0),
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
                                  builder: (_) => const Sing_up()));
                        },
                        child: const Text("  Regster Now",
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