import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lab_test_app/app/routes/app_routes.dart';
import 'package:lab_test_app/base/widget_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../base/constant.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SettingsScreenState();
  }
}

class _SettingsScreenState extends State<SettingsScreen> {
  void backClick() {
    Constant.backToPrev(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        backClick();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              getVerSpace(20.h),
              getBackAppBar(context, () {
                backClick();
              }, 'Settings'),
              getVerSpace(20.h),
              buildSettingTabList(context)
            ],
          ),
        ),
      ),
    );
  }

  Expanded buildSettingTabList(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        buildDefaultTabWidget('EBF7FE', 'time.svg', 'Reminder', () {
          Constant.sendToNext(context, Routes.reminderScreenRoute);
        }),
        getDivider().marginSymmetric(vertical: 16.h),
        buildDefaultTabWidget(
            'E7FCE2', 'terms.svg', 'Terms & Conditions', () {}),
        getDivider().marginSymmetric(vertical: 16.h),
        buildDefaultTabWidget('FFEBE0', 'notifications.svg', 'Notifications',
            () {
          Constant.sendToNext(context, Routes.notificationScreenRoute);
        }),
        getDivider().marginSymmetric(vertical: 16.h),
        buildDefaultTabWidget('E9EEFF', 'privacy.svg', 'Privacy Policy', ()  {
          // Constant.launchURL("http://www.google.com");
          showDialog(context: context, builder: (BuildContext context)=>
          privacy(),
          );
          
        }),
        getDivider().marginSymmetric(vertical: 16.h),
        buildDefaultTabWidget('F9F7DB', 'language.svg', 'Language', () {
          Constant.sendToNext(context, Routes.languageScreenRoute);
         }),
        getDivider().marginSymmetric(vertical: 16.h),
        buildDefaultTabWidget('EEE7FF', 'contact.svg', 'Contact Us', () {
           showDialog(context: context, builder: (BuildContext context)=>
AlertDialogg()
           );
         
        }),
      ],
    ).marginSymmetric(horizontal: 20.h));
  }
}
