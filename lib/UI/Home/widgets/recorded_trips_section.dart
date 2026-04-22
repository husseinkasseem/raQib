import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/colors manager.dart';
import '../../../core/constants/strings manager.dart';
import '../../../core/utils/app style.dart';
import '../../../Service/api_service.dart';
import 'trip_summary_section.dart';

class RecordedTripsSection extends StatefulWidget {
  const RecordedTripsSection({super.key});

  @override
  State<RecordedTripsSection> createState() => _RecordedTripsSectionState();
}

class _RecordedTripsSectionState extends State<RecordedTripsSection> {
  List<dynamic> trips = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTrips();
  }

  Future<void> _loadTrips() async {
    final prefs = await SharedPreferences.getInstance();
    int empId = prefs.getInt('employee_id') ?? 0;

    final res = await ApiManager.getEmployeeTrips(empId);
    if (res['result'] != null && res['result']['ok'] == true) {
      setState(() {
        trips = res['result']['trips'] ?? []; // الداتا هنا
        isLoading = false;
      });
    } else {
      setState(() {
        trips = [];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringsManager.recordedTrips.tr(),
            style: AppStyle.lightTheme.textTheme.headlineMedium
                ?.copyWith(fontSize: 22.sp),
          ),
          SizedBox(height: 8.h),
          Text(
            StringsManager.tripDetails.tr(),
            style: TextStyle(color: Colors.grey, fontSize: 14.sp),
          ),
          SizedBox(height: 20.h),
          ...trips.map((trip) => _buildTripCard(context, trip)),
        ],
      ),
    );
  }

  Widget _buildTripCard(BuildContext context, dynamic trip) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    DateTime startDate = DateTime.parse(trip['start_datetime']);
    String formattedDate = DateFormat('dd MMM yyyy').format(startDate);
    String monthStr = DateFormat('MMM').format(startDate).toLowerCase();

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TripSummarySection(tripId: trip['id']),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isDark
              ? ColorsManager.backgroundAppDark
              : ColorsManager.backgroundAppLight,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(13),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                color: ColorsManager.primary.withAlpha(26),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Text(
                  monthStr.tr().substring(0, 3),
                  style: TextStyle(
                    color: ColorsManager.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                formattedDate,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}