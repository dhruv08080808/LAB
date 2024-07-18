import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lab_test_app/base/color_data.dart';
import 'package:lab_test_app/base/constant.dart';
import 'package:lab_test_app/base/widget_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../routes/app_routes.dart';

class SpecialistDetailScreen extends StatefulWidget {
  const SpecialistDetailScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SpecialistDetailScreenState();
  }
}

class _SpecialistDetailScreenState extends State<SpecialistDetailScreen> {
  
  _makephonecall()async{
var url=Uri.parse("tel:9876543210");
if(await canLaunchUrl(url)){
  await launchUrl(url);
}else{
  throw "could not launch url $url";
}
  }
  TextEditingController commentcontroller =TextEditingController();
  File?selectedvideocall;
  File pickedvideocallimage = File("");
  ImagePicker pick=ImagePicker();
  Future getvideocall()async{
final pickedvideocall=await pick.pickImage(source:ImageSource.camera );
setState(() {
  if(pickedvideocall!=null){
    selectedvideocall=File(pickedvideocall.path);
  }
});
  }
  void backClick() {
    Constant.backToPrev(context);
  }

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
          body: Column(children: [
            buildTopProfileView(),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  // getVerSpace(26.h),
                  getCustomFont('Dr. John Fox', 24.sp, Colors.black, 1,
                      fontWeight: FontWeight.w700, textAlign: TextAlign.center),
                  getVerSpace(5.h),
                  getCustomFont('Scientist', 17.sp, greyFontColor, 1,
                      fontWeight: FontWeight.w500, textAlign: TextAlign.center),
                  getVerSpace(20.h),
                  buildSpecialistContactTab(),
                  getVerSpace(20.h),
                  buildSpecialistReviewRow(),
                  getVerSpace(30.h),
                  buildAboutSpecialistRow(context),
                  getVerSpace(24.h),
                  getCustomFont('Biography', 18.sp, Colors.black, 1,
                      fontWeight: FontWeight.w700),
                  getVerSpace(6.h),
                  buildDescView(),
                  getVerSpace(24.h),
                  buildLocationView(context),
                  buildMakeAppointmentButton(context)
                ],
              ).marginSymmetric(horizontal: 20.h),
            )
          ])),
    );
  }

  Widget buildMakeAppointmentButton(BuildContext context) {
    return getButton(context, accentColor, "Make Appointment", Colors.white,
            () {
      Constant.sendToNext(context, Routes.testsListsScreenRoute);
    }, 18.sp,
            weight: FontWeight.w700,
            buttonHeight: 60.h,
            borderRadius: BorderRadius.circular(22.h))
        .marginSymmetric(vertical: 30.h);
  }

  Wrap buildLocationView(BuildContext context) {
    return Wrap(
      children: [
        getCustomFont('Location', 18.sp, Colors.black, 1,
            fontWeight: FontWeight.w700),
        getVerSpace(6.h),
        getCircularImage(context, double.infinity, 117.h, 22.h, 'loc.png',
            boxFit: BoxFit.cover)
      ],
    );
  }

  Widget buildDescView() {
    return getMultilineCustomFont(
        'A scientist is a person who conducts scientific research to advance knowledge in an area of interest. Scientists are motivated to work in several ways',
        17.sp,
        greyFontColor,
        fontWeight: FontWeight.w500,
        txtHeight: 2.h);
  }

  Row buildAboutSpecialistRow(BuildContext context) {
    return Row(
      children: [
        getTabContainer(context, 'F9F8FF', 'EDE8FE', 'Scientist', '\$50.00'),
        getHorSpace(13.h),
        getTabContainer(
            context, '#FFF8F8', '#FEE8E8', 'Experience', '10 Years'),
        getHorSpace(13.h),
        getTabContainer(context, 'FFFBF4', 'FDF1E7', 'Patients', '200+')
      ],
    );
  }

  Row buildSpecialistReviewRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getSvgImage('star.svg', height: 24.h, width: 24.h),
        getHorSpace(10.h),
        getRichText('4.8 ', Colors.black, FontWeight.w500, 17.sp,
            '(523Reviews)', greyFontColor, FontWeight.w500, 17.sp)
      ],
    );
  }

  Row buildSpecialistContactTab() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: (){ showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Add Comment'),
                                    content: Container(
                                      height: 160.h,
                                      child: Column(
                                        children: [
                                          getDefaultTextFiledWithLabel(
                                            context,
                                            "Enter your Comment",
                                            commentcontroller,
                                            isEnable: false,
                                            height: 60.h,
                                          ),
                                          getVerSpace(20),
                                          getButton(
                                            context,
                                            accentColor,
                                            'Submit',
                                            Colors.white,
                                            () {
                                              navigator!.pop(context);
                                            },
                                            18.sp,
                                            weight: FontWeight.w700,
                                            buttonHeight: 40.h,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(22.h)),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                });},
          child: getImageButtonWithSize('chat.svg')),
        getHorSpace(20.h),
        GestureDetector(
          onTap: (){
            _makephonecall();
          },
          child: getImageButtonWithSize('call.svg')),
        getHorSpace(20.h),
        GestureDetector(
          onTap: ()async{
            final pickvideo=await pick.pickImage(
              imageQuality: 50,
                      maxHeight: 500,
                      maxWidth: 500,
              source: ImageSource.camera);
              setState(() {
                if(pickvideo==null){
                  pickedvideocallimage=File(pickvideo!.path);
                }
              });
          },
          child: getImageButtonWithSize('video.svg')),
      ],
    );
  }

  Container buildTopProfileView() {
    return Container(
      height: 285.h,
      width: double.infinity,
      decoration: BoxDecoration(
          color: speBackColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(22.h),
              bottomRight: Radius.circular(22.h))),
      child: Column(
        children: [
          getVerSpace(64.h),
          Stack(
            children: [
              getBackIcon(() {
                backClick();
              }),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: getAssetImage('detail_img.png', height: 221.h))
            ],
          ),
        ],
      ),
    );
  }
}

Widget getTabContainer(BuildContext context, String bgColor, String borderColor,
    String title, String subtitle) {
  return Expanded(
      child: Container(
    height: 78.h,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(22.h)),
        color: bgColor.toColor(),
        border: Border.all(color: borderColor.toColor(), width: 1.w)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getCustomFont(
          title,
          15.sp,
          Colors.black,
          1,
          fontWeight: FontWeight.w500,
        ),
        getVerSpace(6.h),
        getCustomFont(
          subtitle,
          16.sp,
          Colors.black,
          1,
          fontWeight: FontWeight.w700,
        ),
      ],
    ),
  ));
}
