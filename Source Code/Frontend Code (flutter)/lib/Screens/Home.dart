import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:maverick/API%20_services/API.dart';
import 'package:pie_chart/pie_chart.dart';

import '../Constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _testEnd = false;
  bool _loading = false;
  bool expand1 = false;
  bool expand2 = false;
  bool expand3 = false;
  bool expand = false;
  bool show1 = false;
  bool show2 = false;
  bool check = false;
  String bitter = "";
  String sour = "";
  String sweet = "";
  Map<String, double> dataMap = {
    "Sweet": 0,
    "Sour": 0,
    "Pungent": 0,
    "Bitter": 0,
    "Astringent": 0,
  };
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff176B87),
        toolbarHeight: height * 0.1,
        centerTitle: true,
        title: Text(
          "MAVERICK2.0",
          style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(height * 0.05),
          bottomRight: Radius.circular(height * 0.05),
        )),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.015,
              ),
              Text(
                "The Taste of Herbs",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: height * 0.028,
                    decoration: TextDecoration.underline),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      """The taste of an herb actually tells us quite a bit about the medicinal properties of the plant. Taste is the sense that can bring us so much information about the medicines we work with. Plant have developed unique flavors by producing a diverse rangeof phytochemicals. The flavor signals the presence of aconstituent of a plant that initiates a change in our bodies.For example, bitter plants increase saliva, salty ones directenergy to our kidneys, and pungent spices move circulation. However, it’s important to identify any unknown plant and its potential toxicity before you taste it.
                      """,
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.poppins(fontSize: height * 0.018),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Center(
                child: Text(
                  "Properties based on taste",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: height * 0.028,
                      decoration: TextDecoration.underline),
                ),
              ),
              SizedBox(
                height: height * 0.015,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleImageText(
                      height, width, context, "Sweet\n(Madhura)", "assets/images/sweet.png", 0),
                  CircleImageText(
                      height, width, context, "Sour\n(Amla)", "assets/images/sour.png", 1),
                  CircleImageText(
                      height, width, context, "Pungent\n(Katu)", "assets/images/pungent.png", 2),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleImageText(
                      height, width, context, "Bitter\n(Tikta)", "assets/images/butter.png", 3),
                  CircleImageText(height, width, context, "Astringent\n(Kashaya)",
                      "assets/images/astrigent.png", 4),
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Text(
                "Sample Testing",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: height * 0.028,
                    decoration: TextDecoration.underline),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Container(
                alignment: Alignment.center,
                width: width,
                height: height * 0.15,
                decoration: BoxDecoration(
                    color: Color(0xff176B87), borderRadius: BorderRadius.circular(10)),
                child: _testEnd
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleColorText(height, "Sweet", sweet.toString(), Color(0xff02E9B2)),
                          CircleColorText(height, "Bitter", sour.toString(), Color(0xff26B21A)),
                          CircleColorText(height, "Pungent", "0", Color(0xff5ACDD4)),
                          CircleColorText(height, "Sour", bitter.toString(), Color(0xff38B5FB)),
                          CircleColorText(height, "Astringent", "0", Color(0xff578BF1)),
                        ],
                      )
                    : _loading
                        ? LoadingAnimationWidget.fourRotatingDots(
                            color: Colors.white, size: height * 0.05)
                        : ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                _loading = true;
                              });
                              // await Future.delayed(Duration(seconds: 2));
                              var data = await APIServices().getResponse();

                              setState(() {
                                sour = data["bitter"].toString().substring(0, 5);
                                bitter = data["sour"].toString().substring(0, 5);
                                sweet = data["sweet"].toString().substring(0, 5);
                                dataMap = {
                                  "Sweet": double.parse(sweet),
                                  "Bitter": double.parse(sour),
                                  "Pungent": 0,
                                  "Sour": double.parse(bitter),
                                  "Astringent": 0,
                                };
                              });
                              // await NetWorkHandler.postData();
                              setState(() {
                                _loading = false;
                              });
                              setState(() {
                                _testEnd = true;
                              });
                            },
                            style: ButtonStyle(
                                // backgroundColor:  Color(0xffA5E6E2),
                                ),
                            child: Text(
                              "Begin Test",
                              style: GoogleFonts.poppins(color: Colors.black),
                            ),
                          ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Visibility(
                      visible: _testEnd,
                      child: PieChart(
                        dataMap: dataMap,
                        animationDuration: Duration(milliseconds: 800),
                        chartLegendSpacing: 32,
                        chartRadius: MediaQuery.of(context).size.width / 3.2,
                        // colorList: colorList,
                        initialAngleInDegree: 0,
                        chartType: ChartType.ring,
                        ringStrokeWidth: 32,
                        centerText: "HYBRID",
                        legendOptions: LegendOptions(
                          showLegendsInRow: false,
                          legendPosition: LegendPosition.right,
                          showLegends: true,
                          // legendShape: _BoxShape.circle,
                          legendTextStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        chartValuesOptions: ChartValuesOptions(
                          showChartValueBackground: true,
                          showChartValues: true,
                          showChartValuesInPercentage: false,
                          showChartValuesOutside: false,
                          decimalPlaces: 1,
                        ),
                        // gradientList: ---To add gradient colors---
                        // emptyColorGradient: ---Empty Color gradient---
                      )),
                  SizedBox(
                    height: height * 0.05,
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Center(
                child: Text(
                  "Results",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: height * 0.028,
                      decoration: TextDecoration.underline),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Text(
                "Choose the type of result you want to access",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: height * 0.022,
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              InkWell(
                onTap: () async {
                  setState(() {
                    expand1 = !expand1;
                  });
                  if (!show1) {
                    await Future.delayed(Duration(milliseconds: 500));
                  }
                  setState(() {
                    show1 = !show1;
                  });
                },
                child: AnimatedContainer(
                  height: expand1 ? height * 0.35 : height * 0.075,
                  width: width,
                  duration: Duration(milliseconds: 700),
                  decoration: BoxDecoration(
                      color: !expand1 ? Color(0xffADE7E3) : Color(0xff8FD7D3),
                      borderRadius: BorderRadius.circular(10)),
                  curve: Curves.fastOutSlowIn,
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Padding(
                    padding: EdgeInsets.all(height * 0.02),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Recommended Result",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: height * 0.02,
                              ),
                            ),
                            Icon(expand1
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down_rounded),
                          ],
                        ),
                        Visibility(
                          visible: show1,
                          child: Container(
                            width: width,
                            alignment: Alignment.centerLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: height * 0.005,
                                ),
                                Container(
                                  width: width,
                                  decoration: BoxDecoration(
                                      color: Color(0xffFFFFFF),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Medicinal properties based on sourness are -",
                                      style: GoogleFonts.poppins(
                                          fontSize: height * 0.018, color: Colors.black),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.005,
                                ),
                                Text(
                                  "Anti-oxidant , improve heart health, digestive health, lower oxidative stress.",
                                  style: GoogleFonts.poppins(
                                      fontSize: height * 0.018, color: Colors.black),
                                ),
                                SizedBox(
                                  height: height * 0.005,
                                ),
                                Container(
                                  width: width,
                                  decoration: BoxDecoration(
                                      color: Color(0xffFFFFFF),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Medicinal properties based on bitterness are -",
                                      style: GoogleFonts.poppins(
                                          fontSize: height * 0.018, color: Colors.black),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.005,
                                ),
                                Text(
                                  "Anti-inflammatory, Anti-oxidant, helps with digestive problem, anti-microbial, kidney health, balance blood sugar level.",
                                  style: GoogleFonts.poppins(
                                      fontSize: height * 0.018, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              InkWell(
                onTap: () async {
                  setState(() {
                    expand2 = !expand2;
                  });
                  if (!show2) {
                    await Future.delayed(Duration(milliseconds: 500));
                  }
                  if (check) {
                    check = !check;
                  }
                  if (expand) {
                    expand = !expand;
                  }
                  setState(() {
                    show2 = !show2;
                  });
                },
                child: AnimatedContainer(
                  height: expand2 && !expand
                      ? height * 0.2
                      : expand
                          ? height * 0.45
                          : height * 0.075,
                  width: width,
                  duration: Duration(milliseconds: 700),
                  decoration: BoxDecoration(
                      color: !expand2 ? Color(0xffADE7E3) : Color(0xff8FD7D3),
                      borderRadius: BorderRadius.circular(10)),
                  curve: Curves.fastOutSlowIn,
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Padding(
                    padding: EdgeInsets.all(height * 0.02),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Test for Adulteration",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: height * 0.02,
                              ),
                            ),
                            Icon(expand2
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down_rounded),
                          ],
                        ),
                        Visibility(
                          visible: show2,
                          child: Expanded(
                            child: TextFormField(
                              onChanged: (val) {
                                setState(() {
                                  // phoneNumber = val;
                                });
                                print(val.toString());
                              },
                              // obscureText: showPass,

                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Required";
                                }
                                return null;
                              },
                              maxLength: 10,
                              style: GoogleFonts.poppins(fontSize: height * 0.017),
                              decoration: InputDecoration(
                                counterText: "",
                                filled: true,
                                hintText: "Enter the product you are testing for ",
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
                          ),
                        ),
                        Visibility(
                          visible: show2,
                          child: ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                expand = !expand;
                              });
                              if (!check) await Future.delayed(Duration(milliseconds: 500));
                              setState(() {
                                check = !check;
                              });
                            },
                            style: ButtonStyle(
                                // backgroundColor:  Color(0xffA5E6E2),
                                ),
                            child: Text(
                              "Check",
                              style: GoogleFonts.poppins(color: Colors.black),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: check,
                          child: Container(
                            width: width,
                            alignment: Alignment.centerLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: width * 0.15,
                                  height: height * 0.04,
                                  decoration: BoxDecoration(
                                      color: Colors.white, borderRadius: BorderRadius.circular(20)),
                                  child: Text(
                                    "Milk",
                                    style: GoogleFonts.poppins(fontSize: height * 0.018),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.005,
                                ),
                                Text(
                                  "46% chance is that the product id adultereted.",
                                  style: GoogleFonts.poppins(
                                      fontSize: height * 0.018, color: Colors.white),
                                ),
                                SizedBox(
                                  height: height * 0.005,
                                ),
                                Container(
                                  width: width,
                                  decoration: BoxDecoration(
                                      color: Color(0xffFFFFFF),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Range of Actual Composition",
                                      style: GoogleFonts.poppins(
                                          fontSize: height * 0.018, color: Colors.black),
                                    ),
                                  ),
                                ),
                                Text(
                                  "Sweetness - 12 to 20%",
                                  style: GoogleFonts.poppins(
                                      fontSize: height * 0.018, color: Colors.black),
                                ),
                                Container(
                                  width: width,
                                  decoration: BoxDecoration(
                                      color: Color(0xffFFFFFF),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Range of Actual Composition",
                                      style: GoogleFonts.poppins(
                                          fontSize: height * 0.018, color: Colors.black),
                                    ),
                                  ),
                                ),
                                Text(
                                  "Sweetness - 12 to 20%",
                                  style: GoogleFonts.poppins(
                                      fontSize: height * 0.018, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    expand3 = !expand3;
                  });
                },
                child: AnimatedContainer(
                  height: expand3 ? height * 0.2 : height * 0.07,
                  width: width,
                  duration: Duration(milliseconds: 700),
                  decoration: BoxDecoration(
                      color: !expand3 ? Color(0xffADE7E3) : Color(0xff8FD7D3),
                      borderRadius: BorderRadius.circular(10)),
                  curve: Curves.fastOutSlowIn,
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Padding(
                    padding: EdgeInsets.all(height * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Diet Plan",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: height * 0.02,
                          ),
                        ),
                        Icon(expand3 ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down_rounded),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget CircleImageText(
    double height, double width, BuildContext context, String text, String img, int index) {
  return InkWell(
    onTap: () {
      ShowSetPin(
        height,
        width,
        context,
        jsonData[index]["heading"]!,
        jsonData[index]["subheading"]!,
        jsonData[index]["desc"]!,
      );
    },
    child: CircleAvatar(
      radius: height * 0.055,
      backgroundImage: AssetImage(img),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.merienda(color: Colors.white, fontSize: height * 0.015),
      ),
    ),
  );
}

Widget CircleColorText(double height, String text1, String text2, Color color) {
  return CircleAvatar(
    radius: height * 0.04,
    backgroundColor: color,
    child: Padding(
      padding: EdgeInsets.all(height * 0.007),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text1,
            textAlign: TextAlign.center,
            style: GoogleFonts.merienda(color: Colors.white, fontSize: height * 0.012),
          ),
          Text(
            text2,
            textAlign: TextAlign.center,
            style: GoogleFonts.merienda(color: Colors.white, fontSize: height * 0.015),
          ),
        ],
      ),
    ),
  );
}

Future ShowSetPin(
    double height, double width, BuildContext context, String title, String subTitle, String desc) {
  bool sent = false;
  return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
              backgroundColor: Color(0xff419197).withOpacity(0.9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    10.0,
                  ),
                ),
              ),
              content: Container(
                alignment: Alignment.center,
                height: height * 0.45,
                // width: width * 0.6,
                child: Column(
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: height * 0.026,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Text(
                      subTitle,
                      style: GoogleFonts.poppins(
                          color: Color(0xff04364A),
                          fontSize: height * 0.02,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Divider(
                      height: 5,
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Text(
                      desc,
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: height * 0.018,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Divider(
                      height: 5,
                    )
                  ],
                ),
              ));
        });
      });
}
