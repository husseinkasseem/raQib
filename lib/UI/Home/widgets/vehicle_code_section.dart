import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Service/TelemetryManager.dart';

class VehicleCodeSection extends StatefulWidget {
  const VehicleCodeSection({super.key});

  @override
  State<VehicleCodeSection> createState() => _VehicleCodeSectionState();
}

class _VehicleCodeSectionState extends State<VehicleCodeSection> {
  final TelemetryManager _manager = TelemetryManager();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            if (!_manager.isTripStarted) {
              _manager.startTrip();
              setState(() {});
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Trip Started! Sending Data...")),
              );
            } else {
              await _manager.stopTrip();
              setState(() {});
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Trip Stopped & Ignition OFF Sent")),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 48.h),
            backgroundColor:
            _manager.isTripStarted ? Colors.red : Theme.of(context).primaryColor,
          ),
          child: Text(
            _manager.isTripStarted ? "Stop Trip" : "Start Trip",
            style: TextStyle(fontSize: 16.sp, color: Colors.white),
          ),
        ),
      ],
    );
  }
}