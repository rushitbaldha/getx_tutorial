import 'package:fantasy11/Widget/comman_appbar.dart';
import 'package:fantasy11/controller/series_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SeriesPage extends StatelessWidget {
  SeriesController seriesController = Get.put(SeriesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommanAppBar(
        title: 'Series',
      ),
      body: Obx(() => seriesController.isLoading.value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                SingleChildScrollView(
                  controller: seriesController.scrollController,
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xFF2F1E85), Color(0xFF51038C)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: seriesController.lstMatch.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            margin: EdgeInsets.all(20),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              // height: MediaQuery.of(context).size.height * 0.22,
                              // width: MediaQuery.of(context).size.width * 0.8,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  if (seriesController.lstMatch[index].team1Run
                                          .isNotEmpty &&
                                      seriesController
                                          .lstMatch[index].team2Run.isNotEmpty)
                                    Text(
                                      '${seriesController.lstMatch[index].textLine}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.orange,
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.center,
                                    )
                                  else
                                    Text(
                                      'Coming Soon...',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.orange,
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.center,
                                    ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${seriesController.lstMatch[index].matchDate}',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          Row(children: [
                                            Image.network(
                                              seriesController
                                                  .lstMatch[index].team1Icon,
                                              scale: 2,
                                              fit: BoxFit.fill,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              seriesController.lstMatch[index]
                                                  .team1NiceName,
                                              style: TextStyle(fontSize: 15),
                                            ),
                                          ]),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          if (seriesController.lstMatch[index]
                                                  .team1Run.isNotEmpty &&
                                              seriesController.lstMatch[index]
                                                  .team2Run.isNotEmpty)
                                            Text(
                                              seriesController
                                                  .lstMatch[index].team1Run,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey),
                                            )
                                          else
                                            SizedBox(
                                              height: 0,
                                            )
                                        ],
                                      ),
                                      Container(
                                        height: 30,
                                        child: VerticalDivider(
                                          color: Colors.grey,
                                          thickness: 1,
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Row(children: [
                                            Image.network(
                                              seriesController
                                                  .lstMatch[index].team2Icon,
                                              scale: 2,
                                              fit: BoxFit.fill,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              seriesController.lstMatch[index]
                                                  .team2NiceName,
                                              style: TextStyle(fontSize: 15),
                                            ),
                                          ]),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          if (seriesController.lstMatch[index]
                                                  .team1Run.isNotEmpty &&
                                              seriesController.lstMatch[index]
                                                  .team2Run.isNotEmpty)
                                            Text(
                                              seriesController
                                                  .lstMatch[index].team2Run,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey),
                                            )
                                          else
                                            SizedBox(
                                              height: 0,
                                            )
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${seriesController.lstMatch[index].ground}',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                seriesController.isDataLoad.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(),
              ],
            )),
    );
  }
}
