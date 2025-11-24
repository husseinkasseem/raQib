import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raqib/core/colors%20manager.dart';

class CustomTextField extends StatelessWidget {
 String hint ;
 CustomTextField({
    required this.hint
});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(),
      decoration: InputDecoration(
        contentPadding: REdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
      hintText: hint,
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
