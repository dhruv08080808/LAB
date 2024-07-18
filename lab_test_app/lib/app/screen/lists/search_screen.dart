import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lab_test_app/app/data/data_file.dart';
import 'package:lab_test_app/app/routes/app_routes.dart';
import 'package:lab_test_app/base/widget_utils.dart';

import '../../../base/constant.dart';
import '../../models/model_nearby_lab.dart';
import '../../models/model_recent_search.dart';
import '../home/tab/tab_home.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SearchScreenState();
  }
}

class SearchScreenState extends State<SearchScreen> {
  void backClick() {
    Constant.backToPrev(context);
  }

  TextEditingController searchController = TextEditingController();
  List<ModelRecentSearch> recentSearchList = DataFile.recentSearchList;
  List<ModelNearbyLab> nearbyLabList = DataFile.nearbyLabList;


  List<ModelNearbyLab> _filteredLabList = [];

  @override
  void initState() {
    super.initState();
    _filteredLabList = []; // Start with full list
  }

  void _filterLabList(String query) {
    List<ModelNearbyLab> filteredList = DataFile.nearbyLabList.where((lab) {
      return lab.title.toLowerCase().contains(query.toLowerCase()) ||
          lab.location.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      _filteredLabList.clear();
      _filteredLabList.addAll(filteredList);
    });
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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getVerSpace(20.h),
                getBackAppBar(context, () {
                  backClick();
                }, 'Search For Lab'),
                getVerSpace(20.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getSearchTextFieldWidget(
                      context,
                      60.h,
                      'search...',
                      searchController,
                      onChanged: (value) {
                        setState(() {
                          if (value.isEmpty) {
                            // If search text is empty, clear the filtered lab list
                            _filteredLabList = [];
                          } else {
                            // Filter labs based on the search text
                            _filteredLabList = nearbyLabList.where((lab) {
                              return lab.title
                                  .toLowerCase()
                                  .contains(value.toLowerCase());
                            }).toList();
                          }
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    if (_filteredLabList.isNotEmpty)
                      Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: ListView.builder(
                          itemCount: _filteredLabList.length,
                          itemBuilder: (context, index) {
                            ModelNearbyLab lab = _filteredLabList[index];
                            return ListTile(
                              leading: Image.asset('assets/images/${lab.img}'),
                              title: Text(lab.title),
                              subtitle: Text(lab.location),
                            );
                          },
                        ),
                      )
                    else if (searchController.text
                        .isNotEmpty) // Show "No Data" only if search text is not empty
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.h),
                        child: getCustomFont(
                          'No matching labs found',
                          16.sp,
                          Colors.black,
                          1,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                  ],
                ),
                getVerSpace(20.h),
                getCustomFont('Recent Searches', 16.sp, Colors.black, 1,
                        fontWeight: FontWeight.w700)
                    .paddingSymmetric(horizontal: 20.h),
                getVerSpace(14.h),
                buildRecentSearchTab(),
                getVerSpace(30.h),
                buildViewAllView(context, 'Nearby Laboratories', () {
                  Constant.sendToNext(context, Routes.nearbyLabScreenRoute);
                }),
                buildNearbyLabView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ListView buildRecentSearchTab() {
    return ListView.separated(
      itemCount: 5,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        ModelRecentSearch recentSearch = recentSearchList[index];
        return SizedBox(
            height: 41.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getSvgImage('recent.svg', height: 24.h, width: 24.h),
                getHorSpace(6.h),
                Expanded(
                    child: getCustomFont(
                            recentSearch.title, 17.sp, Colors.black, 1,
                            fontWeight: FontWeight.w500)
                        .paddingSymmetric(vertical: 12.h)),
                getSvgImage('close.svg', height: 16.h, width: 16.h),
              ],
            ).marginSymmetric(horizontal: 20.h));
      },
      separatorBuilder: (BuildContext context, int index) {
        return getDivider(endIndent: 20.h, indent: 20.h);
      },
    );
  }
}
