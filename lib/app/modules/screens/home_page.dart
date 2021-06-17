import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:bazarcom/app/constants.dart';
import 'package:bazarcom/app/data/models/category_model.dart';
import 'package:bazarcom/app/data/providers/categories_provider.dart';

import 'package:bazarcom/app/data/repositories/category_repository.dart';

import 'package:bazarcom/app/modules/screens/advertisment_page.dart';
import 'package:bazarcom/app/modules/controllers/home_controller.dart';
import 'package:bazarcom/app/modules/screens/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _bottomNavIndex = 0;
  final iconList = <IconData>[
    Icons.home,
    Icons.account_circle,
  ];

  final CategoryRepository categoryRepository = CategoryRepository(
    apiClient: CategoryApi(
      httpClient: http.Client(),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: ClipRRect(
              borderRadius: BorderRadius.circular(360),
              child: Image.asset("assets/images/1.jpg")),
          onPressed: () {},
          //params
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar(
          icons: iconList, activeColor: kColorOfYellowRect,
          backgroundColor: kColorOfCanvas,
          activeIndex: _bottomNavIndex,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.defaultEdge,
          leftCornerRadius: 32,
          rightCornerRadius: 32,
          onTap: (index) => setState(() => _bottomNavIndex = index),

          //other params
        ),
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            child: GetX<HomeController>(
              init: HomeController(repository: categoryRepository),
              builder: (_) {
                return _.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : _.categoriesList.length==0 ?Center(child: Text("لا يوجد"),):ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: _.categoriesList.length,
                  itemBuilder: (__, categoryIndex) {
                    CategoryModel category =
                    _.categoriesList[categoryIndex];
                    return Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              category.nameAr,
                              style: TextStyle(
                                  color: kColorOfCanvas,
                                  fontWeight: FontWeight.bold,
                                  fontSize: context.textScaleFactor * 22),
                            ),
                          ],
                        ),
                        StaggeredGridView.countBuilder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisCount: 4,
                          itemCount: category.subCategories.length,
                          itemBuilder:
                              (BuildContext context, int indexSub) {
                            SubCategory subCategory =
                            category.subCategories[indexSub];

                            return InkWell(

                              onTap: (){
                                Get.to(AdvertismentsList(subCategryId: subCategory.id,));
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: SvgPicture.network(
                                        baseUrl + subCategory.image,
                                        color: kColorOfYellowRect,
                                      ),
                                    ),
                                    //SizedBox(height: Get.height/30,),
                                    Padding(
                                      padding:
                                      EdgeInsets.fromLTRB(0, 15, 0, 5),
                                      child: Text(
                                        subCategory.nameAr,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: kColorOfBlueRect),
                              ),
                            );
                          },
                          staggeredTileBuilder: (int index) {
                            if (category.subCategories.length % 2 != 0 &&
                                category.subCategories.length - 1 ==
                                    index) {
                              return new StaggeredTile.count(5, 1.3);
                            }
                            return new StaggeredTile.count(2, 1.3);
                          },
                          mainAxisSpacing: 8.0,
                          crossAxisSpacing: 8.0,
                        )
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
