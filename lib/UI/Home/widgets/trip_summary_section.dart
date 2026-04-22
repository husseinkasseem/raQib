import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/strings manager.dart';
import '../../../Service/api_service.dart';

class TripSummarySection extends StatefulWidget {
  final int? tripId;

  const TripSummarySection({super.key, this.tripId});

  @override
  State<TripSummarySection> createState() => _TripSummarySectionState();
}

class _TripSummarySectionState extends State<TripSummarySection> {
  Map<String, dynamic>? data;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchSummary();
  }

  Future<void> _fetchSummary() async {
    int? idToFetch = widget.tripId;

    if (idToFetch == null) {
      final prefs = await SharedPreferences.getInstance();
      idToFetch = prefs.getInt('last_trip_id');
    }

    if (idToFetch == null) {
      setState(() {
        isLoading = false;
        data = null;
      });
      return;
    }

    final res = await ApiManager.getTripSummary(idToFetch);

    if (res['result'] != null && res['result']['ok'] == true) {
      setState(() {
        data = res['result'];
        isLoading = false;
      });
    } else {
      setState(() {
        data = null;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (data == null) {
      return const Scaffold(
        body: Center(child: Text("No Trip Data Found")),
      );
    }

    final trip = data!['trip'];
    final behaviors = (data!['driving_behavior'] ?? []) as List;
    final safety = data!['driver_safety_score'];

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.play_arrow, size: 18.sp),
                SizedBox(width: 8.w),
                Text(
                  StringsManager.tripSummary.tr(),
                  style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              '${trip['date']} | ${trip['duration_min']} min | ${trip['distance_km']} km',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 30.h),

            ...behaviors.map((b) => _buildBehaviorItem(
              icon: _getIcon(b['code']),
              title: b['title'] ?? '',
              events: b['value_label'] ?? '',
              detail: b['subtitle'] ?? '',
              status: b['status'] ?? '',
              color: (b['status'] == 'Good')
                  ? Colors.teal
                  : Colors.orange,
            )),

            SizedBox(height: 30.h),

            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F9F9),
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    StringsManager.driverSafetyScore.tr(),
                    style:
                    TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 70.w,
                        height: 70.w,
                        child: CircularProgressIndicator(
                          value: (safety['score'] ?? 0) / 100,
                          strokeWidth: 8,
                          backgroundColor: Colors.grey[200],
                          valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.teal),
                        ),
                      ),
                      Text(
                        safety['label'] ?? '',
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIcon(String code) {
    switch (code) {
      case 'over_speed':
        return Icons.speed;
      case 'sudden_stop':
        return Icons.warning_amber_rounded;
      case 'idle_duration':
        return Icons.hourglass_empty;
      default:
        return Icons.directions_car;
    }
  }

  Widget _buildBehaviorItem({
    required IconData icon,
    required String title,
    required String events,
    required String detail,
    required String status,
    required Color color,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20.sp),
              SizedBox(width: 8.w),
              Text(title,
                  style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
              const Spacer(),
              Text(events,
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 28.w),
                child: Text(detail,
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
              ),
              Text(
                status,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}