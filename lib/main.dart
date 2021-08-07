
import 'package:bazarcom/app/modules/screens/home_page.dart';
import 'package:bazarcom/app/theme/app_theme.dart';
import 'package:bazarcom/app/utils/utils/codegen_loader.g.dart';
import 'package:custom_splash/custom_splash.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/constants.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: [Locale('ar')],
        path: 'assets/translations', // <-- change the path of the translation files
        fallbackLocale: Locale('ar'),assetLoader: CodegenLoader(),
        child: MyApp()
    ),
  );

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(locale: context.locale,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      theme:MyTheme().getMyTheme(),
      home: CustomSplash(
        imagePath: 'assets/images/2.png',
        backGroundColor: kColorOfCanvas,
        animationEffect: 'zoom-in',
        logoSize: 400,
        home: HomePage(),
        duration: 4000,
        type: CustomSplashType.StaticDuration,

    )
    );
  }


}



