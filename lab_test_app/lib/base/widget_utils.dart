import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'color_data.dart';
import 'constant.dart';
import 'package:http/http.dart' as http;

Widget getVerSpace(double verSpace) {
  return SizedBox(
    height: verSpace,
  );
}

Widget getAssetImage(String image,
    {double? width,
    double? height,
    Color? color,
    BoxFit boxFit = BoxFit.contain}) {
  return Image.asset(
    Constant.assetImagePath + image,
    color: color,
    width: width,
    height: height,
    fit: boxFit,
  );
}

initializeScreenSize(BuildContext context,
    {double width = 414, double height = 896}) {
  ScreenUtil.init(context, designSize: Size(width, height), minTextAdapt: true);
}

getColorStatusBar(Color? color) {
  return AppBar(
    backgroundColor: color,
    toolbarHeight: 0,
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
        systemNavigationBarColor: color, statusBarColor: color),
  );
}

Widget getSvgImage(String image,
    {double? width,
    double? height,
    Color? color,
    BoxFit boxFit = BoxFit.contain}) {
  return SvgPicture.asset(
    Constant.assetImagePath + image,
    color: color,
    width: width,
    height: height,
    fit: boxFit,
  );
}

Widget getCustomFont(
    String text, double fontSize, Color fontColor, int? maxLine,
    {String fontFamily = Constant.fontsFamily,
    TextOverflow overflow = TextOverflow.ellipsis,
    TextDecoration decoration = TextDecoration.none,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign textAlign = TextAlign.start,
    txtHeight}) {
  return Text(
    text,
    overflow: overflow,
    style: TextStyle(
        decoration: decoration,
        fontSize: fontSize,
        fontStyle: FontStyle.normal,
        color: fontColor,
        fontFamily: fontFamily,
        height: txtHeight,
        fontWeight: fontWeight),
    maxLines: maxLine,
    softWrap: true,
    textAlign: textAlign,
  );
}

Widget getMultilineCustomFont(String text, double fontSize, Color fontColor,
    {String fontFamily = Constant.fontsFamily,
    TextOverflow overflow = TextOverflow.ellipsis,
    TextDecoration decoration = TextDecoration.none,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign textAlign = TextAlign.start,
    txtHeight = 1.0}) {
  return Text(
    text,
    style: TextStyle(
        decoration: decoration,
        fontSize: fontSize,
        fontStyle: FontStyle.normal,
        color: fontColor,
        fontFamily: fontFamily,
        height: txtHeight,
        fontWeight: fontWeight),
    textAlign: textAlign,
  );
}

BoxDecoration getButtonDecoration(Color bgColor,
    {BorderRadius? borderRadius,
    Border? border,
    List<BoxShadow> shadow = const [],
    DecorationImage? image}) {
  return BoxDecoration(
      color: bgColor,
      borderRadius: borderRadius,
      border: border,
      boxShadow: shadow,
      image: image);
}

Widget getHorSpace(double verSpace) {
  return SizedBox(
    width: verSpace,
  );
}

Widget getButton(BuildContext context, Color bgColor, String text,
    Color textColor, Function function, double fontsize,
    {bool isBorder = false,
    EdgeInsetsGeometry? insetsGeometry,
    borderColor = Colors.transparent,
    FontWeight weight = FontWeight.bold,
    bool isIcon = false,
    String? image,
    Color? imageColor,
    double? imageWidth,
    double? imageHeight,
    bool smallFont = false,
    double? buttonHeight,
    double? buttonWidth,
    List<BoxShadow> boxShadow = const [],
    EdgeInsetsGeometry? insetsGeometrypadding,
    BorderRadius? borderRadius,
    double? borderWidth}) {
  return InkWell(
    onTap: () {
      function();
    },
    child: Container(
      margin: insetsGeometry,
      padding: insetsGeometrypadding,
      width: buttonWidth,
      height: buttonHeight,
      decoration: getButtonDecoration(
        bgColor,
        borderRadius: borderRadius,
        shadow: boxShadow,
        border: (isBorder)
            ? Border.all(color: borderColor, width: borderWidth!)
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          (isIcon) ? getSvgImage(image!) : getHorSpace(0),
          (isIcon) ? getHorSpace(15.h) : getHorSpace(0),
          getCustomFont(text, fontsize, textColor, 1,
              textAlign: TextAlign.center,
              fontWeight: weight,
              fontFamily: Constant.fontsFamily)
        ],
      ),
    ),
  );
}

Widget loginAppBar(Function function) {
  return Stack(
    children: [
      GestureDetector(
        onTap: () {
          function();
        },
        child: getSvgImage("arrow_back.svg", height: 24.h, width: 24.h)
            .marginOnly(top: 10.h),
      ),
      Align(
        alignment: Alignment.topCenter,
        child:
            getAssetImage("title_logo.png", width: 190.48.h, height: 114.28.h),
      )
    ],
  );
}

Widget loginHeader(String title, String description) {
  return Column(
    children: [
      getCustomFont(title, 24.sp, Colors.black, 1,
          fontWeight: FontWeight.w700, txtHeight: 1.5.h),
      getVerSpace(10.h),
      getMultilineCustomFont(description, 17.sp, Colors.black,
          fontWeight: FontWeight.w500,
          txtHeight: 1.7.h,
          textAlign: TextAlign.center)
    ],
  );
}

Widget getDefaultTextFiledWithLabel(
  BuildContext context,
  String s,
  TextEditingController textEditingController, {
  bool withSufix = false,
  bool minLines = false,
  bool isPass = false,
  bool isEnable = true,
  bool isprefix = false,
  Widget? prefix,
  double? height,
  String? suffiximage,
  Function? imagefunction,
  List<TextInputFormatter>? inputFormatters,
  FormFieldValidator<String>? validator,
  BoxConstraints? constraint,
  ValueChanged<String>? onChanged,
  double vertical = 20,
  double horizontal = 20,
  double suffixHeight = 24,
  double suffixWidth = 24,
  double suffixRightPad = 18,
  int? length,
  String obscuringCharacter = '•',
  GestureTapCallback? onTap,
  bool isReadonly = false,
  TextInputType? keyboardType,
}) {
  return StatefulBuilder(
    builder: (context, setState) {
      return SizedBox(
        height: height,
        child: TextFormField(
          readOnly: isReadonly,
          onTap: onTap,
          onChanged: onChanged,
          validator: validator,
          enabled: true,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          maxLines: (minLines) ? null : 1,
          controller: textEditingController,
          obscuringCharacter: obscuringCharacter,
          autofocus: false,
          obscureText: isPass,
          showCursor: true,
          cursorColor: accentColor,
          maxLength: length,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 17.sp,
              fontFamily: Constant.fontsFamily),
          decoration: InputDecoration(
              counterText: "",
              contentPadding: EdgeInsets.symmetric(
                  vertical: vertical.h, horizontal: horizontal.h),
              isDense: true,
              filled: true,
              fillColor: fillColor,
              suffixIconConstraints: BoxConstraints(
                maxHeight: suffixHeight.h,
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(22.h),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(22.h),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(22.h),
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(22.h),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(22.h),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(22.h),
              ),
              suffixIcon: withSufix
                  ? GestureDetector(
                      onTap: () {
                        imagefunction!();
                      },
                      child: getSvgImage(suffiximage.toString(),
                              width: suffixWidth.h, height: suffixHeight.h)
                          .paddingOnly(right: suffixRightPad.h))
                  : null,
              errorStyle: TextStyle(
                  color: redColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 15.sp,
                  fontFamily: Constant.fontsFamily,
                  height: 1.4.h),
              prefixIconConstraints: constraint,
              prefixIcon: isprefix == true ? prefix : null,
              hintText: s,
              hintStyle: TextStyle(
                  color: skipColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 17.sp,
                  fontFamily: Constant.fontsFamily)),
        ),
      );
    },
  );
}

Widget getImageButton(String image, {double? height, double? width}) {
  return Expanded(
    child: Container(
      height: height,
      width: width,
      padding: EdgeInsets.symmetric(vertical: 18.h),
      decoration: BoxDecoration(
          color: fillColor, borderRadius: BorderRadius.circular(22.h)),
      child: getSvgImage(image, height: 24.h, width: 24.h),
    ),
  );
}

Widget getImageButtonWithSize(String image, {Color imageColor = Colors.black}) {
  return Container(
    height: 60.h,
    width: 60.h,
    decoration: BoxDecoration(
        color: fillColor, borderRadius: BorderRadius.circular(22.h)),
    child: Center(
        child:
            getSvgImage(image, height: 24.h, width: 24.h, color: imageColor)),
  );
}

Widget getRichText(
    String firstText,
    Color firstColor,
    FontWeight firstWeight,
    double firstSize,
    String secondText,
    Color secondColor,
    FontWeight secondWeight,
    double secondSize,
    {TextAlign textAlign = TextAlign.center,
    double? txtHeight,
    Function? function}) {
  return RichText(
    textAlign: textAlign,
    text: TextSpan(
        text: firstText,
        style: TextStyle(
          color: firstColor,
          fontWeight: firstWeight,
          fontFamily: Constant.fontsFamily,
          fontSize: firstSize,
          height: txtHeight,
        ),
        children: [
          TextSpan(
              text: secondText,
              style: TextStyle(
                  color: secondColor,
                  fontWeight: secondWeight,
                  fontFamily: Constant.fontsFamily,
                  fontSize: secondSize,
                  height: txtHeight),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  function!();
                }),
        ]),
  );
}

Widget getBackIcon(Function function, {Color? color}) {
  return GestureDetector(
      onTap: () {
        function();
      },
      child:
          getSvgImage('arrow_back.svg', height: 24.h, width: 24.h, color: color)
              .marginSymmetric(horizontal: 20.h));
}

Widget getBackAppBar(BuildContext context, Function backClick, String title,
    {Color fontColor = Colors.black,
    Color iconColor = Colors.black,
    bool isDivider = true,
    bool withLeading = true,
    bool withAction = false,
    String? actionIcon,
    Function? actionClick}) {
  return SizedBox(
    height: 60.h,
    child: Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: (withLeading)
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: getBackIcon(() {
                        backClick();
                      }, color: iconColor),
                    )
                  : const SizedBox(),
            ),
            (withAction)
                ? Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                        onTap: () {
                          actionClick!();
                        },
                        child:
                            getSvgImage(actionIcon!, height: 24.h, width: 24.h)
                                .marginSymmetric(horizontal: 20.h)))
                : const SizedBox(),
          ],
        ),
        Center(
          child: getCustomFont(title, 24.sp, fontColor, 1,
              fontWeight: FontWeight.w700, textAlign: TextAlign.center),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: (isDivider) ? getDivider() : null)
      ],
    ),
  );
}

Widget getDivider(
    {double dividerHeight = 2,
    Color setColor = Colors.grey,
    double endIndent = 0,
    double indent = 0}) {
  return Divider(
    height: dividerHeight.h,
    color: fillColor,
    endIndent: endIndent,
    indent: indent,
    thickness: 2.h,
  );
}

TextStyle buildTextStyle(BuildContext context, Color fontColor,
    FontWeight fontWeight, double fontSize,
    {double txtHeight = 1}) {
  return TextStyle(
      color: fontColor,
      fontWeight: fontWeight,
      fontFamily: Constant.fontsFamily,
      fontSize: fontSize,
      height: txtHeight);
}

Widget getCircularImage(BuildContext context, double width, double height,
    double radius, String img,
    {BoxFit boxFit = BoxFit.contain}) {
  return SizedBox(
    height: height,
    width: width,
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: getAssetImage(img, width: width, height: height, boxFit: boxFit),
    ),
  );
}

Widget getCircleImage(BuildContext context, String imgName, double size,
    {bool fileImage = false}) {
  return SizedBox(
    width: size,
    height: size,
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(size / 2)),
      child: (fileImage) ? Image.file(File(imgName)) : getAssetImage(imgName),
    ),
  );
}

Row buildLocationRow(String location) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      getSvgImage('location.svg', height: 20.h, width: 20.h),
      getHorSpace(4.h),
      getCustomFont(location, 15.sp, greyFontColor, 1,
          fontWeight: FontWeight.w500),
    ],
  );
}

Widget getShadowDefaultContainer(
    {double? height,
    double? width,
    EdgeInsets? margin,
    EdgeInsets? padding,
    Color? color,
    Widget? child,
    double radius = 22}) {
  return Container(
    height: height,
    width: width,
    margin: margin,
    padding: padding,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(radius.h),
      boxShadow: [
        BoxShadow(
          color: const Color(0x289a90b8),
          blurRadius: 32.h,
          offset: Offset(0, 9),
        ),
      ],
      color: color,
    ),
    child: child,
  );
}

Widget getNoDataText(String title, String description) {
  return Column(
    children: [
      getCustomFont(title, 24.sp, Colors.black, 1,
          fontWeight: FontWeight.w700, txtHeight: 1.5.h),
      getVerSpace(10.h),
      getMultilineCustomFont(description, 17.sp, Colors.black,
          fontWeight: FontWeight.w500,
          txtHeight: 1.7.h,
          textAlign: TextAlign.center)
    ],
  );
}

Widget getNoDataWidget(
    BuildContext context, String title, String desc, String img,
    {bool withButton = false, String btnText = '', Function? btnClick}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        alignment: Alignment.center,
        height: 171.h,
        width: 314.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35.h),
            gradient: RadialGradient(
                colors: [gradientFirst, gradientSecond, gradientFirst],
                stops: const [0.0, 0.49, 1.0])),
        child: getSvgImage(img, width: 104.h, height: 104.h),
      ),
      getVerSpace(30.h),
      getNoDataText(title, desc),
      (withButton) ? getVerSpace(30.h) : getVerSpace(0.h),
      (withButton)
          ? getButton(context, Colors.transparent, btnText, accentColor, () {
              btnClick!();
            }, 18.sp,
              weight: FontWeight.w700,
              isBorder: true,
              borderColor: accentColor,
              borderRadius: BorderRadius.all(Radius.circular(22.h)),
              borderWidth: 2.h,
              buttonHeight: 60.h,
              buttonWidth: 184.h)
          : getVerSpace(0.h),
    ],
  );
}

Widget getIconContainer(double height, double width, Color color, String icon,
    {double iconSize = 30}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.all(Radius.circular(22.h)),
    ),
    child:
        Center(child: getSvgImage(icon, height: iconSize.h, width: iconSize.h)),
  );
}

Padding getSearchTextFieldWidget(
  BuildContext context,
  double height,
  String hintText,
  TextEditingController controller, {
  Function(String)? onChanged, // Optional callback function
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: getDefaultTextFiledWithLabel(
      context,
      hintText,
      controller,
      isprefix: true,
      height: height,
      prefix: Row(
        children: [
          SizedBox(width: 16),
          getSvgImage('search.svg', height: 24, width: 24),
          SizedBox(width: 13),
        ],
      ),
      constraint: BoxConstraints(maxHeight: 24, maxWidth: 55),
      onChanged: onChanged, // Pass the onChanged callback to the text field
    ),
  );
}
  PopupMenuButton<String> popupmenuopition(){
return PopupMenuButton<String>(

    color: Colors.white,
    padding: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(22.h))),
    elevation: 2.h,
  itemBuilder: (BuildContext context) {
  return {'Edit', 'Delete'}.map((String choice) {
        return PopupMenuItem<String>(
          padding: EdgeInsets.zero,
          value: choice,
          height: 45.h,
          enabled: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getVerSpace(10.h),
              getCustomFont(choice, 15.sp, Colors.black, 1,
                      fontWeight: FontWeight.w500)
                  .paddingSymmetric(horizontal: 14.h),
              (choice == 'Edit')
                  ? getDivider().paddingOnly(top: 20.h)
                  : getVerSpace(0),
            ],
          ),
        );
      }).toList();
});
  } 
PopupMenuButton<String> buildPopupMenuButton(
    PopupMenuItemSelected handleClick) {
  return PopupMenuButton<String>(
    onSelected: handleClick,
    color: Colors.white,
    padding: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(22.h))),
    elevation: 2.h,
    itemBuilder: (BuildContext context) {
      return {'Edit', 'Delete'}.map((String choice) {
        return PopupMenuItem<String>(
          padding: EdgeInsets.zero,
          value: choice,
          height: 45.h,
          enabled: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getVerSpace(10.h),
              getCustomFont(choice, 15.sp, Colors.black, 1,
                      fontWeight: FontWeight.w500)
                  .paddingSymmetric(horizontal: 14.h),
              (choice == 'Edit')
                  ? getDivider().paddingOnly(top: 20.h)
                  : getVerSpace(0),
            ],
          ),
        );
      }).toList();
    },
    child: getSvgImage('menu.svg', height: 24.h, width: 24.h),
  );
}

InkWell buildDefaultTabWidget(
    String color, String icon, String title, Function function) {
  return InkWell(
    onTap: () {
      function();
    },
    child: Row(
      children: [
        getIconContainer(60.h, 60.h, color.toColor(), icon, iconSize: 24),
        getHorSpace(14.h),
        Expanded(
            child: getCustomFont(title, 17.sp, Colors.black, 1,
                fontWeight: FontWeight.w500)),
        getSvgImage('arrow_right.svg', height: 24.h, width: 24.h)
      ],
    ),
  );
}

Future<void> downloadFile(String url, String fileName) async {
  // Get temporary directory path using path_provider package
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;

  // Construct the file path for the downloaded file
  String filePath = '$tempPath/$fileName';

  // Send an HTTP GET request to download the file
  http.Response response = await http.get(Uri.parse(url));

  // Check if the request was successful (status code 200)
  if (response.statusCode == 200) {
    // Write the file to the temporary directory
    File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);

    // Show a message indicating that the file has been downloaded
    print('File downloaded to: $filePath');
  } else {
    // Handle the error if the request was not successful
    throw Exception('Failed to download file: ${response.statusCode}');
  }
}

class AlertDialogg extends StatelessWidget {
  const AlertDialogg({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: getCustomFont('Contact Us', 18, Colors.grey, 10),
//const Text('Contact Us',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.grey),),
      insetPadding: const EdgeInsets.all(10),
      content: Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              getIconContainer(60.h, 60.h, Colors.green.shade100, 'email.svg',
                  iconSize: 24),
              getHorSpace(10),
              getCustomFont('labsupport@austere.co.in', 18, Colors.blue, 18),
              //const   mailto:text('labsupport@austere.co.in',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300,color: Colors.blue)),
            ]),
            getVerSpace(10),
            Row(children: [
              getIconContainer(60.h, 60.h, Colors.yellow.shade100, 'phone.svg',
                  iconSize: 24),
              getHorSpace(10),
              getCustomFont('+91 7720083881', 18, Colors.black, 12),
              //const Text('+91 7720083881 ',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.black)),
            ]),
            // Text('Email : mailto:labsupport@austere.co.in ',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300)),
            //   Text('Phone : 7720083881 ',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300)),
          ],
        ),
      ),
    );
  }
}

Widget privacy() {
  return AlertDialog(
    backgroundColor: Colors.white,
    title: getCustomFont('Privacy Policy', 20, Colors.grey, 5),
    insetPadding: const EdgeInsets.all(10),
    content: Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white)),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getCustomFont(
                'A mobile app privacy policy is an official document that outlines how an app collects, stores, utilizes, and transmits user data123. It should be readily accessible and clearly describe the apps privacy rules. Key points to include in a privacy policy are:What personal information (PI) is collected How the personal information is collected Recently, we’ve seen an increase in data breaches, so it makes sense that privacy is a growing concern among consumers. Posting a mobile app privacy policy helps ease your users’ concerns and give them confidence in your app because they’ll know their personal information is safe.Just take a look at these alarming data privacy statistics emphasizing the importance for companies to be honest about their data collection practices:As data protection laws related to mobile applications continue to expand, the definition of PI can change, and privacy policies are a great place to explain that information to your consumers.For example, the CPRA came into force on January 1, 2023, and introduced a new category of sensitive personal information subject to stricter privacy requirements.Similarly, ways to determine an individual’s identity through an IP address have progressed far enough that it was added to the GDPR’s list of protected personal information',
                14,
                Colors.black,
                100)
            // Text('A mobile app privacy policy is an official document that outlines how an app collects, stores, utilizes, and transmits user data123. It should be readily accessible and clearly describe the apps privacy rules. Key points to include in a privacy policy are:What personal information (PI) is collected How the personal information is collected Recently, we’ve seen an increase in data breaches, so it makes sense that privacy is a growing concern among consumers. Posting a mobile app privacy policy helps ease your users’ concerns and give them confidence in your app because they’ll know their personal information is safe.Just take a look at these alarming data privacy statistics emphasizing the importance for companies to be honest about their data collection practices:')
          ],
        ),
      ),
    ),
  );
}

Widget addRemainder(
  BuildContext context,
  TextEditingController controller, {
  double suffixHeight = 24,
  double suffixWidth = 24,
  String? suffiximage,
  double duffixheight = 24,
  double duffixwidth = 24,
  String? duffiximage,
  Function? imagefunction,
  Function? imgfun,
}) {
  return AlertDialog(
    backgroundColor: Colors.white,
    title: getCustomFont('Add Reminder', 15, Colors.grey, 5),
    insetPadding: const EdgeInsets.all(10),
    content: Container(
      height: 170,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.white)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getDefaultTextFiledWithLabel(
              context, 'Enter Reminder Detail', controller,
              height: 50.h),
          getVerSpace(15),
          getCustomFont('Set the Date and Time', 15, Colors.grey, 4),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // GestureDetector(
              //     onTap: () {
              //       imagefunction!();
              //     },
              //     child: Container(
              //       padding: EdgeInsets.all(15),
              //       decoration: BoxDecoration(
              //         color: Colors.yellow.shade300,
              //         borderRadius: BorderRadius.circular(20),
              //       ),
              //       child: getSvgImage(suffiximage.toString(),
              //           width: suffixWidth.h, height: suffixHeight.h),
              //     )),
              // Container(
              //   padding: EdgeInsets.all(15),
              //   decoration: BoxDecoration(
              //     color: Colors.blue.shade100,
              //     borderRadius: BorderRadius.circular(20),
              //   ),
              //   child: getSvgImage(duffiximage.toString(),
              //       width: duffixheight.h, height: duffixheight.h),
              // ),
              GestureDetector(
                onTap: () {
                  // getCalenderBottomSheet(context, 'Set Date', 'set',
                  //     withCancelBtn: true);
                },
                child: getShadowDefaultContainer(
                    height: 50.h,
                    width: 50.h,
                    color: Colors.yellow.shade300,
                    child: Center(
                        child: getSvgImage(suffiximage.toString(),
                            width: suffixWidth.h, height: suffixWidth.h))),
              ),
              GestureDetector(
                onTap: () {
                  imagefunction!();
                },
                child: getShadowDefaultContainer(
                    height: 50.h,
                    width: 50.h,
                    color: Colors.blue.shade100,
                    child: Center(
                        child: getSvgImage(duffiximage.toString(),
                            width: duffixheight.h, height: duffixheight.h))),
              )
            ],
          )
        ],
      ),
    ),
  );
}

Widget getCustomParaFont(String text, double fontSize, Color fontColor,
    {String fontFamily = Constant.fontsFamily,
    // TextOverflow overflow = TextOverflow.ellipsis,
    TextDecoration decoration = TextDecoration.none,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign textAlign = TextAlign.start,
    txtHeight}) {
  return Text(
    text,
    // overflow: overflow,
    style: TextStyle(
        decoration: decoration,
        fontSize: fontSize,
        fontStyle: FontStyle.normal,
        color: fontColor,
        fontFamily: fontFamily,
        height: txtHeight,
        fontWeight: fontWeight),
    softWrap: true,
    textAlign: textAlign,
  );
}

TextEditingController dateController = TextEditingController();
void updateDateController(DateTime selectedDate) {
  dateController.text = DateFormat('E dd/MM/yyyy').format(selectedDate);
}

Widget getCalenderBottomSheet(
  BuildContext context,
  String title,
  String btnText,
  TextEditingController controller,
  Function(DateTime) onChanged, {
  bool withCancelBtn = false,
}) {
  TextEditingController dateController =
      TextEditingController(); // Initialize TextEditingController

  // Function to update dateController with formatted date
  void updateDateController(DateTime selectedDate) {
    dateController.text = DateFormat('E dd/MM/yyyy').format(selectedDate);
  }

  Get.bottomSheet(
    Wrap(
      alignment: WrapAlignment.center,
      children: [
        getSvgImage('line1.svg').marginSymmetric(vertical: 10.h),
        Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () {
              Constant.backToPrev(context);
            },
            child: getSvgImage('close.svg', height: 24.h, width: 24.h)
                .paddingSymmetric(horizontal: 20.h),
          ),
        ),
        getCustomFont(
          title,
          20.sp,
          Colors.black,
          1,
          fontWeight: FontWeight.w700,
          textAlign: TextAlign.center,
        ),
        getShadowDefaultContainer(
          height: 363.h,
          color: Colors.white,
          margin: EdgeInsets.all(20.h),
          padding: EdgeInsets.symmetric(horizontal: 10.h),
          child: SfDateRangePicker(
            allowViewNavigation: true,
            showNavigationArrow: true,
            selectionColor: accentColor,
            selectionMode: DateRangePickerSelectionMode.single,
            navigationDirection: DateRangePickerNavigationDirection.horizontal,
            todayHighlightColor: accentColor,
            toggleDaySelection: true,
            monthViewSettings: const DateRangePickerMonthViewSettings(
              dayFormat: 'E',
            ),
            headerStyle: DateRangePickerHeaderStyle(
              textStyle:
                  buildTextStyle(context, Colors.black, FontWeight.w700, 16.sp),
            ),
            monthCellStyle: DateRangePickerMonthCellStyle(
              textStyle:
                  buildTextStyle(context, Colors.black, FontWeight.w500, 15.sp),
              todayTextStyle:
                  buildTextStyle(context, accentColor, FontWeight.w700, 14.sp),
            ),
            // onSelectionChanged event handler
            onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
              if (args.value is DateTime) {
                DateTime selectedDate = args.value as DateTime;
                updateDateController(
                    selectedDate); // Update dateController with selected date
                onChanged(
                    selectedDate); // Call the onChanged callback with the selected date
              }
            },
          ),
        ),
        getVerSpace(20.h),
        Row(
          children: [
            (withCancelBtn)
                ? Expanded(
                    flex: 1,
                    child: getButton(
                      context,
                      Colors.transparent,
                      'Cancel',
                      accentColor,
                      () {
                        Constant.backToPrev(context);
                      },
                      18.sp,
                      borderRadius: BorderRadius.all(Radius.circular(22.h)),
                      weight: FontWeight.w700,
                      buttonHeight: 60.h,
                      isBorder: true,
                      borderWidth: 2.h,
                      borderColor: accentColor,
                    ),
                  )
                : getHorSpace(0.h),
            (withCancelBtn) ? getHorSpace(20.h) : getHorSpace(0.h),
            Expanded(
              flex: 1,
              child: getButton(
                context,
                accentColor,
                btnText,
                Colors.white,
                () {
                  Constant.backToPrev(context);
                },
                18.sp,
                weight: FontWeight.w700,
                borderRadius: BorderRadius.all(Radius.circular(22.h)),
                buttonHeight: 60.h,
              ),
            ),
          ],
        ).marginSymmetric(horizontal: 20.h).marginOnly(bottom: 30.h),
      ],
    ),
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(40.h),
        topRight: Radius.circular(40.h),
      ),
    ),
  );

  // Since Get.bottomSheet returns a Future<dynamic> and not Widget,
  // you should return a placeholder Widget here or modify the function accordingly.
  return SizedBox.shrink(); // Placeholder Widget
}

TextEditingController timeController = TextEditingController();

// Function to convert DateTime to TimeOfDay
TimeOfDay timeOfDayFromDateTime(DateTime dateTime) {
  return TimeOfDay.fromDateTime(dateTime);
}

// Function to update the timeController with the selected time
void updateTimeController(BuildContext context, DateTime selectedDateTime) {
  // Convert DateTime to TimeOfDay
  TimeOfDay selectedTime = timeOfDayFromDateTime(selectedDateTime);

  // Update timeController with formatted time
  final formattedTime = selectedTime.format(context);
  timeController.text = formattedTime; // Update timeController text
}

Future<void> getTimeBottomSheet(
    BuildContext context, Function(TimeOfDay) onTimeSelected) async {
  await Get.bottomSheet(
    Wrap(
      alignment: WrapAlignment.center,
      children: [
        getSvgImage('line1.svg').marginOnly(top: 10.h),
        getVerSpace(10.h),
        Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () {
              Constant.backToPrev(context);
            },
            child: getSvgImage('close.svg', height: 24.h, width: 24.h)
                .paddingSymmetric(horizontal: 20.h),
          ),
        ),
        getCustomFont(
          'Set Time',
          20.sp,
          Colors.black,
          1,
          fontWeight: FontWeight.w700,
          textAlign: TextAlign.center,
        ),
        getVerSpace(20.h),
        TimePickerSpinner(
          is24HourMode: false,
          normalTextStyle: buildTextStyle(
            context,
            greyFontColor,
            FontWeight.w500,
            17.sp,
          ),
          highlightedTextStyle: buildTextStyle(
            context,
            Colors.black,
            FontWeight.w700,
            18.sp,
          ),
          spacing: 40.h,
          itemHeight: 65.h,
          alignment: Alignment.center,
          isForce2Digits: true,
          onTimeChange: (DateTime dateTime) {
            // Convert DateTime to TimeOfDay
            TimeOfDay selectedTime = TimeOfDay.fromDateTime(dateTime);

            // Invoke the callback with the selected TimeOfDay
            onTimeSelected(selectedTime);
          },
        ),
        getVerSpace(20.h),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: getButton(
                context,
                Colors.transparent,
                'Cancel',
                accentColor,
                () {
                  Constant.backToPrev(context);
                },
                18.sp,
                borderRadius: BorderRadius.all(Radius.circular(22.h)),
                weight: FontWeight.w700,
                buttonHeight: 60.h,
                isBorder: true,
                borderWidth: 2.h,
                borderColor: accentColor,
              ),
            ),
            getHorSpace(20.h),
            Expanded(
              flex: 1,
              child: getButton(
                context,
                accentColor,
                'Set',
                Colors.white,
                () {
                  Constant.backToPrev(context);
                },
                18.sp,
                weight: FontWeight.w700,
                borderRadius: BorderRadius.all(Radius.circular(22.h)),
                buttonHeight: 60.h,
              ),
            ),
          ],
        ).marginSymmetric(horizontal: 20.h).marginOnly(bottom: 30.h),
      ],
    ),
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(40.h),
        topRight: Radius.circular(40.h),
      ),
    ),
  );

  //No need to return anything since the function is void and the bottom sheet is awaited
}
