import 'package:bazarcom/app/constants.dart';
import 'package:bazarcom/app/data/models/advertisment_model.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:bazarcom/app/utils/utils/codegen_loader.g.dart';
import 'package:bazarcom/app/utils/utils/locale_keys.g.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class AdevertismentDetailPage extends StatefulWidget {
  final Advertisment advertisment;
  final fields;
  AdevertismentDetailPage({Key key, @required this.advertisment, this.fields})
      : super(key: key);

  @override
  _AdevertismentDetailPageState createState() =>
      _AdevertismentDetailPageState();
}

class _AdevertismentDetailPageState extends State<AdevertismentDetailPage> {
  int selected = 0;
  FlickManager flickManager;
  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController:
          VideoPlayerController.network(baseUrl + widget.advertisment.video),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  Widget _productImage() {
    return ImageSlideshow(
      /// Width of the [ImageSlideshow].
      width: double.infinity,

      /// The page to show when first creating the [ImageSlideshow].
      initialPage: 0,

      /// The color to paint the indicator.
      indicatorColor: kColorOfOrangeRect,

      /// The color to paint behind th indicator.
      indicatorBackgroundColor: Colors.white,

      /// The widgets to display in the [ImageSlideshow].
      /// Add the sample image file into the images folder
      children: [
        for (int i = 0; i < widget.advertisment.imagess.length; i++)
          Image.network(baseUrl + widget.advertisment.imagess[i])
      ],

      /// Auto scroll interval.
      /// Do not auto scroll with null or 0.
      autoPlayInterval: 3000,
    );
  }

  Widget _detailWidget() {
    return DraggableScrollableSheet(
      maxChildSize: .62,
      initialChildSize: .62,
      minChildSize: .62,
      builder: (context, scrollController) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: kColorOfYellowRect.withOpacity(0.9),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                color: Colors.white),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: selected == 0
                            ? BoxDecoration(
                                gradient: kOrangeGradient,
                                borderRadius: BorderRadius.circular(30),
                              )
                            : BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                                border: Border.all(color: kOrangeColor)),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selected = 0;
                            });
                          },
                          borderRadius: BorderRadius.circular(30),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              LocaleKeys.specification.tranlation(),
                              style: TextStyle(
                                  color: selected == 0
                                      ? Colors.white
                                      : kOrangeColor),
                            ),
                          )),
                        ),
                      ),
                      Container(
                        decoration: selected == 1
                            ? BoxDecoration(
                                gradient: kOrangeGradient,
                                borderRadius: BorderRadius.circular(30),
                              )
                            : BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                                border: Border.all(color: kOrangeColor)),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selected = 1;
                            });
                          },
                          borderRadius: BorderRadius.circular(30),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              LocaleKeys.description.tranlation(),
                              style: TextStyle(
                                  color: selected == 1
                                      ? Colors.white
                                      : kOrangeColor),
                            ),
                          )),
                        ),
                      ),
                      Container(
                        decoration: selected == 2
                            ? BoxDecoration(
                                gradient: kOrangeGradient,
                                borderRadius: BorderRadius.circular(30),
                              )
                            : BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                                border: Border.all(color: kOrangeColor)),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selected = 2;
                            });
                          },
                          borderRadius: BorderRadius.circular(30),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              LocaleKeys.video.tranlation(),
                              style: TextStyle(
                                  color: selected == 2
                                      ? Colors.white
                                      : kOrangeColor),
                            ),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
                selected == 0
                    ? Expanded(
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Wrap(
                              children: <Widget>[
                                for (var field in widget.fields.entries)
                                  _description(field.key.toString(),
                                      field.value.toString())
                              ],
                            ),
                          ),
                        ),
                      )
                    : selected == 1
                        ? Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              height: deviceHieght / 3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(40),
                                    bottomRight: Radius.circular(40),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: kColorOfCanvas.withOpacity(0.9),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                  color: Colors.white),
                              child: Center(
                                child: Text(
                                  widget.advertisment.description == null
                                      ? LocaleKeys.noDescription.tranlation()
                                      : widget.advertisment.description,
                                  style: TextStyle(color: kOrangeColor),
                                ),
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Container(
                                child: widget.advertisment.video == ""
                                    ? Text("لا يوجد فيديو",style: TextStyle(
                                  color: kColorOfYellowRect
                                ),)
                                    : FittedBox(
                                      child: SizedBox(height:deviceHieght/4 ,
                                        child: FlickVideoPlayer(
                                            wakelockEnabled: true,
                                            flickManager: flickManager,
                                          ),
                                      ),
                                    ),
                              ),
                            ),
                          ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _description(String fieldName, String fieldValue) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: RichText(
          text: TextSpan(children: [
            TextSpan(
              text: fieldName + " : ",
              style:
                  TextStyle(color: kColorOfCanvas, fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: "  ",
            ),
            TextSpan(
              text: fieldValue,
              style: TextStyle(color: kColorOfOrangeRect),
            )
          ]),
        ));
  }

  _launch(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("Not supported");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Container(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Positioned(
                  width: deviceWidth,
                  height: deviceHieght / 3,
                  top: 0,
                  child: _productImage()),
              _detailWidget(),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: FabCircularMenu(
                    ringWidth: 60,
                    alignment: Alignment.bottomLeft,
                    ringColor: kColorOfYellowRect,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(
                            Icons.phone,
                            color: kOrangeColor,
                          ),
                          onPressed: () {
                            _launch("sms:+96399247870");
                          }),
                      InkWell(
                        onTap: () {
                          _launch('whatsapp://send?&phone=+963992478760');
                        },
                        child: Image.asset(
                          "assets/images/whatsapp.png",
                          height: 50,
                        ),
                      ),
                      FloatingActionButton(
                        backgroundColor: kColorOfCanvas,
                        onPressed: () {
                          _launch("tel:+963992478760");
                        },
                        child: Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                      ),
                      FloatingActionButton(
                        backgroundColor: kColorOfCanvas,
                        onPressed: () {},
                        child: IconButton(
                            icon: Icon(Icons.message, color: Colors.white),
                            onPressed: () {
                              _launch("sms:+963992478760");
                            }),
                      )
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
