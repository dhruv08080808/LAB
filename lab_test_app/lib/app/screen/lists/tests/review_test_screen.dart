import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lab_test_app/app/screen/lists/tests/test_detail_screen.dart';
import 'package:lab_test_app/base/color_data.dart';
import 'package:lab_test_app/base/widget_utils.dart';

import '../../../../base/constant.dart';
import '../../../routes/app_routes.dart';

class ReviewTestScreen extends StatefulWidget {
  const ReviewTestScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ReViewTestScreenState();
  }
}

class _ReViewTestScreenState extends State<ReviewTestScreen> {

  String datetimee = DateTime.now().toString();

  DateTime date1 = DateTime(2016, 10, 28);
  void backClick() {
    Constant.backToPrev(context);
  }

  TextEditingController dateController = TextEditingController();
  TextEditingController timecontroller=TextEditingController();

  RxInt selectedPos = 0.obs;
  List visit = ['Visit Lab', 'Visit Home'];

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
              }, 'Review Test'),
              getVerSpace(20.h),
              Expanded(
                  child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getCustomFont('Test Name', 18.sp, Colors.black, 1,
                          fontWeight: FontWeight.w700)
                      .marginSymmetric(horizontal: 20.h),
                  getVerSpace(12.h),
                  buildTestInfoView(),
                  getVerSpace(20.h),
                  buildInfoWidget(),
                  getVerSpace(20.h),
                  buildDateTimeWidget(context),
                  buildVisitWidget(),
                  buildTotalAmountRow(),
                  getVerSpace(35.h),
                  buildPlaceOrderButton(context),
                  getVerSpace(28.h),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTestInfoView() {
    return Row(
      children: [
        Container(
          height: 83.h,
          width: 83.h,
          decoration: BoxDecoration(
            color: 'FDE9E9'.toColor(),
            borderRadius: BorderRadius.circular(22.h),
          ),
          child: Center(
              child: getAssetImage('test3.png', height: 40.h, width: 40.h)),
        ),
        getHorSpace(16.h),
        getCustomFont('Thyroid', 22.h, Colors.black, 1,
            fontWeight: FontWeight.w700),
      ],
    ).marginSymmetric(horizontal: 20.h);
  }

  Widget buildPlaceOrderButton(BuildContext context) {
    return getButton(
      context,
      accentColor,
      'Place Order',
      Colors.white,
      () {
        Constant.sendToNext(context, Routes.paymentMethodScreenRoute);
      },
      18.sp,
      weight: FontWeight.w700,
      buttonHeight: 60.h,
      borderRadius: BorderRadius.circular(22.h),
    ).marginSymmetric(horizontal: 20.h);
  }

  Widget buildDateTimeWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getCustomFont('Collection Date & Time', 16.sp, Colors.black, 1,
            fontWeight: FontWeight.w700),
        getVerSpace(10.h),
        Row(
          children: [
            Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: (){ 
                    
                  },
                  child: getDefaultTextFiledWithLabel(
                    context,
                    '${date1.month}-${date1.day}-${date1.year}',
                    dateController,
                    withSufix: true,
                    imagefunction: (){
showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      insetPadding: EdgeInsets.zero,
                      contentPadding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                      content: Container(
                        height: 200,
                        child: CupertinoDatePicker(
                          minimumYear: 2024,
                          maximumYear: 2024,
                          
                         // minimumDate: DateTime.now(),
                          // maximumDate: DateTime(DateTime.august),
                            mode: CupertinoDatePickerMode.date,
                            initialDateTime: DateTime.now(),
                            onDateTimeChanged: (DateTime newdatetime) {
                              setState(() {
                                date1 = newdatetime;
                              });
                            }),
                      ),
                    )
                    );

                    },

                    suffiximage: 'calender.svg',
                  ),
                )),
            getHorSpace(20.h),
            Expanded(
                flex: 1,
                child: getDefaultTextFiledWithLabel(
                  imagefunction: ()async{

  //                  final TimeOfDay? pickedTime = await showTimePicker(
                  
  //   context: context,
  //   initialTime: TimeOfDay.now(),
  // );
  // if (pickedTime != null) {
  //   setState(() {

  //     final now = DateTime.now();
  //     date1 = DateTime(
  //       now.year,
  //       now.month,
  //       now.day,
  //       pickedTime.hour,
  //       pickedTime.minute,
  //     );
  //      timecontroller.text = pickedTime.format(context);
  //   });
  // }
  final TimeOfDay? pickedtime= await showTimePicker(context: context, initialTime: TimeOfDay.now());
  if(pickedtime!=null){
    setState(() {
      final now=DateTime.now();
      date1=DateTime(
        now.year,
        now.day,
        now.month,
        pickedtime.hour,
        pickedtime.minute
      );
      timecontroller.text=pickedtime.format(context);
    });
  }
                  },
                    context, '${TimeOfDay.now().format(context)}'.toString(), timecontroller,

                    withSufix: true, suffiximage: 'time.svg'))
          ],
        ),
        getVerSpace(20.h),
      ],
    ).marginSymmetric(horizontal: 20.h);
  }

  Widget buildVisitWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getCustomFont('Visit', 16.sp, Colors.black, 1,
            fontWeight: FontWeight.w700),
        getVerSpace(10.h),
        Row(
            children: List.generate(2, (index) {
          return Row(
            children: [
              ObxValue(
                  (p0) => InkWell(
                        onTap: () {
                          selectedPos.value = index;
                        },
                        child: (selectedPos.value == index)
                            ? getSvgImage('radio_checked.svg',
                                height: 24.h, width: 24.h)
                            : getSvgImage('radio_unchecked.svg',
                                height: 24.h, width: 24.h),
                      ),
                  selectedPos),
              getHorSpace(10.h),
              getCustomFont(visit[index], 17.sp, Colors.black, 1,
                      fontWeight: FontWeight.w500)
                  .paddingOnly(right: 32.h)
            ],
          );
        })),
        getVerSpace(45.h)
      ],
    ).marginSymmetric(horizontal: 20.h);
  }

  Widget buildInfoWidget() {
    return getShadowDefaultContainer(
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 20.h),
      padding: EdgeInsets.all(20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getCustomFont('Beneficiary Information', 18.sp, Colors.black, 1,
              fontWeight: FontWeight.w700),
          getVerSpace(12.h),
          getDivider(),
          getVerSpace(16.h),
          getCustomFont('name', 15.sp, greyFontColor, 1,
              fontWeight: FontWeight.w500),
          getVerSpace(6.h),
          getCustomFont('Merry Fernandez', 17.sp, Colors.black, 1,
              fontWeight: FontWeight.w500),
          getDivider().marginSymmetric(vertical: 16.h),
          getCustomFont('Address', 15.sp, greyFontColor, 1,
              fontWeight: FontWeight.w500),
          getVerSpace(6.h),
          getCustomFont('715 Ash Dr. San Jose, South Dakota 83475', 17.sp,
              Colors.black, 1,
              fontWeight: FontWeight.w500),
        ],
      ),
    );
  }
}
//  showdialogbox(){
  
//   return AlertDialog(
// insetPadding: EdgeInsets.zero,
// contentPadding: EdgeInsets.zero,
// shape: RoundedRectangleBorder(
//   borderRadius: BorderRadius.circular(12)
// ),
// elevation: 0,
// content: Container(
// height: 200,
// child: CupertinoDatePicker(onDateTimeChanged: (DateTime newdatetime){

// }),
// ),
//   );
// }
    // showDialog(
    //             context: context,
    //             builder: (BuildContext context) => AlertDialog(
    //                   insetPadding: EdgeInsets.zero,
    //                   contentPadding: EdgeInsets.zero,
    //                   shape: RoundedRectangleBorder(
    //                       borderRadius: BorderRadius.circular(12)),
    //                   elevation: 0,
    //                   content: Container(
    //                     height: 200,
    //                     child: CupertinoDatePicker(
    //                         mode: CupertinoDatePickerMode.date,
    //                         initialDateTime: DateTime(1969, 1, 1),
    //                         onDateTimeChanged: (DateTime newdatetime) {
    //                           setState(() {
    //                             date1 = newdatetime;
    //                           });
    //                         }),
    //                   ),
    //                 )
    //                 );