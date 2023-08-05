import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign Language App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Interpreter? interpreter;
  ImagePicker picker = ImagePicker();
  String prediction = '';
  List<String> labels = [];

  @override
  void initState() {
    super.initState();
    loadModel();
    loadLabels();
  }

  // Load the TFLite model
  Future<void> loadModel() async {
    try {
      String modelPath = 'assets/sign_language_model.tflite';
      interpreter = await Interpreter.fromAsset(modelPath);
      print('Model loaded successfully');
    } catch (e) {
      print('Error loading model: $e');
    }
  }

  // Load the labels from the labels.txt file in the assets
  Future<void> loadLabels() async {
    try {
      String labelsText = await rootBundle.loadString('assets/labels.txt');
      labels = labelsText.trim().split('\n');
      print('Labels loaded successfully');
    } catch (e) {
      print('Error loading labels: $e');
    }
  }

  // Run inference on the image
  Future<void> runInference(File imageFile) async {
    if (interpreter == null) {
      print('Model is not loaded yet.');
      return;
    }

    try {
      var imageBytes = await imageFile.readAsBytes();
      img.Image image = img.decodeImage(imageBytes)!;

      // Resize the image to 64x64
      image = img.copyResize(image, width: 64, height: 64);

      var input = imageToByteListFloat32(
          image, 64, 255.0); // Convert image to model input format

      // Perform inference
      var output = Float32List(
          interpreter!.getOutputTensor(0).shape.reduce((a, b) => a * b));
      interpreter!.run(input, output);

      // Process the output and get the prediction
      int maxIndex = output.indexOf(output.reduce((a, b) => a > b ? a : b));
      String result = labels[maxIndex];
      setState(() {
        prediction = result;
      });
    } catch (e) {
      print('Error running inference: $e');
    }
  }

  // Image picker function
  Future<void> getImageAndRunInference() async {
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      runInference(File(pickedImage.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Language App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: getImageAndRunInference,
              child: Text('Select Image'),
            ),
            SizedBox(height: 20),
            Text(
              prediction.isEmpty
                  ? 'Select an image to make a prediction'
                  : 'Prediction: $prediction',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

// Image processing helper function
Uint8List imageToByteListFloat32(
    img.Image image, int inputSize, double normalization) {
  var convertedBytes = Uint8List(1 * inputSize * inputSize);
  var buffer = Float32List.view(convertedBytes.buffer);
  var pixelIndex = 0;
  for (var i = 0; i < inputSize; i++) {
    for (var j = 0; j < inputSize; j++) {
      var pixel = image.getPixel(j, i);
      var grayscaleValue = img.getLuminance(pixel).round();
      buffer[pixelIndex] = grayscaleValue / normalization;
      pixelIndex++;
    }
  }
  return convertedBytes;
}
