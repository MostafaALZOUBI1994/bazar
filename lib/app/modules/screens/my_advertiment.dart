import 'package:bazarcom/app/data/models/advertisment_model.dart';
import 'package:bazarcom/app/data/providers/advertisment_provider.dart';
import 'package:bazarcom/app/data/providers/categories_provider.dart';
import 'package:bazarcom/app/data/repositories/advertisment_repository.dart';
import 'package:bazarcom/app/modules/controllers/my_advertisments_controller.dart';
import 'package:bazarcom/app/modules/screens/advertisment_details.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';

class MyAdvertisments extends StatelessWidget {
  final int userId;
  final String jwt;
  MyAdvertisments({Key key, this.userId, this.jwt}) : super(key: key);

  final AdvertismentRepository advertismentRepository = AdvertismentRepository(
      apiClient: AdvertismentApiClient(httpClient: http.Client()));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: deviceHieght / 15,
          title: Container(
              child: Image.asset(
            "assets/images/4.png",
            width: deviceWidth / 2,
            height: deviceHieght / 10,
          )),
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Text(
                "إعلاناتي",
                style: TextStyle(
                    color: kColorOfCanvas,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: GetX<MyAdvertismentController>(
                  init:
                      MyAdvertismentController(advertismentRepository, userId),
                  builder: (_) {
                    return _.isLoading.value
                        ? Center(child: CircularProgressIndicator())
                        : _.myAdvertismentList.length == 0
                            ? Center(
                                child: Text(
                                  "لا يوجد لديك إعلانات",
                                  style: TextStyle(color: kColorOfCanvas),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: AnimationLimiter(
                                  child: GridView.count(
                                    crossAxisCount: 2,
                                    childAspectRatio: 13 / 16,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    children: List.generate(
                                      _.myAdvertismentList.length,
                                      (int index) {
                                        Advertisment advertisment =
                                            _.myAdvertismentList[index];
                                        return AnimationConfiguration
                                            .staggeredGrid(
                                          position: index,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          columnCount: 2,
                                          child: ScaleAnimation(
                                            child: FadeInAnimation(
                                              child: InkWell(
                                                onTap: () async {
                                                  var fields = CategoryApi(
                                                          httpClient: null)
                                                      .getFieldsRelatedToSubCategories(
                                                          advertisment
                                                              .subCategory,
                                                          advertisment);
                                                  Get.to(
                                                      AdevertismentDetailPage(
                                                    advertisment: advertisment,
                                                    fields: fields,
                                                  ));
                                                },
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: kColorOfCanvas
                                                              .withOpacity(0.1),
                                                          spreadRadius: 5,
                                                          blurRadius: 7,
                                                          offset: Offset(0,
                                                              3), // changes position of shadow
                                                        ),
                                                      ],
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Flexible(
                                                          child: advertisment
                                                                  .imagess
                                                                  .isEmpty
                                                              ? CachedNetworkImage(
                                                                  imageUrl:
                                                                      "https://i.stack.imgur.com/y9DpT.jpg",
                                                                  progressIndicatorBuilder: (context,
                                                                          url,
                                                                          downloadProgress) =>
                                                                      CircularProgressIndicator(
                                                                          value:
                                                                              downloadProgress.progress),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      Icon(Icons
                                                                          .error),
                                                                )
                                                              : CachedNetworkImage(
                                                                  imageUrl: baseUrl +
                                                                      advertisment
                                                                          .imagess[0],
                                                                  progressIndicatorBuilder: (context,
                                                                          url,
                                                                          downloadProgress) =>
                                                                      CircularProgressIndicator(
                                                                          value:
                                                                              downloadProgress.progress),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      Icon(Icons
                                                                          .error),
                                                                ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  deviceWidth /
                                                                      40,
                                                            ),
                                                            Text(
                                                              advertisment.name,
                                                              style: TextStyle(
                                                                  color:
                                                                      kColorOfCanvas,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  deviceWidth /
                                                                      40,
                                                            ),
                                                            Icon(
                                                              Icons
                                                                  .remove_red_eye_outlined,
                                                              color:
                                                                  kColorOfYellowRect,
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  deviceWidth /
                                                                      80,
                                                            ),
                                                            Text(
                                                              advertisment.views
                                                                  .toString(),
                                                              style: TextStyle(
                                                                color:
                                                                    kColorOfCanvas,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        IconButton(
                                                          icon: Icon(
                                                              Icons.delete,color: Colors.redAccent,),
                                                          onPressed: () {
                                                            Get.defaultDialog(
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
                                                                middleText: "",
                                                                actions: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      InkWell(
                                                                        onTap:
                                                                            () async {
                                                                        await  AdvertismentApiClient(httpClient: null).removeAdvertisment(advertisment.id,jwt);
                                                                            },
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.only(
                                                                            top:
                                                                                deviceHieght / 40,
                                                                          ),
                                                                          child: Container(
                                                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: kColorOfYellowRect, width: 2), color: kColorOfBlueRect),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                                                                                child: Center(child: Text("نعم")),
                                                                              )),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width: deviceWidth /
                                                                            40,
                                                                      ),
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          Get.back();
                                                                        },
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.only(
                                                                            top:
                                                                                deviceHieght / 40,
                                                                          ),
                                                                          child: Container(
                                                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: kColorOfYellowRect, width: 2), color: kColorOfBlueRect),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
                                                                                child: Center(child: Text("لا")),
                                                                              )),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                                titleStyle:
                                                                    TextStyle(
                                                                        color:
                                                                            kColorOfCanvas,
                                                                        fontSize:
                                                                            15),
                                                                title:
                                                                    "هل أنت متأكد أنك تريد حذف إعلانك");
                                                          },
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
