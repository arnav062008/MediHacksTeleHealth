import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:http/http.dart' as http;
import 'package:medihacks_2024/screens/results_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../constants.dart';
import '../styles.dart';
import '../utils/animated_button.dart';
import '../utils/bottomnavbar.dart';

class SymptomScreen extends StatefulWidget {
  const SymptomScreen({Key? key}) : super(key: key);

  @override
  _SymptomScreenState createState() => _SymptomScreenState();
}

class _SymptomScreenState extends State<SymptomScreen> {
  String type = "Diabetes";
  int filledFields = 0;
  bool animateButton = false;
  Map<String, TextEditingController> controllers = {};
  List<String> features = [];
  bool? prediction;
  bool isLoading = false;

  /// Map --> Type and (Symptom and display type)
  Map<String, Map<String, int>> symptomMapper = {
    "Diabetes": diabetesSymptomList,
    "Lung Cancer": cancerSymptomList,
    "Heart Disease": heartSymptomList,
  };

  Future<void> makePrediction() async {
    print("pressed");
    for (int i = 0; i < controllers.length; i++) {
      features.add(controllers.values.elementAt(i).text);
    }

    const String apiUrl = 'http://127.0.0.1:5000/predict';
    Map<String, dynamic> data = {
      'features': features,
      'string_value': type,
    };

    var response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      setState(
        () {
          String predictionString =
              jsonDecode(response.body)['prediction'].toString();
          prediction = predictionString.substring(1, 2) == "1" ? true : false;
          print(prediction);
        },
      );
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    features = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(),
      body: Stack(
        children: [
          SizedBox(
            width: 100.w,
            height: 100.h,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Image.asset(
                  "/Users/arnavpalawat/StudioProjects/Medihacks_2024/lib/assets/bg.png"),
            ),
          ),
          Positioned(
            left: 8.5.w,
            top: 10.h,
            child: SizedBox(
              width: 45.w,
              child: AutoSizeText(
                "Enter $type Symptom Data: ",
                style: darkHeaderStyle,
                maxLines: 2,
              ),
            ),
          )
              .animate()
              .fade(
                duration: const Duration(milliseconds: 1000),
              )
              .slideX(
                begin: -0.25,
                end: 0,
                duration: const Duration(milliseconds: 600),
                curve: Curves.ease,
              ),
          Positioned(
            right: 8.5.w,
            top: 10.h,
            child: Container(
              decoration: BoxDecoration(
                color: mainAccent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: type,
                    items: <String>['Diabetes', 'Lung Cancer', 'Heart Disease']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        type = newValue!;
                        filledFields = 0;
                        controllers = {};
                      });
                    },
                    style: lightHeaderStyle.copyWith(
                      fontWeight: FontWeight.normal,
                      fontSize: 5.w > 2.h ? 2.h : 5.w,
                    ),
                    dropdownColor: tertiaryAccent,
                    iconEnabledColor: Colors.white,
                  ),
                ),
              ),
            ),
          )
              .animate()
              .fade(
                duration: const Duration(milliseconds: 1000),
              )
              .slideX(
                begin: 0.25,
                end: 0,
                duration: const Duration(milliseconds: 600),
                curve: Curves.ease,
              ),
          Positioned(
            top: 20.h,
            child: SizedBox(
              width: 95.w,
              height: 60.h,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: symptomMapper[type]!.length,
                  itemBuilder: (context, index) {
                    String text = symptomMapper[type]!.keys.elementAt(index);
                    TextEditingController controller = TextEditingController();
                    controllers[text] = controller;
                    FocusNode textFocusNode = FocusNode();

                    return Column(
                      children: [
                        Row(
                          children: [
                            AutoSizeText(
                              text,
                              style: const TextStyle(fontSize: 12),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: 10.w,
                              height: 3.5.h,
                              child: TextFormField(
                                key: Key(text),
                                enabled: true,
                                cursorColor: darkColor,
                                controller: controllers[text],
                                focusNode: textFocusNode,
                                decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: darkColor),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: mainAccent,
                                    ),
                                  ),
                                ),
                                onSaved: (_) {
                                  controllers[text]?.text =
                                      controllers[text]!.text;
                                  print(filledFields);
                                  setState(() {
                                    // Increment filledFields when a field is filled
                                    filledFields++;

                                    // Check if all fields are filled
                                    if (filledFields ==
                                        symptomMapper[type]!.length) {
                                      animateButton = true;
                                    }
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: .5.h,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 5.h,
            child: SizedBox(
              width: 100.w,
              child: GestureDetector(
                  onTap: () {
                    makePrediction().whenComplete(
                      () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                DramaticPage(
                                    disease: type, status: prediction ?? false),
                            transitionDuration: Duration.zero,
                            reverseTransitionDuration: Duration.zero,
                          ),
                        );
                      },
                    );
                    prediction = false;
                  },
                  child: AnimatedButton(
                    animate: true,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
