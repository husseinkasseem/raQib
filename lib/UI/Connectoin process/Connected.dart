import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Service/TelemetryManager.dart';
import '../../core/constants/assets manager.dart';
import '../Home/home_screen.dart';

class Connected extends StatefulWidget {
  static const String routeName = "Connected";
  final String? ip;
  const Connected({super.key, this.ip});

  @override
  State<Connected> createState() => _ConnectedState();
}

class _ConnectedState extends State<Connected> {
  bool isConnecting = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    _handleConnection();
  }

  Future<void> _handleConnection() async {
    String targetIp = widget.ip ?? "192.168.100.4";
    bool ok = await TelemetryManager().connect(targetIp);

    if (ok) {
      setState(() { isConnecting = false; hasError = false; });
    } else {
      setState(() { isConnecting = false; hasError = true; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                hasError ? "Connection Failed!" : (isConnecting ? "Connecting to Car..." : "Connected Successfully!"),
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40.h),
              Image.asset(AssetsManager.connected, width: 200.w),
              SizedBox(height: 40.h),
              if (!isConnecting && !hasError)
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: Size(250.w, 50.h),
                  ),
                  child: const Text("Go to Dashboard", style: TextStyle(color: Colors.white)),
                ),
              if (hasError)
                TextButton(
                  onPressed: () => _handleConnection(),
                  child: const Text("Retry Connection"),
                )
            ],
          ),
        ),
      ),
    );
  }
}