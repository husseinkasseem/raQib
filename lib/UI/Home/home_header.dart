import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  String? userName;
  String? userImage;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }
  _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('user_name');
      userImage = prefs.getString('user_image');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25.r,
            backgroundColor: Colors.grey.shade200,
            backgroundImage: (userImage != null && userImage!.isNotEmpty)
                ? NetworkImage(userImage!) // الصورة من السيرفر
                : const AssetImage('assets/images/user.png') as ImageProvider, // صورة افتراضية
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              '${"welcome".tr()} ${userName ?? ""}',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
              onPressed: () {
                _loadUserData();
              },
              icon: Icon(Icons.refresh, color: Colors.grey.shade400, size: 20.sp)
          ),
        ],
      ),
    );
  }
}