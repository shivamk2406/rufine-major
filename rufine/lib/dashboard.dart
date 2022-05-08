import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rufine/drawer.dart';
import 'package:http/http.dart' as http;

import 'auth_service.dart';
import 'onboarding.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyAppDrawer(
        username: FirebaseAuth.instance.currentUser!.displayName.toString(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 70),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              child: Text(
                  "Hello ${FirebaseAuth.instance.currentUser!.displayName.toString()}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            ElevatedButton(
                onPressed: () async {
                  //ait GetResponse();
                  // final authService =
                  //     Provider.of<AuthService>(context, listen: false);
                  // await authService.signOut();
                  // Navigator.of(context).pushReplacement(
                  //     MaterialPageRoute(builder: (_) => Onboarding()));
                },
                child: Text("Sign Out")),
          ]),
        ),
      ),
    );
  }
}

Future<http.Response> GetResponse(
  Map<String, int> jsonData,
) async {
  String url = 'https://diabetespredicxtion.herokuapp.com/predict';
  http.Response response = await http.get(Uri.parse(url));
  final encodedJson = json.encode(jsonData);
  print(encodedJson);

  var responseBody = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"}, body: encodedJson);
  return responseBody;
}
