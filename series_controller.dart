import 'dart:convert';

import 'package:fantasy11/Data/data.dart';
import 'package:fantasy11/Data/match_list.dart';
import 'package:fantasy11/Utils/URL_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'homepage_controller.dart';

class SeriesController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<MatchList> lstMatch = new RxList();
  RxList<MatchList> lstShowData;
  int seriesID = 0;
  RxBool isDataLoad = false.obs;
  bool isPageLoading = true;
  RxInt pageNumber = 1.obs;
  RxDouble homeScrollPosition = 0.0.obs;
  ScrollController scrollController = ScrollController();
  HomepageController homepageController = Get.find();

  @override
  void onInit() {
    seriesID =
        homepageController.lstSeries[homepageController.clickIndex].seriesId;
    getData();
    super.onInit();
    scrollController.addListener(() {
      scrollController.position.pixels;

      if (isPageLoading &&
          scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) {
        isDataLoad(true);
        increment();
        Future.delayed(Duration(milliseconds: 800), () {
          getData();
        });
      }
    });
  }

  void increment() {
    pageNumber.value = pageNumber.value + 1;
    update();
  }

  Future<void> getData() async {
    var service = jsonEncode(
        {"serviceNo": 10, "seriesId": seriesID, "pageNo": pageNumber.value});
    http.Response response = await http.post(Uri.parse(UrlHelper.APP_URL),
        body: service, headers: UrlHelper.REQ_HEADER);
    // print(jsonDecode(response.body));
    Data data = Data.fromJson(json.decode(response.body));
    lstShowData = data.matchList.obs;
    print('Page Number Before : ${pageNumber.value}');
    print('Page Length Before : ${lstMatch.value.length}');
    if (lstShowData.isNotEmpty) {
      lstMatch.addAll(lstShowData);
      update();
    }
    print('Page Number After : ${pageNumber.value}');
    print('Page Length After : ${lstMatch.value.length}');

    isDataLoad(false);
    isLoading(false);
  }
}
