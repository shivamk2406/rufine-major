import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:rufine/auth_service.dart';
import 'package:rufine/dashboard.dart';

void FormRegistration(BuildContext context, AuthService authService) async {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    // isDismissible: false,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
    builder: (BuildContext context) {
      return SizedBox(
        height: 650,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 5,
                  width: 50,
                  decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                ),
                const SizedBox(
                  height: 40,
                ),
                DefaultTabController(
                  length: 2,
                  child: getLoginWidget(context, authService),
                  getLoginWidget(context, authService),
                          
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget getLoginWidget(BuildContext context, AuthService authService) {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  return Column(
    mainAxisSize: MainAxisSize.max,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Text(
          'Email address',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Color(0xff374151),
          ),
        ),
      ),
      TextField(
        controller: email,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            hintStyle: const TextStyle(
              fontSize: 12,
            ),
            hintText: 'Eg namaemail@emailkamu.com'),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Text(
          'Password',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Color(0xff374151),
          ),
        ),
      ),
      TextField(
        controller: password,
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            hintStyle: const TextStyle(
              fontSize: 12,
            ),
            hintText: 'Enter your password'),
      ),
      const SizedBox(
        height: 10,
      ),
      Align(
        alignment: Alignment.centerRight,
        child: InkWell(
          onTap: () {},
          child: const Text(
            'Forget Password?',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xff32B768),
            ),
          ),
        ),
      ),
      const SizedBox(
        height: 30,
      ),
      Center(
        child: ElevatedButton(
          onPressed: () async {
            await authService.signInwithEmailAndPassword(
                email.text, password.text);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (builder) => Dashboard()));
          },
          child: const Text(
            'Login',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: const Color(0xff32B768),
            fixedSize: const Size(300, 60),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            shadowColor: Colors.transparent,
          ),
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      Center(
        child: ElevatedButton.icon(
          icon: SvgPicture.asset('assets/images/4.svg'),
          onPressed: () {},
          label: const Text(
            'Login with Google',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xff222222),
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: const Color(0xffF4F4F4),
            fixedSize: const Size(256, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            shadowColor: Colors.transparent,
          ),
        ),
      ),
    ],
  );
}

Widget getSignUpWidget(BuildContext context, AuthService authService) {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Text(
          'Full Name',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Color(0xff374151),
          ),
        ),
      ),
      TextField(
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            hintStyle: const TextStyle(
              fontSize: 12,
            ),
            hintText: 'Enter your full name'),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Text(
          'Email address',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Color(0xff374151),
          ),
        ),
      ),
      TextField(
        controller: email,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            hintStyle: const TextStyle(
              fontSize: 12,
            ),
            hintText: 'Eg namaemail@emailkamu.com'),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Text(
          'Password',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Color(0xff374151),
          ),
        ),
      ),
      TextField(
        controller: password,
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            hintStyle: const TextStyle(
              fontSize: 12,
            ),
            hintText: 'Enter your password'),
      ),
      const SizedBox(
        height: 30,
      ),
      Center(
        child: ElevatedButton(
          onPressed: () async {
            await authService.createUserWithEmailAndPassword(
                email.text, password.text);
            print(email.text);
            print(password.text);
            Navigator.pop(context);
          },
          child: const Text(
            'Registration',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: const Color(0xff32B768),
            fixedSize: const Size(256, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            shadowColor: Colors.transparent,
          ),
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      Center(
        child: ElevatedButton.icon(
          icon: SvgPicture.asset('assets/images/4.svg'),
          onPressed: () {},
          label: const Text(
            'Sign up with Google',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xff222222),
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: const Color(0xffF4F4F4),
            fixedSize: const Size(360, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            shadowColor: Colors.transparent,
          ),
        ),
      ),
    ],
  );
}
