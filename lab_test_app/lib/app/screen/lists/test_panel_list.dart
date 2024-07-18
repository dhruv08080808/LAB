import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:lab_test_app/app/data/data_file.dart';
import 'package:lab_test_app/app/models/panel_test_name_list.dart';
import 'package:lab_test_app/base/color_data.dart';
import 'package:lab_test_app/base/constant.dart';
import 'package:lab_test_app/base/widget_utils.dart';

class ListOfTests extends StatefulWidget {
  const ListOfTests({super.key});

  @override
  State<ListOfTests> createState() => _ListOfTestsState();
}

class _ListOfTestsState extends State<ListOfTests> {
  void backClick() {
    Constant.backToPrev(context);
  }

  List<TestNameList> testnameList = DataFile.testNames;

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
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
                }, 'Tests'),
                getVerSpace(20.h),
                buildTestsNameListView()
              ],
            ),
          )),
    );
  }

  Expanded buildTestsNameListView() {
    return Expanded(
        flex: 1,
        child: ListView.builder(
          itemCount: testnameList.length,
          itemBuilder: (context, index) {
            TestNameList testsName = testnameList[index];
            return GestureDetector(
              onTap: () {
                // Constant.sendToNext(context, Routes.testPanelList);
              },
              child: getShadowDefaultContainer(
                height: 130.h,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
                color: Colors.white,
                child: Row(
                  children: [
                    getCircularImage(context, 100.h, 100.h, 20.h, testsName.img,
                            boxFit: BoxFit.cover)
                        .marginSymmetric(horizontal: 12.h),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              getCustomFont(
                                  testsName.title, 18.sp, Colors.black, 1,
                                  fontWeight: FontWeight.w700),
                              getVerSpace(5.h),
                              Row(
                                children: [
                                  getCustomFont("Price(₹): ".toString(), 12.sp,
                                      Colors.black, 1,
                                      fontWeight: FontWeight.w500),
                                  getHorSpace(7.h),
                                  getCustomFont(testsName.amount.toString(),
                                      12.sp, Colors.black, 1,
                                      fontWeight: FontWeight.w500),
                                ],
                              ),
                            ],
                          ).marginSymmetric(horizontal: 4.h),
                          getButton(context, accentColor, "Book Now",
                                  Colors.white, () {}, 18.sp,
                                  insetsGeometrypadding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                  weight: FontWeight.w400,
                                  buttonHeight: 40.h,
                                  borderRadius: BorderRadius.circular(20.h))
                              .marginSymmetric(horizontal: 14.h),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }

  Widget buildPayNowButton(BuildContext context) {
    return getButton(
      context,
      accentColor,
      'Book Now',
      Colors.white,
      () {
        // Constant.sendToNext(context, Routes.paymentScreenRoute);
      },
      15.sp,
      weight: FontWeight.w500,
      buttonHeight: 40.h,
      borderRadius: BorderRadius.circular(22.h),
    ).marginSymmetric(horizontal: 20.h);
  }
}
