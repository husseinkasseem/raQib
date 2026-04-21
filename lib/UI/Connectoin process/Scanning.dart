import 'package:flutter/material.dart';
import 'Select_OBD.dart';

class Scanning extends StatelessWidget {
  static const String routeName = "Scanning";
  const Scanning({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      Navigator.pushReplacementNamed(context, SelectOBD.routeName);
    });
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}