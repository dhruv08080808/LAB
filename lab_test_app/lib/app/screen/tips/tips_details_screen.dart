import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:lab_test_app/app/data/data_file.dart';
import 'package:lab_test_app/app/models/tips_details_model.dart';
import 'package:lab_test_app/base/color_data.dart';
import 'package:lab_test_app/base/constant.dart';
import 'package:lab_test_app/base/widget_utils.dart';

class TopTipsDetailsScreen extends StatefulWidget {
  const TopTipsDetailsScreen({super.key});

  @override
  State<TopTipsDetailsScreen> createState() => _TopTipsDetailsScreenState();
}

class _TopTipsDetailsScreenState extends State<TopTipsDetailsScreen> {
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
        extendBodyBehindAppBar: true,
        body: Column(
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: [
                  Stack(
                    children: [
                      buildTopImageView(),
                      Column(
                        children: [
                          getVerSpace(40.h),
                          getBackAppBar(context, () {
                            backClick();
                          }, '', isDivider: false, iconColor: Colors.white),
                          // Align(alignment: Alignment.centerLeft,child: getBackIcon((){},color: Colors.white)),
                          getVerSpace(140.h),
                          buildAbouTipContainer()
                        ],
                      ).marginSymmetric(horizontal: 20.h),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildTopImageView() {
    return Container(
      height: 297.h,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(22.h),
              bottomRight: Radius.circular(22.h)),
          image: DecorationImage(
            image: AssetImage('${Constant.assetImagePath}lab.png'),
            fit: BoxFit.cover,
          )),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0x99000000), Color(0x00000000)],
          ),
        ),
      ),
    );
  }

  Widget buildAbouTipContainer() {
    List<ModelTopTipsDetails> detailsDataList = DataFile.topTipsDetailsList;

    return getShadowDefaultContainer(
      height: MediaQuery.of(context).size.height * 0.7,
      width: double.infinity,
      // margin: EdgeInsets.symmetric(horizontal: 20.h),
      padding: EdgeInsets.all(20.h),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getCustomFont('Title', 22.sp, Colors.black, 1,
              fontWeight: FontWeight.w700),
          getVerSpace(14.h),
          Expanded(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              padding: EdgeInsets.all(20.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(22.h)),
                color: 'F8F8FC'.toColor(),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    getCustomParaFont(
                        'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.\nThe standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.',
                        15.sp,
                        Colors.black,
                        fontWeight: FontWeight.w500),
                        getCustomParaFont(
                        'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.\nThe standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.',
                        15.sp,
                        Colors.black,
                        fontWeight: FontWeight.w500),
                    getVerSpace(20.h),

                    // getVerSpace(20.h),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Row buildContactRow(String text, String icon) {
    return Row(
      children: [
        getSvgImage(icon, height: 20.h, width: 20.h),
        getHorSpace(8.h),
        getCustomFont(text, 17.sp, Colors.black, 1, fontWeight: FontWeight.w500)
      ],
    );
  }
}
