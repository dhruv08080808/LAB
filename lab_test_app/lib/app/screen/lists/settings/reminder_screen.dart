import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lab_test_app/app/data/data_file.dart';
import 'package:lab_test_app/base/color_data.dart';
import 'package:lab_test_app/base/widget_utils.dart';

import '../../../../base/constant.dart';
import '../../../models/model_reminder.dart';
import '../../../routes/app_routes.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ReminderScreenState();
  }
}

class _ReminderScreenState extends State<ReminderScreen> {
  TextEditingController timecontroller = TextEditingController();
  DateTime date1 = DateTime(2016, 10, 28);
  void backClick() {
    Constant.backToPrev(context);
  }

  List<ModelReminder> reminderList = DataFile.reminderList;
  TextEditingController _reminderDateController =
      TextEditingController(text: "Thu 25/04/2024");
  TextEditingController _reminderTimeController =
      TextEditingController(text: '10:30 pm');
  TextEditingController _remindernameController =
      TextEditingController(text: "Add Reminder");

  void updateTimeController(TimeOfDay selectedTime) {
    // Update timeController with formatted time
    final formattedTime = selectedTime.format(context);
    _reminderTimeController.text = formattedTime; // Update timeController text
  }

// Function to handle date selection and update dateController
  void handleDateSelection(DateTime selectedDate) {
    // Update dateController with formatted date
    _reminderDateController.text =
        DateFormat('E dd/MM/yyyy').format(selectedDate);
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
              getBackAppBar(
                  context,
                  () {
                    backClick();
                  },
                  'Reminder',
                  withAction: true,
                  actionIcon: 'add.svg',
                  actionClick: () {
                    showDialog(
                      context: context,
                      builder: (context) => buildAddNewReminder(
                          context,
                          _reminderDateController,
                          _reminderTimeController,
                          _remindernameController),
                    );
                  }),
              getVerSpace(20.h),
              Expanded(
                child: (reminderList.isEmpty)
                    ? buildNoReminderWidget(context)
                    : buildReminderListView(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Column buildReminderListView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getCustomFont('Reminder me to', 17.sp, Colors.black, 1,
                fontWeight: FontWeight.w500)
            .marginSymmetric(horizontal: 20.h),
        getVerSpace(10.h),
        buildReminderList()
      ],
    );
  }

  Expanded buildReminderList() {
    return Expanded(
        child: ListView.builder(
      itemCount: reminderList.length,
      itemBuilder: (context, index) {
        ModelReminder reminder = reminderList[index];
        return getShadowDefaultContainer(
            color: Colors.white,
            margin: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
            padding: EdgeInsets.all(18.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getCustomFont(reminder.title, 16.sp, Colors.black, 1,
                        fontWeight: FontWeight.w700),
                    buildPopupMenuButton((value) {
                      handleClick(value, index);
                    }),
                  ],
                ),
                getVerSpace(18.h),
                buildDateRow(reminder)
              ],
            ));
      },
    ));
  }

  Row buildDateRow(ModelReminder reminder) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(22.h)),
              color: fillColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getSvgImage('calender.svg', height: 20.h, width: 20.h),
                getHorSpace(4.h),
                getCustomFont(reminder.date, 15.sp, Colors.black, 1,
                    fontWeight: FontWeight.w500),
              ],
            ),
          ),
        ),
        getHorSpace(20.h),
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(22.h)),
              color: fillColor,
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getSvgImage('time.svg', height: 20.h, width: 20.h),
                  getHorSpace(4.h),
                  getCustomFont(reminder.time, 15.sp, Colors.black, 1,
                      fontWeight: FontWeight.w500),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column buildNoReminderWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getNoDataWidget(context, 'No Reminder Yet!',
            'Come on, maybe we still have a \nchance', 'no_reminder_icon.svg'),
        getVerSpace(100.h),
      ],
    );
  }

  void handleClick(String value, int index) {
    switch (value) {
      case 'Edit':
        Constant.sendToNext(context, Routes.editReminderScreenRoute);
        break;
      case 'Delete':
        // Remove the reminder at the specified index from the list
        if (index >= 0 && index < reminderList.length) {
          // Remove the reminder at the specified index
          reminderList.removeAt(index);
          // Notify the ListView builder that the list has changed
          setState(() {}); // Assuming this is a StatefulWidget
        }
        break;
    }
  }

  Column buildAddNewReminder(
      BuildContext context,
      TextEditingController dateRemindercontroller,
      TextEditingController timeReminderController,
      TextEditingController namecontroller) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: AlertDialog(
            backgroundColor: Colors.white,
            title: getCustomFont('Add Reminder', 15, Colors.grey, 5),
            insetPadding: const EdgeInsets.all(10),
            content: Container(
              height: 280,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Colors.white)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getDefaultTextFiledWithLabel(
                      context, 'Enter Reminder Detail', namecontroller,
                      height: 50.h),
                  getVerSpace(15),
                  getCustomFont('Set the Date and Time', 15, Colors.grey, 4),
                  SizedBox(height: 10),
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getDefaultTextFiledWithLabel(
                          context, '', dateRemindercontroller,
                          height: 60.h,
                          withSufix: true,
                          suffiximage: 'calender.svg', onTap: () {
                        getCalenderBottomSheet(
                          context,
                          'Set Date',
                          'set',
                          dateRemindercontroller,
                          handleDateSelection,
                          withCancelBtn: true,
                        );
                      }, keyboardType: TextInputType.none),
                      getVerSpace(20.h),
                      getDefaultTextFiledWithLabel(
                          context, '', timeReminderController,
                          height: 60.h,
                          withSufix: true,
                          suffiximage: 'time.svg', onTap: () {
                        getTimeBottomSheet(context, updateTimeController);
                      }, keyboardType: TextInputType.none),
                      getVerSpace(20.h),
                      getButton(context, accentColor, "Add", Colors.white, () {
                        backClick();
                      }, 18.sp,
                              insetsGeometrypadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              weight: FontWeight.w400,
                              buttonHeight: 40.h,
                              borderRadius: BorderRadius.circular(20.h))
                          .marginSymmetric(horizontal: 14.h),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
