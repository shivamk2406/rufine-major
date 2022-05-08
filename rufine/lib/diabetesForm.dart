import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rufine/dashboard.dart';

class Diabetes extends StatefulWidget {
  const Diabetes({Key? key}) : super(key: key);

  @override
  State<Diabetes> createState() => _DiabetesState();
}

class _DiabetesState extends State<Diabetes> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final jsonMap = {
    "Glucose": 0,
    "BloodPressure": 0,
    "SkinThickness": 0,
    "Insulin": 0,
    "BMI": 0,
    "DiabetesPedigreeFunction": 0,
    "Age": 0,
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    key: ValueKey('Glucose'),
                    decoration: InputDecoration(
                      labelText: 'Glucose',
                      labelStyle:
                          GoogleFonts.encodeSansCondensed(color: Colors.black),
                      border: OutlineInputBorder(borderSide: BorderSide()),
                      hintStyle:
                          GoogleFonts.encodeSansCondensed(color: Colors.grey),
                      hintText: 'Enter your glucose level',
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xff32B768), width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xff32B768), width: 2.0),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return "Please provide a value";
                      return null;
                    },
                    onSaved: (value) {
                      jsonMap["Glucose"] = int.parse(value!);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ProvideForm("BloodPressure", "BloodPressure",
                      "Enter your blood pressure"),
                  SizedBox(
                    height: 20,
                  ),
                  ProvideForm("Insulin", "Insulin", "Enter your insulin Level"),
                  SizedBox(
                    height: 20,
                  ),
                  ProvideForm("BMI", "BMI", "Enter your BMI"),
                  SizedBox(
                    height: 20,
                  ),
                  ProvideForm(
                      "DiabetesPedigreeFunction",
                      "DiabetesPedigreeFunction",
                      "Enter your DiabetesPedigreeFunction"),
                  SizedBox(
                    height: 20,
                  ),
                  ProvideForm("Age", "Age", "Enter your Age"),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                        var response = await GetResponse(jsonMap);
                        final decodedJson = json.decode(response.body);
                        //
                        await showMyDialog(context, decodedJson["Diagnosis"]);
                        print(decodedJson["Diagnosis"]);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff32B768),
                      ),
                      child: Text(
                        "Submit",
                        style: GoogleFonts.encodeSansSemiExpanded(),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showMyDialog(BuildContext context, String RiskLevel) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Alert',
            style: GoogleFonts.encodeSansExpanded(),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Your Risk level is',
                  style: GoogleFonts.encodeSansExpanded(),
                ),
                Text(
                  RiskLevel,
                  style: GoogleFonts.encodeSansSemiExpanded(),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget ProvideForm(
    String FieldName,
    String LabelText,
    String HintText,
  ) {
    return TextFormField(
      key: ValueKey(FieldName),
      decoration: InputDecoration(
        labelText: LabelText,
        labelStyle: GoogleFonts.encodeSansCondensed(color: Colors.black),
        border: OutlineInputBorder(borderSide: BorderSide()),
        hintStyle: GoogleFonts.encodeSansCondensed(color: Colors.grey),
        hintText: HintText,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff32B768), width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff32B768), width: 2.0),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) return "Please provide a value";
        return null;
      },
      onSaved: (value) {
        jsonMap[FieldName] = int.parse(value!);
      },
    );
  }
}
