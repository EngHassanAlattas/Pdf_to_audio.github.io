
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/A/Login.dart';
import 'package:flutter_application_2/widget/costumer_butten.dart';
import 'package:flutter_application_2/widget/cusmer_textfield.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';


// ignore: camel_case_types
class forger_pass extends StatefulWidget {
  
  const forger_pass({super.key});

  @override
  State<forger_pass> createState() => _forger_passState();
}

// ignore: camel_case_types
class _forger_passState extends State<forger_pass> {
    void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
   Future<void> _resetPassword() async {
    try {
      await _auth.sendPasswordResetEmail(email: _emailController.text);
      _showSnackBar("Password reset email sent!");
    } catch (e) {
      _showSnackBar("Password reset failed: $e");
    }
  }
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
        body: Container
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
                padding: EdgeInsets.only(right: 120),
                child: Text("Forget Password ? ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("Don't worry! It occurs. Please enter the email address linked with your account",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                     
                    )),
              ),
              costextfield(myController: _emailController,hintText: "Enter Your Email", isPassword: false,),
             
              
                CustomizedButton(
                buttonText: "Send",
                buttonColor: Colors.teal,
                textColor: Colors.white,
                onPressed:(){
                   _resetPassword();
                  Navigator.push(context,  MaterialPageRoute(
                              builder: (context) => const Lock_screen()));
                              
                },
              ),
                
          
                    
          ],
          
          ),
          
      ),),
    );
  }
}