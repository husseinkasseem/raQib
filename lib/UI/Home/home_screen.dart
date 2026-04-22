import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../core/constants/colors manager.dart';
import '../../core/themes/themeProvider.dart';
import 'home_header.dart';
import 'widgets/vehicle_code_section.dart';
import 'widgets/recorded_trips_section.dart';
import 'widgets/trip_summary_section.dart';
import 'widgets/profile_section.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.currentTheme == ThemeMode.dark;
    final List<Widget> pages = [
      const _MainHomeContent(),
      const RecordedTripsSection(),
      const TripSummarySection(),
      const ProfileSection(),
    ];
    return Scaffold(
      backgroundColor: isDark ? ColorsManager.backgroundAppDark : ColorsManager.backgroundAppLight,
      body: SafeArea(child: pages[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: isDark ? ColorsManager.backgroundAppDark : Colors.white,
        selectedItemColor: ColorsManager.primary,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontSize: 10.sp),
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.home_outlined), label: "home".tr()),
          BottomNavigationBarItem(icon: const Icon(Icons.history_outlined), label: "history".tr()),
          BottomNavigationBarItem(icon: const Icon(Icons.analytics_outlined), label: "rate".tr()),
          BottomNavigationBarItem(icon: const Icon(Icons.person_outline), label: "profile".tr()),
        ],
      ),
    );
  }
}

class _MainHomeContent extends StatelessWidget {
  const _MainHomeContent();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          const HomeHeader(),
          SizedBox(height: 24.h),
          const VehicleCodeSection(),
        ],
      ),
    );
  }
}