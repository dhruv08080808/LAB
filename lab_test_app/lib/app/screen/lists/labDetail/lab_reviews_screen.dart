import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lab_test_app/app/data/data_file.dart';
import 'package:lab_test_app/base/color_data.dart';
import 'package:lab_test_app/base/widget_utils.dart';
import '../../../../base/constant.dart';
import '../../../models/model_reviews.dart';

class LabReviewsScreen extends StatefulWidget {
  const LabReviewsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LabReviewsScreenState();
  }
}

class _LabReviewsScreenState extends State<LabReviewsScreen> {
  final TextEditingController commentcontroller = TextEditingController();
  List<bool> _isliked = [];
  List<int> _likecount = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isliked = List.generate(reviewsList.length, (index) => false);
    _likecount = List.generate(reviewsList.length, (index) => 0);
  }

  void toggle(int index) {
    setState(() {
      _isliked[index] = !_isliked[index];
      if (_isliked[index]) {
        _likecount[index]++;
      } else {
        _likecount[index]--;
      }
    });
  }

  void backClick() {
    Constant.backToPrev(context);
  }

  List<ModelReviews> reviewsList = DataFile.reviewsList;

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
              }, 'Reviews'),
              getVerSpace(20.h),
              Expanded(
                child: (reviewsList.isEmpty)
                    ? buildNoReviewView(context)
                    : buildReviewList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildReviewList() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: reviewsList.length,
      itemBuilder: (context, index) {
        ModelReviews review = reviewsList[index];
        return Column(
          children: [
            getVerSpace(20.h),
            Row(
              children: [
                getCircleImage(context, review.img, 44.h),
                getHorSpace(10.h),
                Expanded(
                    child: getCustomFont(review.name, 16.sp, Colors.black, 1,
                        fontWeight: FontWeight.w700)),
                getCustomFont(review.time, 15.sp, greyFontColor, 1,
                    fontWeight: FontWeight.w500),
              ],
            ),
            getVerSpace(6.h),
            getMultilineCustomFont(review.review, 17.sp, Colors.black,
                    fontWeight: FontWeight.w500, txtHeight: 1.7.h)
                .marginOnly(left: 54.h),
            getVerSpace(10.h),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            showDialog(
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
                                });
                          },
                          child: getSvgImage('comment.svg',
                              height: 20.h, width: 20.h)),
                      getHorSpace(14.h),
                      GestureDetector(
                        onTap: () {
                          toggle(index);
                        },
                        child: Column(
                          children: [
                            _isliked[index]
                                ? Container(
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: getSvgImage(
                                      'heart.svg',
                                      height: 20.h,
                                      width: 20.h,
                                      color: Colors.black,
                                    ),
                                  )
                                : getSvgImage('heart.svg',
                                    height: 20.h, width: 20.h),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Foward To'),
                              content: Container(
                                  height: 100.h,
                                  child: Row(children: [
                                    getCircleImage(context, review.img, 44.h),
                                    getHorSpace(10.h),
                                    Expanded(
                                        child: getCustomFont(
                                            review.name, 16.sp, Colors.black, 1,
                                            fontWeight: FontWeight.w700)),
                                    getButton(
                                      insetsGeometrypadding: EdgeInsets.all(10),
                                      context,
                                      accentColor,
                                      'Send',
                                      Colors.white,
                                      () {
                                        navigator!.pop(context);
                                      },
                                      18.sp,
                                      weight: FontWeight.w700,
                                      buttonHeight: 60.h,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(22.h)),
                                    )
                                  ])),
                            );
                          });
                    },
                    child: getSvgImage('share.svg', height: 20.h, width: 20.h)),
              ],
            ).marginOnly(left: 54.h),
            getVerSpace(20.h),
            getDivider(),
          ],
        );
      },
    ).marginSymmetric(horizontal: 20.h);
  }

  Column buildNoReviewView(BuildContext context) {
    return Column(
      children: [
        getVerSpace(161.h),
        getNoDataWidget(context, 'No Reviews Yet!',
            'Come on, maybe we still have a \nchance', "no_rating_icon.svg"),
      ],
    );
  }
}
