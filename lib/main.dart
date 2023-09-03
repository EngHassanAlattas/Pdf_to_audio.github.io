import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/firebase_options.dart';
import 'package:flutter_application_2/pdf_to_text.dart';
import 'package:flutter_application_2/speech_to_text.dart';
import 'package:flutter_application_2/welcome_screen.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:pdf_text/pdf_text.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'Utils/pick_document.dart';
// import 'package:text_to_speech/text_to_speech.dart';

Future<void>  main() async{
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: welcome_screen( ),));
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Widget> _pages = [Pdf_to_text(), Speech_to_text()];
  int _selectedPageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void setSelectedIndex(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedPageIndex,
            onTap: (index) {
              setSelectedIndex(index);
            },
            elevation: 0,
            selectedItemColor: Colors.red,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedFontSize: 0,
            unselectedItemColor: Color(0xFF686868),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.text_rotation_angleup),
                label: "speech to text",
              ),
            ],
          ),
          body: _pages[_selectedPageIndex],
        ));
  }
}
