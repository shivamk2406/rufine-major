import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class MLService extends StatefulWidget {
  const MLService({Key? key}) : super(key: key);

  @override
  State<MLService> createState() => _MLServiceState();
}

class _MLServiceState extends State<MLService> {
  bool loading = true;
  File? file;
  List<dynamic>? output;
  ImagePicker image = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadmodel().then((value) {
      setState(() {
        print("model loaded");
      });
    });
  }

  detectimage(File l) async {
    var prediction = await Tflite.runModelOnImage(
      path: l.path,
      numResults: 2,
      threshold: 0.6,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      output = prediction;
      loading = false;
    });
  }

  loadmodel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  getImageFromCamera() async {
    var img = await image.pickImage(source: ImageSource.camera);

    setState(() {
      file = File(img!.path);
      //print(img.path.toString());
    });
    detectimage(file!);
  }

  getImageFromGallery() async {
    var img = await image.pickImage(source: ImageSource.gallery);

    setState(() {
      file = File(img!.path);
      print(img.path.toString());
    });
    detectimage(file!);
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("ML Service"),
      ),
      body: Container(
        height: h,
        width: w,
        child: Column(
          children: [
            loading == true
                ? Container()
                : Container(
                    color: Colors.red,
                    child: Column(
                      children: [
                        Container(
                          height: 220,
                          padding: EdgeInsets.all(15),
                          child: Image.file(file!),
                        ),
                        //Text(
                        //(output![0]['label']).toString().substring(2),
                        //),
                        Text(
                          (output![0]['confidence']).toString(),
                          style: TextStyle(fontSize: 30),
                        ),
                        Text(output![0]['label'].toString().substring(2)),
                      ],
                    ),
                  ),
            SizedBox(
              height: 100,
            ),
            Stack(
              children: [
                Align(
                  alignment: Alignment(-0.5, 0.8),
                  child: FloatingActionButton(
                    elevation: 0.0,
                    child: new Icon(
                      Icons.image,
                    ),
                    backgroundColor: Colors.indigo[900],
                    onPressed: getImageFromGallery,
                  ),
                ),
                Align(
                  alignment: Alignment(0.5, 0.8),
                  child: FloatingActionButton(
                    elevation: 0.0,
                    child: new Icon(
                      Icons.camera,
                    ),
                    backgroundColor: Colors.indigo[900],
                    onPressed: getImageFromCamera,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
