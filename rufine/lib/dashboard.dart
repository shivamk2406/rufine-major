import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rufine/drawer.dart';

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
      drawer: MyAppDrawer(username: "Skyler"
          //FirebaseAuth.instance.currentUser!.displayName.toString(),
          ),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          child: Text("Hello User",
              //FirebaseAuth.instance.currentUser!.displayName.toString(),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
      ])),
    );
  }
}
