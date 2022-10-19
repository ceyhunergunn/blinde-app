import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:tflite/tflite.dart';
import 'main.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String header = "BLINDE";

  CameraImage? cameraImage;
  CameraController? cameraController;
  String output = '';
  FlutterTts tts = FlutterTts();


  @override
  void initState() {
    super.initState();
    loadModel();
    loadCamera();
  }

  loadCamera() {
    cameraController = CameraController(cameras![0], ResolutionPreset.medium);
    cameraController!.initialize().then((value) {
      if (!mounted) {
        return;
      } else {
        setState(() {
          cameraController!.startImageStream((imageStream) {
            cameraImage = imageStream;

            Future.delayed(const Duration(seconds: 1,milliseconds: 500), () {
              setState(() async{
                await runModel();
              });
            });
          });
        });
      }
    });
  }

  runModel() async {
    if (cameraImage != null) {
      var predictions = await Tflite.runModelOnFrame(
          bytesList: cameraImage!.planes.map((plane) {
            return plane.bytes;
          }).toList(),
          imageHeight: cameraImage!.height,
          imageWidth: cameraImage!.width,
          imageMean: 127.5,
          imageStd: 127.5,
          rotation: 90,
          numResults: 2,
          threshold: 0.8,
          asynch: true);
      predictions!.forEach((element) {
        setState(() {
          output = element['label'];

          loadSpeech(output);
        });
      });
    }
  }


  var modeltflite = "assets/model.tflite";

  loadModel() async {
    await Tflite.loadModel(
        model: modeltflite, labels: "assets/labels.txt");
  }

  loadSpeech(String textspeech) async{

    await tts.awaitSpeakCompletion(true);
    await tts.awaitSynthCompletion(true);

    await tts.setLanguage("tr-TR");
    await tts.setSpeechRate(1.0);
    await tts.setVolume(1.0);
    await tts.setPitch(1.0);
    await tts.speak("Önünüzde "+ textspeech + " var");
  }


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
