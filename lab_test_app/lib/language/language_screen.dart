import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lab_test_app/app/data/data_file.dart';
import 'package:lab_test_app/app/models/model_language.dart';
import 'package:lab_test_app/base/widget_utils.dart';

import '../../../../base/constant.dart';

class Language extends StatefulWidget {
  const Language({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LanguageState();
  }
}

class _LanguageState extends State<Language> {
List<ModelLanguage>languagelist=DataFile.listoflanguage;

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
                  }, 'Language'),
                  getVerSpace(20.h),
                  getCustomFont('Supported Languages', 17.sp, Colors.black, 1,
                          fontWeight: FontWeight.w500)
                      .marginSymmetric(horizontal: 20.h),
                  getVerSpace(10.h),
                  listoflanguage(),

                ])
                
                
                )
                
                ));
  }
  Expanded listoflanguage(){
    return Expanded(
      flex: 1,
      child:
     ListView.builder(
        itemCount:languagelist.length,
      
      itemBuilder:(context,i){
        ModelLanguage languagename=languagelist[i];
        return GestureDetector(
          onTap: (){

          },
          child:getShadowDefaultContainer(
            height: 50.h,
            
           color: Colors.blue.shade200,
            margin: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
         child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            child: getCustomFont(languagename.name,18.sp , Colors.black, 1,fontWeight: FontWeight.w500,),
          )
         ],)
          ) ,
        );
      }
      
       ));
  }
}
