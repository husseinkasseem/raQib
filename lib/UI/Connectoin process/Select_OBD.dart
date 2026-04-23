import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raqib/UI/Connectoin%20process/pairing.dart';

class SelectOBD extends StatefulWidget {
  static const String routeName = "Select OBD";
  const SelectOBD({super.key});

  @override
  State<SelectOBD> createState() => _SelectOBDState();
}

class _SelectOBDState extends State<SelectOBD> {
  final TextEditingController _ipController = TextEditingController(text: "192.168.100.4");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Connect via Wi-Fi", style: Theme.of(context).textTheme.headlineLarge),
            SizedBox(height: 40.h),
            TextField(
              controller: _ipController,
              decoration: const InputDecoration(
                labelText: "Enter PC IP Address",
                border: OutlineInputBorder(),
                hintText: "10.130.204.217",
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 40.h),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Pairing.routeName, arguments: _ipController.text);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 48.h),
                backgroundColor: Theme.of(context).primaryColor,
              ),
              child: Text("Connect to Emulator", style: TextStyle(fontSize: 16.sp, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}