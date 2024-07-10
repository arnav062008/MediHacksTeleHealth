import 'package:flutter/material.dart';
import 'package:medihacks_2024/screens/symptoms_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, _, __) {
      return const MaterialApp(
        title: 'Medihacks',
        home: SymptomScreen(),
      );
    });
  }
}
