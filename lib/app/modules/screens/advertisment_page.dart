import 'package:bazarcom/app/data/models/advertisment_model.dart';
import 'package:bazarcom/app/data/providers/advertisment_provider.dart';
import 'package:bazarcom/app/data/repositories/advertisment_repository.dart';
import 'package:bazarcom/app/modules/controllers/advertisment_list_controller.dart';
import 'package:bazarcom/app/modules/screens/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';

class AdvertismentsList extends StatelessWidget {
  final int subCategryId;
  AdvertismentsList({Key key, this.subCategryId}) : super(key: key);

  final AdvertismentRepository advertismentRepository = AdvertismentRepository(
      apiClient: AdvertismentApiClient(httpClient: http.Client()));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: Get.height / 15,
          title: Container(
              child: Image.asset(
            "assets/images/4.png",
            width: Get.width / 2,
            height: Get.height / 10,
          )),
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
        body: SafeArea(
          child: GetX<AdvertismentController>(
            init: AdvertismentController(advertismentRepository, subCategryId),
            builder: (_) {
              return _.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : _.advertismentList.length == 0
                      ? Center(
                          child: Text(
                            "لا يوجد إعلانات",
                            style: TextStyle(color: kColorOfBlueRect),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: AnimationLimiter(
                            child: GridView.count(
                              crossAxisCount: 2,childAspectRatio: 13/16,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              children: List.generate(
                                _.advertismentList.length,
                                (int index) {
                                  Advertisment advertisment =
                                      _.advertismentList[index];
                                  return AnimationConfiguration.staggeredGrid(
                                    position: index,
                                    duration: const Duration(milliseconds: 500),
                                    columnCount: 2,
                                    child: ScaleAnimation(
                                      child: FadeInAnimation(
                                        child: InkWell(onTap: (){
                                          Get.to(ProductDetailPage());
                                        },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: kColorOfBlueRect
                                                        .withOpacity(0.1),
                                                    spreadRadius: 5,
                                                    blurRadius: 7,
                                                    offset: Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceAround,
                                                children: [
                                                  Flexible(
                                                    child: Image.network(
                                                      baseUrl +
                                                          advertisment
                                                              .imagess[0].url,
                                                      height: Get.height / 6,width: Get.width,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: Get.width / 40,
                                                      ),
                                                      Text(
                                                        advertisment.name,
                                                        style: TextStyle(
                                                            color:
                                                                kColorOfBlueRect,
                                                            fontWeight:
                                                                FontWeight.w600),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: Get.width / 40,
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .remove_red_eye_outlined,
                                                        color: kOrangeColor,
                                                      ),
                                                      Text(
                                                        advertisment.views,
                                                        style: TextStyle(
                                                          color: kColorOfBlueRect,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: Get.width / 40,
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .monetization_on_outlined,
                                                        color: kOrangeColor,
                                                      ),
                                                      Text(
                                                        advertisment.price
                                                            .toString(),
                                                        style: TextStyle(
                                                          color: kColorOfBlueRect,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
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
      ),
    );
  }
}
