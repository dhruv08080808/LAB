import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lab_test_app/app/data/data_file.dart';
import 'package:lab_test_app/app/screen/home/tab/tab_test_report.dart';

import 'package:lab_test_app/base/color_data.dart';
import 'package:lab_test_app/base/widget_utils.dart';

import '../../../../base/constant.dart';


class MyBookingScreen extends StatefulWidget {
  const MyBookingScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyBookingScreenState();
  }
}

class _MyBookingScreenState extends State<MyBookingScreen> {
  void backClick() {
    Constant.backToPrev(context);
  }

  //List<ModelHomeVisit> homeVisitList = DataFile.homeVisitList;

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getVerSpace(20.h),
            getBackAppBar(context, () {
              backClick();
            }, 'My Test Booking'),
            getVerSpace(20.h),
            getCustomFont('Your Test Booking', 17.sp, Colors.black, 1,
                    fontWeight: FontWeight.w500)
                .marginSymmetric(horizontal: 20.h),
            getVerSpace(10.h),
            //buildVisitList()
          ],
        )),
      ),
    );
  }

  // Expanded buildVisitList() {
  //   return Expanded(
  //     child: ListView.builder(
  //       itemCount: homeVisitList.length,
  //       itemBuilder: (context, index) {
  //         ModelHomeVisit homeVisit = homeVisitList[index];
  //         return getShadowDefaultContainer(
  //             margin: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
  //             padding: EdgeInsets.all(20.h),
  //             color: Colors.white,
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     getCustomFont(homeVisit.drName, 16.sp, Colors.black, 1,
  //                         fontWeight: FontWeight.w700),
  //                     buildPopupMenuButton((value) {
  //                       handleClick(value,index);
  //                     }),
  //                   ],
  //                 ),
  //                 getVerSpace(3.h),
  //                 getCustomFont(homeVisit.cat, 15.sp, Colors.black, 1,
  //                     fontWeight: FontWeight.w500),
  //                 getVerSpace(20.h),
  //                 buildDateTimeRow(homeVisit.date, homeVisit.time),
  //                 getVerSpace(20.h),
  //                 buildVisitCompleteButton(context)
  //               ],
  //             ));
  //       },
  //     ),
  //   );
  // }

  // Widget buildVisitCompleteButton(BuildContext context) {
  //   return getButton(
  //     context,
  //     'EFFAF0'.toColor(),
  //     'Visit Completed',
  //     "3CBC00".toColor(),
  //     () {},
  //     15.sp,
  //     weight: FontWeight.w500,
  //     buttonHeight: 35.h,
  //     buttonWidth: 138.h,
  //     borderRadius: BorderRadius.circular(22.h),
  //   );
  // }

  // void handleClick(String value,int index) {
  //   switch (value) {
  //     case 'Edit':
  //       Constant.sendToNext(context, Routes.edithomescreen);
  //       // Constant.sendToNext(context, Routes.editReminderScreenRoute);
  //       break;
  //     case 'Delete':
  //      if(index>=0 && index<homeVisitList.length){
  //       homeVisitList.removeAt(index);
  //       setState(() {
          
  //       });
  //       break;
  //      }
  //   }
  // }
}
