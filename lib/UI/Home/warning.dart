import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class warning extends StatelessWidget {
  const warning({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 150
            ,),
          Center(child: Text("Warning",style: TextStyle(
            color:Colors.black,fontWeight: FontWeight.bold,fontSize: 50,
          ),))
        ],
      ),
    );
  }
}
