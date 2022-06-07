import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:rufine/SelectedSymptom.dart';
import 'package:rufine/models/symptoms.dart';
import 'package:http/http.dart' as http;

class SymptomBased extends StatefulWidget {
  const SymptomBased({Key? key}) : super(key: key);

  @override
  State<SymptomBased> createState() => _SymptomBasedState();
}

class _SymptomBasedState extends State<SymptomBased> {
  List<String> AvailableSymptoms = [
    'Itching',
    'Skin Rash',
    'Nodal Skin Eruptions',
    'Continuous Sneezing',
    'Shivering',
    'Chills',
    'Joint Pain',
    'Stomach Pain',
    'Acidity',
    'Ulcers On Tongue',
    'Muscle Wasting',
    'Vomiting',
    'Burning Micturition',
    'Spotting  urination',
    'Fatigue',
    'Weight Gain',
    'Anxiety',
    'Cold Hands And Feets',
    'Mood Swings',
    'Weight Loss',
    'Restlessness',
    'Lethargy',
    'Patches In Throat',
    'Irregular Sugar Level',
    'Cough',
    'High Fever'
  ];
  Map<String, String> SufferedSymptoms = {"Symptoms": ""};
  List<Symptom> AvailableSymptomsObject = [];
  List<CheckboxListTile> AvailableSymptomsCheckbox = [];

  List<Symptom>? createSymptomList() {
    List<Symptom> symptomList = [];
    for (int i = 0; i < AvailableSymptoms.length; i++) {
      symptomList.add(Symptom(
        name: AvailableSymptoms[i],
        isSelected: false,
      ));
    }
    return symptomList;
  }

  @override
  void initState() {
    // TODO: implement initState
    AvailableSymptomsObject = createSymptomList()!;
    super.initState();
  }

  // ignore: non_constant_identifier_names
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff32B768),
        title: Text(
          'Symptom Based',
          style: GoogleFonts.montserrat(),
        ),
      ),
      body: Column(children: [
        Container(
          height: 700,
          width: 900,
          child: Padding(
            padding: EdgeInsets.all(5),
            child: ListView(
              children: <Widget>[
                ...AvailableSymptomsObject.map((e) => buildSingleCheckBox(e))
                    .toList(),
              ],
            ),
          ),
        ),
        ElevatedButton(
            onPressed: () async {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Processing Data')),
              );
              var response = await GetResponse({
                "Symptoms":
                    "Loss Of Balance,Unsteadiness,Weakness Of One Body Side"
              });
              final decodedJson = json.decode(response.body);
              print(decodedJson["Diagnosis"]);
              //await showMyDialog(context, decodedJson["Diagnosis"]);
            },
            child: Text('Submit', style: GoogleFonts.montserrat()))
      ]),
    );
  }

  Widget buildSingleCheckBox(Symptom sym) {
    return CheckboxListTile(
      title: Text(sym.name.toString()),
      value: sym.isSelected,
      onChanged: (value) => setState(() {
        sym.isSelected = value;
        print(value);
        if (value as bool) {
          if (SufferedSymptoms['Symptoms'] == "") {
            SufferedSymptoms['Symptoms'] = sym.name.toString().trim();
          } else {
            SufferedSymptoms['Symptoms'] =
                SufferedSymptoms['Symptoms']! + "," + sym.name.toString();
          }
        } else {
          if (!SufferedSymptoms['Symptoms']!.contains(",")) {
            print("inside this block");
            SufferedSymptoms['Symptoms'] = "";
          } else
            SufferedSymptoms['Symptoms'] = SufferedSymptoms['Symptoms']!
                .replaceAll(sym.name.toString().trim() + ",", "");
        }
        print(SufferedSymptoms);
      }),
    );
  }

  Future<http.Response> GetResponse(
    Map<String, String> jsonData,
  ) async {
    String url = 'https://diabetespredicxtion.herokuapp.com/predict1';
    http.Response response = await http.get(Uri.parse(url));
    final encodedJson = json.encode(jsonData);
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
}
