import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

import 'main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CameraController cameraController;
  bool isWorking = false;
   CameraImage? imgCamera;
  String result = '';


  loadModel() async {
    await Tflite.loadModel(
  model: 'assets/images/ssd_mobilenet.tflite',
  labels: "assets/images/ssd_mobilenet.txt",
);
  }

  initCamera() {
    cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {
        cameraController.startImageStream((imageFromStream) async => await{
              if (!isWorking)
                {
                  isWorking = true,
                  imgCamera = imageFromStream,
                  runModel(),
                }
            });
      });
    });
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadModel();
  }


@override
  void dispose() async{
    // TODO: implement dispose
    super.dispose();
   await Tflite.close();
   cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Scaffold(
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/jar.jpg"))),
                    child: Column(children: [
                      Center(child: Container(height: 320,
                      width: 330,
                      child: Image.asset("assets/images/jarvis.jpg"),),),
                      Center(child: ElevatedButton(
                        onPressed: (){initCamera();},
                        child: Container(margin: EdgeInsets.only(top: 35),
                      
                      height: 270,
                      width: 360,
                      child: imgCamera == null ? Container(
                  height: 270,
                  width: 360,
                  child: Icon(Icons.photo_camera_front,color: Colors.blue, size: 40,),

                      ): AspectRatio(aspectRatio: cameraController.value.aspectRatio,
                      child: CameraPreview(cameraController),),
                      )),)
                    ],),
                    ),
      )),
    );
  }
}
