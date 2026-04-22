import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/strings manager.dart';
import '../../../core/themes/themeProvider.dart';
import '../../../core/utils/app style.dart';
import '../../../core/utils/prefs_helper.dart';
import '../../Auth/login_screen.dart';

class ProfileSection extends StatefulWidget {
  const ProfileSection({super.key});

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  String? userName;
  String? userImage;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // تحميل البيانات المخزنة من الديسك
  _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('user_name');
      userImage = prefs.getString('user_image');
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final currentLocale = context.locale;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Column(
        children: [
          //  (صورة + اسم الموظف)
          _buildProfileHeader(isDark),
          SizedBox(height: 30.h),

          _buildVehicleSection(isDark),
          SizedBox(height: 20.h),

          _buildSettingsTile(
            context: context,
            title: isDark ? StringsManager.dark.tr() : StringsManager.light.tr(),
            icon: isDark ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
            isDark: isDark,
            onTap: () {
              themeProvider.changeTheme(isDark ? ThemeMode.light : ThemeMode.dark);
            },
          ),
          SizedBox(height: 16.h),

          _buildSettingsTile(
            context: context,
            title: currentLocale.languageCode == 'en' ? "English" : "العربية",
            icon: Icons.language,
            isDark: isDark,
            onTap: () {
              if (currentLocale.languageCode == 'en') {
                context.setLocale(const Locale('ar'));
                PrefsHelper.setLanguage('ar');
              } else {
                context.setLocale(const Locale('en'));
                PrefsHelper.setLanguage('en');
              }
            },
          ),
          SizedBox(height: 40.h),

          _buildLogoutButton(context),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(bool isDark) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30.r,
          backgroundColor: Colors.grey.shade200,
          backgroundImage: (userImage != null && userImage!.isNotEmpty)
              ? NetworkImage(userImage!)
              : const AssetImage('assets/images/user.png') as ImageProvider,
        ),
        SizedBox(width: 15.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(StringsManager.profile.tr(), style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
              Text(
                userName ?? "User", // الاسم الحقيقي المخزن
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Icon(Icons.edit_outlined, color: Colors.teal, size: 22.sp),
      ],
    );
  }

  Widget _buildVehicleSection(bool isDark) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(StringsManager.vehicleAndDevice.tr(),
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
          SizedBox(height: 20.h),
          _buildInfoRow(Icons.directions_car, StringsManager.vehicleType.tr(), StringsManager.toyotaCorolla.tr(), Colors.redAccent),
          SizedBox(height: 15.h),
          _buildInfoRow(Icons.bluetooth, StringsManager.connectedDevices.tr(), 'OBD_11 Device', Colors.teal),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, Color iconColor) {
    return Row(
      children: [
        Icon(icon, size: 18.sp, color: iconColor),
        SizedBox(width: 10.w),
        Text(label, style: TextStyle(fontSize: 13.sp, color: Colors.grey[700])),
        const Spacer(),
        Text(value, style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildSettingsTile({required BuildContext context, required String title, required IconData icon, required bool isDark, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[900] : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Text(title, style: TextStyle(fontSize: 16.sp)),
            const Spacer(),
            Icon(Icons.keyboard_arrow_down, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF6B6B),
          padding: EdgeInsets.symmetric(vertical: 15.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          elevation: 0,
        ),
        onPressed: () async {
          // ١. مسح البيانات المخزنة عشان لما يفتح تانى يطلب لوجن
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.clear();

          // ٢. الرجوع لشاشة اللوجن ومسح كل الصفحات اللى قبلها
          Navigator.of(context).pushNamedAndRemoveUntil(
            LoginScreen.routeName,
                (route) => false,
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(StringsManager.logOut.tr(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            SizedBox(width: 10.w),
            const Icon(Icons.logout, color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }
}