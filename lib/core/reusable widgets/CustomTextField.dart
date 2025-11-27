import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raqib/core/assets%20manager.dart';
import 'package:raqib/core/colors%20manager.dart';

class CustomTextField extends StatefulWidget {
 String hint ;
 TextEditingController controller = TextEditingController() ;
 TextInputType keyboardType ;
 bool iconSwitch = true ;
 bool isObscureText ;
 CustomTextField({
    required this.hint,
    required this.keyboardType,
    required this.controller,
    this.isObscureText = false
});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isObscureText,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      style: TextStyle(),
      decoration: InputDecoration(
        contentPadding: REdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
      hintText: widget.hint,
      hintStyle: Theme.of(context).textTheme.bodyLarge,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(
          color: ColorsManager.primary
        )
      ),
      ),
    );
  }
}
