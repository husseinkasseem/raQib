import 'package:flutter/material.dart';
import 'package:raqib/core/colors%20manager.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "home" ;
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(color: ColorsManager.secondary,);
  }
}
