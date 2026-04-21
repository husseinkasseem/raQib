import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raqib/UI/Connectoin%20process/Connected.dart';
import '../../core/constants/assets manager.dart';
import '../../core/constants/strings manager.dart';
class Pairing extends StatefulWidget {
  static const String routeName = "Pairing";
  const Pairing({super.key});

  @override
  State<Pairing> createState() => _PairingState();
}

class _PairingState extends State<Pairing> {
  String? ipAddress;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ipAddress = ModalRoute.of(context)?.settings.arguments as String?;
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(Connected.routeName, arguments: ipAddress);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: REdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 209.h),
                  Text(
                    StringsManager.pairing,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  SizedBox(height: 171.h),
                  Image.asset(AssetsManager.pairing),
                  SizedBox(height: 140.h),
                  Column(
                    children: [
                      Text(
                        StringsManager.connected,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        "OBD-11Device",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  SizedBox(height: 40.h),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 48.h),
                      backgroundColor: Colors.red,
                    ),
                    child: Text(
                      StringsManager.cancel,
                      style: TextStyle(fontSize: 16.sp, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 56.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}