import 'package:flutter/material.dart';
import 'package:flutter_application_2/Utils/pick_document.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:pdf_text/pdf_text.dart';
import 'package:speech_to_text/speech_to_text.dart';

class Pdf_to_text extends StatefulWidget {
  const Pdf_to_text({Key? key}) : super(key: key);

  @override
  State<Pdf_to_text> createState() => _Pdf_to_textState();
}

class _Pdf_to_textState extends State<Pdf_to_text> {
  final String defaultLanguage = 'en-US';

  String text = '';
  double volume = 1; // Range: 0-1
  double rate = 0.5; // Range: 0-2
  double pitch = 1.0; // Range: 0-2

  String? language;
  String? languageCode;
  List<String> languages = <String>[];
  List<String> languageCodes = <String>[];
  String? voice;
  final SpeechToText speech = SpeechToText();
  // TextEditingController textEditingController = TextEditingController();

  TextEditingController controller = TextEditingController();
  TextEditingController book_Pages = TextEditingController();
  int current_page = 1;

  FlutterTts flutterTts = FlutterTts();

  void stop() async {
    await flutterTts.stop();
    // await flutterTts.pause();
  }

  void pause() async {
    await flutterTts.pause();
  }

  void speak({String? text, required String voice_type}) async {
    await flutterTts.setLanguage("en-US");

    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);

    try {
      print("ssssssssssssssssssssssssssssssssssss vociss**");
      print(await flutterTts.getVoices);

      //  await   flutterTts.setVoice({"locale": "kn-IN", "name": "kn-in-x-knm-network"});
      //  flutterTts.setVoice({"locale": "ur-PK", "name": "ur-PK-language"});
      //  flutterTts.setVoice({"name": "en-gb-x-gba-network", "locale": "en-GB"});

      flutterTts.setVoice(voice_type == "Male"
          ? {"name": "en-au-x-aud-network", "locale": "en-AU"}
          : {"name": "en-gb-x-gba-network", "locale": "en-GB"});

      await flutterTts.speak(text!);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  String dropdownvalue = 'Male';

  // List of items in our dropdown menu
  var items = [
    'Male',
    'Female',
  ];
  late PDFDoc doc;
  bool is_doc_initlied = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.teal,
        onPressed: () {
          pickDocument().then((value) async {
            debugPrint(value);
            if (value != '') {
              doc = await PDFDoc.fromPath(value);

              final text = await doc.text;
              PDFPage page = doc.pageAt(1);
              String pageText = await page.text;
              is_doc_initlied = true;
              controller.text = pageText;
              setState(() {
                book_Pages.text = doc.length.toString();
              });
            }
          });
        },
        label: const Text("pdf"),
      ),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Pdf to Audio '),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  child: TextField(
                    controller: controller,
                    maxLines: 30,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter some text here...'),
                    onChanged: (String newText) {
                      setState(() {
                        text = newText;
                      });
                    },
                  ),
                ),
                // Text("pages " + book_Pages.text),
                is_doc_initlied
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.teal),
                              ),
                              onPressed: () async {
                                if (doc.length > 0 && current_page > 1) {
                                  current_page--;
                                  PDFPage page = doc.pageAt(current_page);
                                  String pageText = await page.text;
                                  setState(() {
                                    controller.text = pageText;
                                  });
                                }
                              },
                              child: Text("Prev")),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            current_page.toString() + " /" + book_Pages.text,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.teal),
                              ),
                              onPressed: () async {
                                if (doc.length > 0 &&
                                    current_page < doc.length) {
                                  current_page++;
                                  PDFPage page = doc.pageAt(current_page);
                                  String pageText = await page.text;
                                  setState(() {
                                    controller.text = pageText;
                                  });
                                }
                              },
                              child: Text("Next")),
                        ],
                      )
                    : Text(""),
                Row(
                  children: <Widget>[
                    const Text('Volume'),
                    Expanded(
                      child: Slider(
                        thumbColor: Colors.teal,
                        activeColor: Colors.teal,
                        value: volume,
                        min: 0,
                        max: 1,
                        label: volume.round().toString(),
                        onChanged: (double value) {
                          setState(() {
                            volume = value;
                          });
                        },
                      ),
                    ),
                    Text('(${volume.toStringAsFixed(2)})'),
                  ],
                ),
                Row(
                  children: <Widget>[
                    const Text('Speed'),
                    Expanded(
                      child: Slider(
                        thumbColor: Colors.teal,
                        activeColor: Colors.teal,
                        value: rate,
                        min: 0,
                        max: 2,
                        label: rate.round().toString(),
                        onChanged: (double value) {
                          setState(() {
                            rate = value;
                          });
                        },
                      ),
                    ),
                    Text('(${rate.toStringAsFixed(2)})'),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    const Text('Voice'),
                    const SizedBox(
                      width: 20,
                    ),
                    DropdownButton(
                      // Initial Value
                      value: dropdownvalue,

                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),

                      // Array list of items
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(right: 10),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.teal),
                          ),
                          child: const Text('Rstart'),
                          onPressed: () {
                            stop();
                            controller.clear();
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(right: 10),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.teal),
                          ),
                          child: const Text('Pause'),
                          onPressed: () {
                            pause();
                          },
                        ),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.teal),
                        ),
                        child: const Text('Play'),
                        onPressed: () {
                          if (controller.text.isNotEmpty) {
                            speak(
                                text: controller.text.trim(),
                                voice_type: dropdownvalue);
                          }
                        },
                      ),
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Container(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.teal),
                        ),
                        child: const Text('Record'),
                        onPressed: () async {
                          var isAvailibe = await speech.initialize();
                          if (isAvailibe) {
                            print(
                                "goddddddddddt666666666666666666666ddddddddddddddddddddddddddd**********************");
                            speech.listen(
                              onResult: (result) {
                                controller.text = result.recognizedWords;
                              },
                            );
                          } else {
                            print(
                                "ddddddddddddddddddddddddddd**********************");
                            print(isAvailibe);
                          }
                        },
                      ),
                    ))
                  ],
                ),
                SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
