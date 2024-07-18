import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:lab_test_app/app/data/data_file.dart';
import 'package:lab_test_app/app/models/model_tips.dart';
import 'package:lab_test_app/app/routes/app_routes.dart';
import 'package:lab_test_app/base/constant.dart';
import 'package:lab_test_app/base/widget_utils.dart';

class TipsPage extends StatefulWidget {
  const TipsPage({super.key});

  @override
  State<TipsPage> createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage> {
  void backClick() {
    Constant.backToPrev(context);
  }

  List<ModelTopTips> topTipsList = DataFile.toptipsList;

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
                }, 'Tips'),
                getVerSpace(20.h),
                buildTipsListView()
              ],
            ),
          )),
    );
  }

  Expanded buildTipsListView() {
    return Expanded(
      child: ListView.builder(
        itemCount: topTipsList.length,
        itemBuilder: (context, index) {
          ModelTopTips tips = topTipsList[index];
          return GestureDetector(
            onTap: () {
              Constant.sendToNext(context, Routes.topTipsDetailsScreenRoute);
            },
            child: getShadowDefaultContainer(
              height: 130.h,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
              color: Colors.white,
              child: Row(
                children: [
                  getCircularImage(context, 106.h, 106.h, 22.h, tips.img,
                          boxFit: BoxFit.cover)
                      .marginSymmetric(horizontal: 12.h),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getCustomFont(tips.title, 18.sp, Colors.black, 1,
                            fontWeight: FontWeight.w700),
                        getVerSpace(5.h),
                        getCustomFont(tips.content, 18.sp, Colors.black, 1,
                            fontWeight: FontWeight.w700),
                      ],
                    ).marginSymmetric(horizontal: 4.h),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
