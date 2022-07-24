import 'dart:convert';

import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:rufine/dashboard.dart';
import 'package:http/http.dart' as http;

class HeartDisease extends StatefulWidget {
  const HeartDisease({Key? key}) : super(key: key);

  @override
  State<HeartDisease> createState() => _HeartDiseaseState();
}

class _HeartDiseaseState extends State<HeartDisease> {
  String? Smokevalue,
      Drinkvalue,
      StrokeValue,
      DiabetesValue,
      DiffValue,
      GenValue,
      DiabValue,
      PhyValue,
      GenHeValue,
      AsthValue,
      KidValue,
      SkinValue,
      AgeValue,
      value;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final AgeCategory = {
    '18-24': 0,
    '25-29': 1,
    '30-34': 2,
    '35-39': 3,
    '40-44': 4,
    '45-49': 5,
    '50-54': 6,
    '55-59': 7,
    '60-64': 8,
    '65-69': 9,
    '70-74': 10,
    '75-79': 11,
    '80 or older': 12
  };
  final GenHealth = {
    'Poor': 0,
    'Fair': 1,
    'Good': 2,
    'Very good': 3,
    'Excellent': 4,
  };
  final Reponse = {
    'Yes': 1,
    'No': 0,
  };
  final Gender = {'Male': 1, 'Female': 0};
  final GenHealthResp = {
    'Poor': 0,
    'Fair': 1,
    'Good': 2,
    'Very good': 3,
    'Excellent': 4,
  };
  final jsonMap = {
    "BMI": 16.60,
    "Smoking": 0,
    "AlcoholDrinking": 0,
    "Stroke": 0,
    "PhysicalHealth": 3.0,
    "MentalHealth": 30.0,
    "DiffWalking": 0,
    "Sex": 0,
    "AgeCategory": 4,
    "Diabetic": 0,
    "PhysicalActivity": 1,
    "GenHealth": 2,
    "SleepTime": 5.0,
    "Asthma": 0,
    "KidneyDisease": 0,
    "SkinCancer": 1,
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff32B768),
        title: Text(
          'Heart Disease Prediction',
          style: GoogleFonts.montserrat(),
        ),
      ),
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
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 10, right: 16),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 2),
                        borderRadius: BorderRadius.circular(5)),
                    child: DropdownButton<String>(
                        value: Smokevalue,
                        items: _createDropDownItems(Reponse),
                        isExpanded: true,
                        hint: Text("Do You Smoke?",
                            style: GoogleFonts.encodeSansSemiCondensed()),
                        onChanged: (value) {
                          setState(() {
                            this.Smokevalue = value;
                            jsonMap["Smoking"] = Reponse[value] as num;
                          });
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 10, right: 16),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 2),
                        borderRadius: BorderRadius.circular(5)),
                    child: DropdownButton<String>(
                        value: Drinkvalue,
                        items: _createDropDownItems(Reponse),
                        isExpanded: true,
                        hint: Text("Do you drink alcohol?",
                            style: GoogleFonts.encodeSansSemiCondensed()),
                        onChanged: (value) {
                          setState(() {
                            this.Drinkvalue = value;
                            jsonMap["AlcoholDrinking"] = Reponse[value] as num;
                          });
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 10, right: 16),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 2),
                        borderRadius: BorderRadius.circular(5)),
                    child: DropdownButton<String>(
                        value: StrokeValue,
                        items: _createDropDownItems(Reponse),
                        isExpanded: true,
                        hint: Text("Do you have stroke",
                            style: GoogleFonts.encodeSansSemiCondensed()),
                        onChanged: (value) {
                          setState(() {
                            this.StrokeValue = value;
                            jsonMap["Stroke"] = Reponse[value] as num;
                          });
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ProvideForm("BMI", "BMI", "Enter your BMI"),
                  SizedBox(
                    height: 20,
                  ),
                  ProvideForm("PhysicalHealth", "PhysicalHealth",
                      "Enter your PhysicalHealth?"),
                  SizedBox(
                    height: 20,
                  ),
                  ProvideForm("MentalHealth", "MentalHealth",
                      "Enter your MentalHealth?"),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 10, right: 16),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 2),
                        borderRadius: BorderRadius.circular(5)),
                    child: DropdownButton<String>(
                        value: DiffValue,
                        items: _createDropDownItems(Reponse),
                        isExpanded: true,
                        hint: Text("Do you Have Difficulty in Walking?",
                            style: GoogleFonts.encodeSansSemiCondensed()),
                        onChanged: (value) {
                          setState(() {
                            this.DiffValue = value;
                            jsonMap["DiffWalking"] = Reponse[value] as num;
                          });
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 10, right: 16),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 2),
                        borderRadius: BorderRadius.circular(5)),
                    child: DropdownButton<String>(
                        value: GenValue,
                        items: _createDropDownItems(Gender),
                        isExpanded: true,
                        hint: Text("Enter your Gender?",
                            style: GoogleFonts.encodeSansSemiCondensed()),
                        onChanged: (value) {
                          setState(() {
                            this.GenValue = value;
                            jsonMap["Sex"] = Gender[value] as num;
                          });
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 10, right: 16),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 2),
                        borderRadius: BorderRadius.circular(5)),
                    child: DropdownButton<String>(
                        value: DiabValue,
                        items: _createDropDownItems(Reponse),
                        isExpanded: true,
                        hint: Text("Are you Diabetic?",
                            style: GoogleFonts.encodeSansSemiCondensed()),
                        onChanged: (value) {
                          setState(() {
                            this.DiabValue = value;
                            jsonMap["Diabetes"] = Reponse[value] as num;
                          });
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 10, right: 16),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 2),
                        borderRadius: BorderRadius.circular(5)),
                    child: DropdownButton<String>(
                        value: PhyValue,
                        items: _createDropDownItems(Reponse),
                        isExpanded: true,
                        hint: Text("Do you involve in Physical Activity?",
                            style: GoogleFonts.encodeSansSemiCondensed()),
                        onChanged: (value) {
                          setState(() {
                            this.PhyValue = value;
                            jsonMap["PhysicalActivity"] = Reponse[value] as num;
                          });
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 10, right: 16),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 2),
                        borderRadius: BorderRadius.circular(5)),
                    child: DropdownButton<String>(
                        value: GenHeValue,
                        items: _createDropDownItems(GenHealthResp),
                        isExpanded: true,
                        hint: Text("How is your GenHealth?",
                            style: GoogleFonts.encodeSansSemiCondensed()),
                        onChanged: (value) {
                          setState(() {
                            this.GenHeValue = value;
                            jsonMap["GenHealth"] = GenHealthResp[value] as num;
                          });
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ProvideForm(
                      "SleepTime", "SleepTime", "What is your SleepTime?"),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 10, right: 16),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 2),
                        borderRadius: BorderRadius.circular(5)),
                    child: DropdownButton<String>(
                        value: AsthValue,
                        items: _createDropDownItems(Reponse),
                        isExpanded: true,
                        hint: Text("Do you have Asthma?",
                            style: GoogleFonts.encodeSansSemiCondensed()),
                        onChanged: (value) {
                          setState(() {
                            this.AsthValue = value;
                            jsonMap["Asthma"] = Reponse[value] as num;
                          });
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 10, right: 16),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 2),
                        borderRadius: BorderRadius.circular(5)),
                    child: DropdownButton<String>(
                        value: KidValue,
                        items: _createDropDownItems(Reponse),
                        isExpanded: true,
                        hint: Text("Do you have KidneyDisease?",
                            style: GoogleFonts.encodeSansSemiCondensed()),
                        onChanged: (value) {
                          setState(() {
                            this.KidValue = value;
                            jsonMap["KidneyDisease"] = Reponse[value] as num;
                          });
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 10, right: 16),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 2),
                        borderRadius: BorderRadius.circular(5)),
                    child: DropdownButton<String>(
                        value: SkinValue,
                        items: _createDropDownItems(Reponse),
                        isExpanded: true,
                        hint: Text("Do you have SkinCancer?",
                            style: GoogleFonts.encodeSansSemiCondensed()),
                        onChanged: (value) {
                          setState(() {
                            this.SkinValue = value;
                            jsonMap["SkinCancer"] = Reponse[value] as num;
                          });
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 10, right: 16),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 2),
                        borderRadius: BorderRadius.circular(5)),
                    child: DropdownButton<String>(
                        value: AgeValue,
                        items: _createDropDownItems(AgeCategory),
                        isExpanded: true,
                        hint: Text(
                          "Select your Age Category?",
                          style: GoogleFonts.encodeSansSemiCondensed(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            this.AgeValue = value;
                            jsonMap["AgeCategory"] = AgeCategory[value] as num;
                          });
                        }),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        print(jsonMap);
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                        var response = await GetResponse12(jsonMap);
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

  List<DropdownMenuItem<String>> _createDropDownItems(Map<String, int> map) {
    List<DropdownMenuItem<String>> items = [];
    map.forEach((key, value) {
      items.add(DropdownMenuItem<String>(
        value: key,
        child: Text(key),
      ));
    });
    return items;
  }

  Future<http.Response> GetResponse12(
    Map<String, dynamic> jsonData,
  ) async {
    String url = 'https://diabetespredicxtion.herokuapp.com/predict2';
    http.Response response = await http.get(Uri.parse(url));
    final encodedJson = json.encode(jsonData);
    print("Here is the encoded json");
    print(encodedJson);

    var responseBody = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: encodedJson);
    return responseBody;
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

  Widget CreateDropDown(
      Map<String, int> AgeCategory, String FieldName, String query) {
    String? val = "";
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 10, right: 16),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.green, width: 2),
          borderRadius: BorderRadius.circular(5)),
      child: DropdownButton<String>(
          //value: FieldName,
          hint: Text(
            query,
            style: GoogleFonts.encodeSansSemiCondensed(),
          ),
          iconSize: 24,
          elevation: 16,
          style: const TextStyle(color: Color(0xff32B768)),
          items: AgeCategory.map((key, value) => MapEntry(
              key,
              DropdownMenuItem(
                value: key,
                child: Text(
                  key,
                  style: TextStyle(color: Colors.black),
                ),
              ))).values.toList(),
          onChanged: (String? newValue) {
            setState(() {
              jsonMap[FieldName] = AgeCategory[newValue] as num;
              val = newValue;
            });
          }),
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
