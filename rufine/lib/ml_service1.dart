import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class mlservice1 extends StatefulWidget {
  const mlservice1({Key? key}) : super(key: key);

  @override
  State<mlservice1> createState() => _mlservice1State();
}

class _mlservice1State extends State<mlservice1> {
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
      model: "assets/model_unquant1.tflite",
      labels: "assets/labels1.txt",
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
        backgroundColor: Color(0xff32B768),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Lung Segmentation", style: GoogleFonts.poppins()),
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
                  alignment: Alignment(-0.8, 0.8),
                  child: Column(children: [
                    FloatingActionButton(
                      heroTag: null,
                      elevation: 0.0,
                      child: new Icon(
                        Icons.image,
                      ),
                      backgroundColor: Color(0xff32B768),
                      onPressed: getImageFromGallery,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Select From Gallery",
                      style: GoogleFonts.encodeSansExpanded(),
                    )
                  ]),
                ),
                Align(
                  alignment: Alignment(0.8, 0.8),
                  child: Column(children: [
                    FloatingActionButton(
                      heroTag: null,
                      elevation: 0.0,
                      child: Container(
                        child: new Icon(
                          Icons.camera,
                        ),
                      ),
                      backgroundColor: Color(0xff32B768),
                      onPressed: getImageFromCamera,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Pick From Camera",
                      style: GoogleFonts.encodeSansSemiCondensed(),
                    )
                  ]),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
