import 'package:app_developer_assignment/home/controller/home_controller.dart';
import 'package:app_developer_assignment/home/ui/home.dart';
import 'package:app_developer_assignment/login/controller/login_controller.dart';
import 'package:app_developer_assignment/login/ui/login.dart';
import 'package:app_developer_assignment/utils/globals.dart';
import 'package:app_developer_assignment/utils/translation/message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  final controller = Get.put(LoginController());
  final homeController = Get.put(HomeController());
  // bool isLoggedIn=false;
  SharedPreferences prefs;
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        onInit: () async {
          prefs = await SharedPreferences.getInstance();
          controller.isLoggedIn = prefs.getBool("isLoggedIn");
          Get.updateLocale(prefs.getString("lang") == "en"
              ? Locale('en', 'US')
              : Locale('ja', 'JP'));
        },
        title: 'Assignment',
        debugShowCheckedModeBanner: false,
        translations: Messages(), // your translations
        fallbackLocale: Locale('en', 'US'),
        theme: ThemeData(
            primaryColor: themeColor,
            buttonColor: themeColor,
            iconTheme: IconThemeData(color: themeColor),
            accentColor: themeColor,
            cursorColor: themeColor,
            indicatorColor: themeColor,
            scaffoldBackgroundColor: Colors.white),
        home: controller.isLoggedIn ? HomePage() : Login());
  }
}
