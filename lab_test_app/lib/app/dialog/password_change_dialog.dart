import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lab_test_app/app/routes/app_routes.dart';
import 'package:lab_test_app/base/color_data.dart';
import 'package:lab_test_app/base/constant.dart';
import 'package:lab_test_app/base/widget_utils.dart';

class PasswordChangeDialog extends StatefulWidget {
  const PasswordChangeDialog({Key? key}) : super(key: key);

  @override
  State<PasswordChangeDialog> createState() => _PasswordChangeDialogState();
}

class _PasswordChangeDialogState extends State<PasswordChangeDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20.h),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.h)),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30.h),
        width: 374.h,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            getVerSpace(30.h),
            Container(
              alignment: Alignment.center,
              height: 171.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35.h),
                  gradient: RadialGradient(
                      colors: [gradientFirst, gradientSecond, gradientFirst],
                      stops: const [0.0, 0.49, 1.0])),
              child: getSvgImage("lock.svg", width: 104.h, height: 104.h),
            ),
            getVerSpace(31.h),
            loginHeader("Password Changed",
                "Your password has been successfully \nchanged!"),
            getVerSpace(40.h),
            getButton(context, accentColor, "Ok", Colors.white, () {
              Constant.sendToNext(context, Routes.loginRoute);
            }, 18.sp,
                weight: FontWeight.w700,
                buttonHeight: 60.h,
                borderRadius: BorderRadius.circular(22.h)),
            getVerSpace(30.h)
          ],
        ),
      ),
    );
  }
}
