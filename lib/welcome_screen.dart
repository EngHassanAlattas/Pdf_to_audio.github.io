// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';
import 'package:flutter_application_2/A/Login.dart';
import 'package:flutter_application_2/A/singup.dart';
import 'package:flutter_application_2/widget/costumer_butten.dart';


// ignore: camel_case_types
class welcome_screen extends StatelessWidget {
  const welcome_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: 
      Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        
        
         height: MediaQuery.of(context).size.height,
        width: double.infinity ,
         decoration: BoxDecoration(
            image: DecorationImage(
            image: AssetImage
            ("asset/2.png"),fit: BoxFit.scaleDown )),
       
            child: Column(
               
              mainAxisAlignment: MainAxisAlignment.end,
              children: [ 
                
              
              CustomizedButton(
                buttonText: "Login",
                buttonColor: Colors.teal,
                textColor: Colors.white,
                onPressed:(){
                   Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const Lock_screen()));
                },
              ),
              CustomizedButton(
                buttonText: "Register",
                buttonColor: Colors.teal,
                textColor: Colors.white,
                onPressed:(){
                   Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const Sing_up()));
                },
              ),
              const SizedBox(height: 20),
             const Padding(
                padding:  EdgeInsets.all(10.0),
                child: Text(
                  "Continue as a Guest",
                  style: TextStyle(color: Color.fromARGB(255, 213, 16, 98), fontSize: 15),
                ),)
              ]
            ),
          ),
    ),

        );
  }
}