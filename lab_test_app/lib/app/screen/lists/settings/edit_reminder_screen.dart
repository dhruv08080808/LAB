import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lab_test_app/base/color_data.dart';
import 'package:lab_test_app/base/widget_utils.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../base/constant.dart';

class EditReminderScreen extends StatefulWidget {
  const EditReminderScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _EditReminderScreenState();
  }
}

class _EditReminderScreenState extends State<EditReminderScreen> {
  void backClick() {
    Constant.backToPrev(context);
  }

  TextEditingController titleController =
      TextEditingController(text: 'Lab Report Acchive');
  TextEditingController dateController =
      TextEditingController(text: "Thu 25/07/2022");
  void updateDateController(DateTime selectedDate) {
    dateController.text = DateFormat('E dd/MM/yyyy').format(selectedDate);
  }

  TextEditingController timeController =
      TextEditingController(text: '10:30 pm');

  void updateTimeController(TimeOfDay selectedTime) {
    // Update timeController with formatted time
    final formattedTime = selectedTime.format(context);
    timeController.text = formattedTime; // Update timeController text
  }

// Function to handle date selection and update dateController
  void handleDateSelection(DateTime selectedDate) {
    // Update dateController with formatted date
    dateController.text = DateFormat('E dd/MM/yyyy').format(selectedDate);
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
            }, 'Edit Reminder'),
            getVerSpace(20.h),
            buildTextField(context),
            buildSaveButton(context),
            getVerSpace(30.h),
          ],
        )),
      ),
    );
  }

  Expanded buildTextField(BuildContext context) {
    return Expanded(
      child: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getCustomFont('Reminder me to', 17.sp, Colors.black, 1,
              fontWeight: FontWeight.w500),
          getVerSpace(10.h),
          getDefaultTextFiledWithLabel(
            context,
            '',
            titleController,
            height: 60.h,
          ),
          getVerSpace(20.h),
          getDefaultTextFiledWithLabel(context, '', dateController,
              height: 60.h,
              withSufix: true,
              suffiximage: 'calender.svg', onTap: () {
            getCalenderBottomSheet(
              context,
              'Set Date',
              'set',
              dateController,
              handleDateSelection,
              withCancelBtn: true,
            );
          }, keyboardType: TextInputType.none),
          getVerSpace(20.h),
          getDefaultTextFiledWithLabel(context, '', timeController,
              height: 60.h,
              withSufix: true,
              suffiximage: 'time.svg', onTap: () {
            getTimeBottomSheet(context, updateTimeController);
          }, keyboardType: TextInputType.none),
        ],
      ).marginSymmetric(horizontal: 20.h),
    );
  }

  Widget buildSaveButton(BuildContext context) {
    return getButton(
      context,
      accentColor,
      'Save',
      Colors.white,
      () {
        backClick();
      },
      18.sp,
      weight: FontWeight.w700,
      buttonHeight: 60.h,
      borderRadius: BorderRadius.all(Radius.circular(22.h)),
    ).marginSymmetric(horizontal: 20.h);
  }
}
