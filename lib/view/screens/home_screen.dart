import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

import '../../presenter/controller/home_controller.dart';
import '../widgets/color.dart';
import '../widgets/my_custom_text.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.put(HomeController());
  List<String> selectedLetters = [];
  bool isAlphabetMode = true;
  final FlutterTts flutterTts = FlutterTts();
  final List<String> letters = [
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
    'm',
    'n',
    'o',
    'p',
    'q',
    'r',
    's',
    't',
    'u',
    'v',
    'w',
    'x',
    'y',
    'z',
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: beigeColor,
        title: MyCustomTextWidget(text: 'Sign Language App', index: 1),
        actions: [
          IconButton(
            onPressed: () {
              homeController.showLogoutConfirmationDialog(context);
            },
            icon: const Icon(
              Icons.login_outlined,
              color: pinkColor,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Image.asset(
                "assets/images/home.png",
                width: 250,
                height: 250,
              ),
            ),
            Container(
              color: Color(0xffFFF4EE),
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: isAlphabetMode
                  ? Text(
                      selectedLetters.join(''),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: selectedLetters.map((letter) {
                        return Image.asset(
                          'assets/images/alphabet/$letter.png',
                          width: 50,
                          height: 50,
                        );
                      }).toList(),
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isAlphabetMode = !isAlphabetMode;
                      selectedLetters.clear();
                    });
                  },
                  child: Text(isAlphabetMode
                      ? 'Switch to Images'
                      : 'Switch to Alphabet'),
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: isAlphabetMode ? _speakSelectedWord : null,
                  child: Text('Speak'),
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  // style: ButtonStyle(backgroundColor:Colors.pinkAccent ),
                  onPressed: _deleteLastCharacter,
                  child: Icon(Icons.backspace),
                ),
              ],
            ),
            Container(
              height: 300,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                ),
                itemCount: letters.length,
                itemBuilder: (BuildContext context, int index) {
                  String letter = letters[index];
                  String imagePath;

                  if (letter == ' ') {
                    imagePath = 'assets/images/alphabet/space.png';
                  } else if (letter == '@') {
                    imagePath = 'assets/images/alphabet/at.png';
                  } else if (letter == '.') {
                    imagePath = 'assets/images/alphabet/dot.png';
                  } else if (RegExp(r'^[0-9]$').hasMatch(letter)) {
                    imagePath = 'assets/images/alphabet/${letter}.png';
                  } else {
                    imagePath = 'assets/images/alphabet/$letter.png';
                  }

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedLetters.add(letter);
                      });
                    },
                    child: isAlphabetMode
                        ? Image.asset(
                            imagePath,
                            width: 50,
                            height: 50,
                          )
                        : Padding(
                            padding: const EdgeInsets.only(left: 20.0, top: 20),
                            child: Text(
                              letter,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _speakSelectedWord() async {
    String selectedWord = selectedLetters.join('');
    if (selectedWord.isNotEmpty) {
      await flutterTts.setLanguage('en-US');
      await flutterTts.setPitch(1.0);
      await flutterTts.speak(selectedWord);
    }
  }

  void _deleteLastCharacter() {
    if (selectedLetters.isNotEmpty) {
      setState(() {
        selectedLetters.removeLast();
      });
    }
  }
}
