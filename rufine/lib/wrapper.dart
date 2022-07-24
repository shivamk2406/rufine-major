import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rufine/dashboard.dart';

import 'auth_service.dart';
import 'models/user_model.dart';
import 'onboarding.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<User?>(
        stream: authService.user,
        builder: (_, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final User? user = snapshot.data;
            if (user == null) {
              return Onboarding();
            } else
              return Dashboard();
          } else
            return const Center(child: CircularProgressIndicator());
        });
  }
}
