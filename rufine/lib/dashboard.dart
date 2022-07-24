import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rufine/diabetes.dart';
import 'package:rufine/drawer.dart';
import 'package:http/http.dart' as http;
import 'package:rufine/heartdisease.dart';
import 'package:rufine/ml_service1.dart';
import 'package:rufine/symtombased.dart';

import 'auth_service.dart';
import 'ml_service.dart';
import 'onboarding.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: MyAppDrawer(
          username: FirebaseAuth.instance.currentUser!.displayName.toString(),
        ),
        body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            setUserNameWidget(),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Diabetes()));
                    },
                    child: homeScreenItem(
                        "assets/images/2.svg", 400, 400, "Diabetes Prediction"),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => MLService()));
                    },
                    child: homeScreenItem("assets/images/2.svg", 400, 400,
                        "Skin Cancer Prediction"),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SymptomBased()));
                },
                child: homeScreenItem("assets/images/2.svg", 400, 400,
                    "Symptom Based Prediction"),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HeartDisease()));
                },
                child: homeScreenItem("assets/images/2.svg", 400, 400,
                    "Heart Disease \n Prediction"),
              ),
            ]),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => mlservice1()));
              },
              child: homeScreenItem("assets/images/2.svg", 400, 400,
                  "Lung Segmentation \n Prediction"),
            ),
            ElevatedButton(
                onPressed: () async {
                  final authService =
                      Provider.of<AuthService>(context, listen: false);
                  await authService.signOut();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => Onboarding()));
                },
                child: Text("Sign Out")),
          ]),
        ),
      ),
    );
  }
}

Future<http.Response> GetResponse(
  Map<String, dynamic> jsonData,
) async {
  String url = 'https://diabetespredicxtion.herokuapp.com/predict';
  http.Response response = await http.get(Uri.parse(url));
  final encodedJson = json.encode(jsonData);
  print(encodedJson);

  var responseBody = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"}, body: encodedJson);
  return responseBody;
}

Future<http.Response> GetResponse1(
  Map<String, dynamic> jsonData,
) async {
  String url = 'https://diabetespredicxtion.herokuapp.com/predict2';
  http.Response response = await http.get(Uri.parse(url));
  final encodedJson = json.encode(jsonData);
  print(encodedJson);

  var responseBody = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"}, body: encodedJson);
  return responseBody;
}

Widget setUserNameWidget() {
  return Container(
    padding: EdgeInsets.only(left: 40, top: 40),
    child: Text(
        "Hello ${FirebaseAuth.instance.currentUser!.displayName.toString()}",
        style: GoogleFonts.encodeSansExpanded(
            fontSize: 40,
            fontWeight: FontWeight.w500,
            color: Color(0xff32B768))),
  );
}

Widget homeScreenItem(
    String AssetPath, double height, double width, String designation) {
  return Container(
    height: height * 0.25,
    width: width * 0.45,
    margin: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(30.0),
      boxShadow: [
        BoxShadow(
            offset: Offset(10, 10), color: Colors.black12, blurRadius: 10),
        BoxShadow(
            offset: Offset(-10, -10),
            color: Colors.white.withOpacity(0.45),
            blurRadius: 10),
      ],
    ),
    child: Padding(
      padding: EdgeInsets.all(5),
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            designation,
            textAlign: TextAlign.center,
            style: GoogleFonts.encodeSansSemiCondensed(color: Colors.green),
          )
        ]),
      ),
    ),
  );
}
