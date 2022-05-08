import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svgProvider;
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rufine/auth_service.dart';
import 'package:rufine/dashboard.dart';
import 'package:rufine/models/user_model.dart';
import 'package:rufine/onboarding.dart';

class LoginSignUpUI extends StatefulWidget {
  @override
  _LoginSignUpUIState createState() => _LoginSignUpUIState();
}

class _LoginSignUpUIState extends State<LoginSignUpUI> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;
  //FocusNode _emailFocusNode = FocusNode();
  final _key = GlobalKey<FormState>();
  bool isLogin = false;
  var _user = User();

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  // void _saveForm() {
  //   //Focus.of(context).unfocus();
  //   final isValid = _key.currentState!.validate();
  //   if (!isValid) {
  //     print("invalid");
  //     return;
  //   }

  //   _key.currentState!.save();
  //   widget.submitFn(_user.name, _user.email, _user.password, isLogin, context);
  //   print(_user.name);
  //   print(_user.email);
  //   print(_user.password);
  // }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.8), BlendMode.hardLight),
                image: svgProvider.Svg("assets/images/bg.svg"),
                fit: BoxFit.cover)),
        child: Center(
            child: Form(
          key: _key,
          child: ListView(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "RUFine",
                    style: GoogleFonts.encodeSansSemiCondensed(
                        textStyle: TextStyle(
                          color: Colors.white,
                          //fontWeight: FontWeight.w500,
                        ),
                        fontSize: 40),
                  ),
                ),
              ),
              if (isLogin == false)
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(),
                  child: TextFormField(
                    controller: nameController,
                    autofocus: false,
                    key: ValueKey("Name"),
                    keyboardType: TextInputType.name,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff32B768), width: 2.0)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff32B768), width: 2.0)),
                      labelText: "Name",
                      labelStyle:
                          GoogleFonts.encodeSansCondensed(color: Colors.white),
                      border: OutlineInputBorder(borderSide: BorderSide()),
                      hintText: "Enter Name",
                      hintStyle:
                          GoogleFonts.encodeSansExpanded(color: Colors.white),
                      //errorText: "Please enter Email to continue",
                      prefixIcon: Icon(
                        Icons.account_box_outlined,
                        color: Color(0xff32B768),
                      ),
                    ),
                    onSaved: (value) {
                      _user.displayName = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) return "Please Provide a valid name";
                      return null;
                    },
                  ),
                ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(),
                child: TextFormField(
                  controller: emailController,
                  autofocus: false,
                  key: ValueKey("Email"),
                  keyboardType: TextInputType.name,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xff32B768), width: 2.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xff32B768), width: 2.0)),
                    labelText: "Email",
                    labelStyle:
                        GoogleFonts.encodeSansCondensed(color: Colors.white),
                    border: OutlineInputBorder(),
                    hintText: "Enter Email",
                    hintStyle:
                        GoogleFonts.encodeSansExpanded(color: Colors.white),
                    //errorText: "Please enter Email to continue",
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Color(0xff32B768),
                    ),
                  ),
                  onSaved: (value) {
                    _user.email = value!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) return "Please Provide a valid Email";
                    return null;
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(),
                child: TextFormField(
                  controller: passwordController,
                  key: ValueKey('password'),
                  //focusNode: _emailFocusNode,
                  obscureText: _obscureText,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  autofocus: false,
                  keyboardType: TextInputType.visiblePassword,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    errorStyle: GoogleFonts.encodeSansSemiExpanded(),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xff32B768), width: 2.0)),
                    labelText: "Password",
                    labelStyle:
                        GoogleFonts.encodeSansCondensed(color: Colors.white),
                    border: OutlineInputBorder(),
                    hintText: "Enter Password",
                    hintStyle: GoogleFonts.encodeSansExpanded(),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white, width: 2.0)),
                    //errorText: "Please enter Email to continue",
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: Color(0xff32B768),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _toggle();
                      },
                      child: Icon(
                        _obscureText
                            ? Icons.remove_red_eye
                            : Icons.remove_red_eye_outlined,
                        color: Color(0xff32B768),
                      ),
                    ),
                  ),
                  onSaved: (value) {
                    _user.Password = value!;
                  },
                  validator: (value) {
                    if (value!.isEmpty)
                      return "Please Provide a valid password";
                    return null;
                  },
                ),
              ),
              // if (widget.isLoading)
              //   Center(
              //     child: CircularProgressIndicator(),
              //   ),
              //if (!widget.isLoading)
              Center(
                child: Container(
                    width: 200,
                    height: 40,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xff32B768)),
                        onPressed: () async {
                          print("Button Pressed");
                          print(nameController.text);
                          print("\n");
                          isLogin
                              ? context.read<AuthService>().signIn(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  context: context)
                              : context.read<AuthService>().signUp(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    context: context,
                                  );
                          print(nameController.text.trim());
                        },
                        child: Text(isLogin == false ? "SignUp" : "LogIn",
                            style: GoogleFonts.encodeSansSemiExpanded()))),
              ),
              // if (!widget.isLoading)
              Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      isLogin == false
                          ? "Already have an account"
                          : "Doesn't have an Account",
                      style: GoogleFonts.encodeSansSemiExpanded(
                          color: Colors.white)),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isLogin = !isLogin;
                      });
                    },
                    child: Text(
                      isLogin == false ? "Login" : "Signup",
                      style: GoogleFonts.encodeSansSemiExpanded(
                          color: Color(0xff32B768)),
                    ),
                  ),
                  Text("Instead",
                      style: GoogleFonts.encodeSansSemiExpanded(
                          color: Colors.white))
                ],
              )),

              Center(
                child: Container(
                    width: 200,
                    height: 40,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xff32B768)),
                        onPressed: () async {
                          // print(ModalRoute.of(context)!
                          //     .settings
                          //     .arguments
                          //     .runtimeType);

                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => Onboarding()));
                        },
                        child: Text("Go back",
                            style: GoogleFonts.encodeSansSemiExpanded()))),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
