import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rufine/models/symptoms.dart';

class SelectedSymptom extends StatefulWidget {
  final int number;
  final Symptom symptom;

  const SelectedSymptom(this.number, this.symptom);

  @override
  State<SelectedSymptom> createState() => _SelectedSymptomState();
}

class _SelectedSymptomState extends State<SelectedSymptom> {
  Map<String, String> SufferedSymptoms = {"Symptoms": ""};
  bool applied = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: GestureDetector(
        // toggle state on tap
        onTap: () {
          setState(() {
            applied = !applied;
            if (SufferedSymptoms['Symptoms'] == "") {
              SufferedSymptoms['Symptoms'] = widget.symptom.name.toString();
            } else {
              SufferedSymptoms['Symptoms'] = SufferedSymptoms['Symptoms']! +
                  "," +
                  widget.symptom.name.toString();
            }
          });
          print(SufferedSymptoms);
        },
        child: Container(
          decoration: BoxDecoration(
            // border: Border.all(color: Color(0xff940D5A)),
            color: Colors.white,
            borderRadius: BorderRadius.circular(17.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey,
                offset: Offset(1.0, 15.0),
                blurRadius: 20.0,
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    widget.symptom.name.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xff00315C),
                      fontSize: 12.0,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: FlatButton(
                  // toggle state on tap
                  onPressed: () {
                    setState(() => applied = !applied);
                  },
                  // set color based on state
                  color: applied ? Colors.green : Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 65.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(17),
                          bottomLeft: Radius.circular(17))),
                  child: applied
                      ? Text("Applied")
                      : Text(
                          "Apply",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
