import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import '../../presenter/controller/home_controller.dart';
import '../widgets/my_custom_text.dart';
import '../widgets/color.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  List<String> selectedLetters = [];
  final HomeController homeController = Get.put(HomeController());
  final List<String> alphabetLetters = [
    'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j',
    'k', 'l', 'm', 'n', 'o',
    'p', 'q', 'r', 's', 't',
    'u', 'v', 'w', 'x', 'y', 'z', ' ', '@', '.', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'
  ];
  FlutterTts flutterTts = FlutterTts();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: beigeColor,
        title:  MyCustomTextWidget(text:'Sign Language App' ,index: 1 ),
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
      body: Column(
        children: [
          Container(
            color: Color(0xffFFF4EE),
            height: 250, // Set the initial height
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(Icons.volume_up),
                          onPressed: () {
                            _speakSelectedWord();
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.backspace),
                          onPressed: () {
                            _deleteLastCharacter();
                          },
                        ),
                      ],
                    ),
                    Text(
                      selectedLetters.join(''),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 10,
              ),
              itemCount: alphabetLetters.length,
              itemBuilder: (BuildContext context, int index) {
                String letter = alphabetLetters[index];
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
                  imagePath = 'assets/images/alphabet/${letter}.png';
                }

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedLetters.add(letter);
                    });
                  },
                  child: Image.asset(imagePath),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  void _speakSelectedWord() async {
    String selectedWord = selectedLetters.join('');
    if (selectedWord.isNotEmpty) {
      await flutterTts.setLanguage('en-US'); // Set the desired language
      await flutterTts.setPitch(1.0); // Set pitch (1.0 is default)
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
