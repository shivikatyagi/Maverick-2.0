import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:maverick/Screens/Home.dart';
import 'package:maverick/Screens/SignupScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String phoneNumber = "";
  final _formKey = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();
  Map<String, dynamic>? _userData;
  // AccessToken? _accessToken;
  bool showPass = true;
  bool _loading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xff176B87),
      body: Column(
        children: [
          SizedBox(
            height: height * 0.15,
          ),
          Text(
            "Maverick2.0",
            style: GoogleFonts.poppins(fontSize: height * 0.04, color: Colors.white),
          ),
          SizedBox(
            height: height * 0.1,
          ),
          Expanded(
              child: Container(
                  width: width,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30), topRight: Radius.circular(30))),
                  child: Stack(
                    children: [
                      Positioned(
                        left: width * 0.375,
                        top: 10,
                        child: Container(
                          height: 2,
                          decoration: BoxDecoration(
                              color: const Color(0xffDBDEF6),
                              borderRadius: BorderRadius.circular(20)),
                          width: width / 4,
                        ),
                      ),
                      Positioned(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      // SizedBox(
                                      //   height: 5,
                                      // ),
                                      SizedBox(
                                        height: height * 0.04,
                                      ),
                                      // CircleAvatar(
                                      //   radius: height * 0.05,
                                      //   backgroundImage: NetworkImage(
                                      //       "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Unknown_person.jpg/694px-Unknown_person.jpg"),
                                      // ),
                                      SizedBox(
                                        height: 0.1,
                                      ),
                                      Text(
                                        "LOGIN",
                                        style: GoogleFonts.roboto(
                                            fontSize: height * 0.035, color: Colors.black),
                                      ),

                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Form(
                                            key: _formKey,
                                            child: Column(
                                              children: [
                                                TextFormField(
                                                  onChanged: (val) {
                                                    setState(() {
                                                      phoneNumber = val;
                                                    });
                                                    print(val.toString());
                                                  },
                                                  validator: (value) {
                                                    if (value == null || value.isEmpty) {
                                                      return "Required";
                                                    }
                                                    return null;
                                                  },
                                                  maxLength: 100,
                                                  // controller: textEditingController,

                                                  style: GoogleFonts.poppins(fontSize: 17),
                                                  decoration: InputDecoration(
                                                    counterText: "",
                                                    prefixIcon: const Icon(
                                                      Icons.email,
                                                      color: Colors.black,
                                                    ),
                                                    hintText: "Username/E-mail",
                                                    contentPadding: EdgeInsets.all(15),
                                                    fillColor: Colors.white,
                                                    border: OutlineInputBorder(
                                                        borderSide: const BorderSide(
                                                          color: Colors.black,
                                                        ),
                                                        borderRadius: BorderRadius.circular(9.0)),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(9.0),
                                                      borderSide: const BorderSide(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: height * 0.01,
                                                ),
                                                TextFormField(
                                                  onChanged: (val) {
                                                    setState(() {
                                                      phoneNumber = val;
                                                    });
                                                    print(val.toString());
                                                  },
                                                  obscureText: showPass,
                                                  validator: (value) {
                                                    if (value == null || value.isEmpty) {
                                                      return "Required";
                                                    }
                                                    return null;
                                                  },
                                                  maxLength: 100,
                                                  // controller: textEditingController,

                                                  style: GoogleFonts.poppins(fontSize: 17),
                                                  decoration: InputDecoration(
                                                    counterText: "",
                                                    prefixIcon: const Icon(
                                                      Icons.lock,
                                                      color: Colors.black,
                                                    ),
                                                    hintText: "Password",
                                                    suffix: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          showPass = !showPass;
                                                        });
                                                      },
                                                      child: Icon(
                                                        showPass
                                                            ? Icons.visibility
                                                            : Icons.visibility_off_rounded,
                                                      ),
                                                    ),
                                                    contentPadding: EdgeInsets.all(15),
                                                    fillColor: Colors.white,
                                                    border: OutlineInputBorder(
                                                        borderSide: const BorderSide(
                                                          color: Colors.black,
                                                        ),
                                                        borderRadius: BorderRadius.circular(9.0)),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(9.0),
                                                      borderSide: const BorderSide(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: height * 0.04,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          if (_formKey.currentState!.validate()) {
                                            setState(() {
                                              _loading = true;
                                            });
                                            // ApiServices().phoneAuth(context, phoneNumber, false);
                                            await Future.delayed(Duration(seconds: 2));
                                            setState(() {
                                              _loading = false;
                                            });
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => HomeScreen()));
                                          }
                                        },
                                        child: Container(
                                            height: 40,
                                            width: double.maxFinite,
                                            decoration: BoxDecoration(
                                                color: const Color(0xff176B87),
                                                borderRadius: BorderRadius.circular(8)),
                                            child: Center(
                                              child: _loading
                                                  ? LoadingAnimationWidget.waveDots(
                                                      color: Colors.white, size: 40)
                                                  : Text(
                                                      "LOGIN",
                                                      style: GoogleFonts.poppins(
                                                          fontSize: 15, color: Colors.white),
                                                    ),
                                            )),
                                      ),
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            color: Colors.black,
                                            height: 1,
                                            width: 32,
                                          ),
                                          Text(
                                            "  OR  ",
                                            style: GoogleFonts.poppins(fontSize: 14),
                                          ),
                                          Container(
                                            color: Colors.black,
                                            height: 1,
                                            width: 32,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: height / 18,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          // login();
                                        },
                                        child: Container(
                                          height: 52,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color:
                                                      const Color(0xffC3C7E5), // Set border color
                                                  width: 0.5),
                                              borderRadius: BorderRadius.circular(8)),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const FaIcon(
                                                  FontAwesomeIcons.google,
                                                  color: Colors.red,
                                                ),
                                                Text(
                                                  " Continue With Google",
                                                  style: GoogleFonts.poppins(fontSize: 14),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.01,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Don't have an account?",
                                            style: GoogleFonts.poppins(fontSize: height * 0.017),
                                          ),
                                          InkWell(
                                            onTap: () => Get.offAll(SignupScreen()),
                                            child: Text(
                                              " Signup",
                                              style: GoogleFonts.poppins(
                                                  fontSize: height * 0.017, color: Colors.red),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: height / 22,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )))
        ],
      ),
    );
  }
}
