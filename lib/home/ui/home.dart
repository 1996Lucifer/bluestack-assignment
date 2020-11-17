import 'dart:io';

import 'package:app_developer_assignment/home/controller/home_controller.dart';
import 'package:app_developer_assignment/login/controller/login_controller.dart';
import 'package:app_developer_assignment/login/ui/login.dart';
import 'package:app_developer_assignment/main.dart';
import 'package:app_developer_assignment/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Language { English, Japanese }

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  final controller = Get.put(LoginController());
  final HomeController homeController = Get.put(HomeController());
  ProgressDialog pr;
  SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    double appBarHeight = AppBar().preferredSize.height;

    Widget _simplePopup() => PopupMenuButton<int>(
          itemBuilder: (context) => [
            PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    Icon(Icons.power_settings_new,color: Colors.black,),
                    Text("logout".tr),
                  ],
                )),
            PopupMenuItem(
                value: 2,
                child: Row(
                  children: [
                    Icon(Icons.language_rounded,color: Colors.black),
                    Text("language_settings".tr),
                  ],
                )),
          ],
          onSelected: (value) {
            switch (value) {
              case 1:
                return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          title: Text('message'.tr),
                          content: Text("logout_message".tr),
                          actions: [
                            FlatButton(
                                child: Text(
                                  'no_button'.tr,
                                  style: TextStyle(color: themeColor),
                                ),
                                onPressed: () {
                                  Get.back();
                                }),
                            FlatButton(
                                child: Text(
                                  'logout'.tr,
                                  style: TextStyle(color: themeColor),
                                ),
                                onPressed: () {
                                  controller.isLoggedInCheck(false);
                                  Get.offAll(Login());
                                }),
                          ]);
                    });
                break;
              case 2:
                return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          title: Text('select_language'.tr),
                          content: GetBuilder<HomeController>(
                              builder: (_) => Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ListTile(
                                        title: Text('english'.tr),
                                        selected: homeController.language ==
                                            Language.English,
                                        leading: Radio(
                                          value: Language.English,
                                          groupValue: homeController.language,
                                          onChanged: (value) => homeController
                                              .selectedLanguage(value),
                                        ),
                                      ),
                                      ListTile(
                                        title: Text('japanese'.tr),
                                        selected: homeController.language ==
                                            Language.Japanese,
                                        leading: Radio(
                                          value: Language.Japanese,
                                          groupValue: homeController.language,
                                          onChanged: (value) => homeController
                                              .selectedLanguage(value),
                                        ),
                                      ),
                                    ],
                                  )),
                          actions: <Widget>[
                            FlatButton(
                                child: Text(
                                  'ok'.tr,
                                  style: TextStyle(color: themeColor),
                                ),
                                onPressed: () async {
                                  prefs = await SharedPreferences.getInstance();
                                  Get.updateLocale(
                                      prefs.getString("lang") == "en"
                                          ? Locale('en', 'US')
                                          : Locale('ja', 'JP'));

                                  main();
                                  Get.back();
                                }),
                          ]);
                    });
                break;
            }
          },
          icon: Icon(
            Icons.settings,
            size: 30,
            color: Colors.black,
          ),
        );

    return Scaffold(
        appBar: AppBar(
          title: Text("dashboard".tr, style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: Platform.isIOS ? true : false,
          centerTitle: true,
          elevation: 0,
          actions: <Widget>[_simplePopup()],
        ),
        body: SingleChildScrollView(
          child: SafeArea(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: h > 700 ? h / 4 : h / 3.5,
                child: Card(
                  elevation: 0,
                  child: GetBuilder<HomeController>(
                      builder: (_) => Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    backgroundImage: AssetImage(
                                      homeController
                                              ?.userDetails?.profileImage ??
                                          "assets/images/profile_image.png",
                                    ),
                                    maxRadius: h / 16,
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 10)),
                                  Column(
                                    children: [
                                      Text(
                                          homeController?.userDetails?.name ??
                                              "NA",
                                          style: TextStyle(fontSize: 17)),
                                      Transform(
                                          transform: new Matrix4.identity()
                                            ..scale(1.2),
                                          child: new Chip(
                                              shape: StadiumBorder(
                                                  side: BorderSide(
                                                      color:
                                                          Color(0xff5a82e8))),
                                              backgroundColor: Colors.white,
                                              label: Row(
                                                children: [
                                                  Text(
                                                    homeController?.userDetails
                                                            ?.rating ??
                                                        "0",
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        color:
                                                            Color(0xff5a82e8),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 5)),
                                                  Text('rating'.tr,
                                                      style: TextStyle(
                                                          fontSize: 10)),
                                                ],
                                              )))
                                    ],
                                  )
                                ],
                              ),
                              Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Container(
                                      height: h > 700 ? h / 13 : h / 11,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: w * 0.3,
                                            child: Padding(
                                                padding:
                                                    EdgeInsets.only(top: 6),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                        homeController
                                                                ?.userDetails
                                                                ?.tournamentsPlayed ??
                                                            "0",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color:
                                                                Colors.white)),
                                                    Text("tournaments".tr,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white)),
                                                    Text("played".tr,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white)),
                                                  ],
                                                )),
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment(0.8, 0.0),
                                                colors: [
                                                  const Color(0xffd98831),
                                                  const Color(0xffe0a238),
                                                ], // red to yellow
                                                tileMode: TileMode.clamp,
                                              ),
                                              shape: BoxShape.rectangle,
                                              borderRadius:
                                                  BorderRadius.horizontal(
                                                left: Radius.circular(50.0),
                                              ),
                                            ),
                                          ),
                                          Container(
                                              color: Colors.white, width: 1),
                                          Container(
                                              width: w * 0.3,
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment(0.8, 0.0),
                                                colors: [
                                                  const Color(0xff7145a6),
                                                  const Color(0xff8852b1),
                                                ],
                                                tileMode: TileMode.clamp,
                                              )),
                                              child: Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 6),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                          homeController
                                                                  ?.userDetails
                                                                  ?.tournamentsWon ??
                                                              "0",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: Colors
                                                                  .white)),
                                                      Text("tournaments".tr,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)),
                                                      Text("won".tr,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)),
                                                    ],
                                                  ))),
                                          Container(
                                              color: Colors.white, width: 1),
                                          Container(
                                            // height: 100,
                                            width: w * 0.3,
                                            child: Padding(
                                                padding:
                                                    EdgeInsets.only(top: 6),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                        (int.parse(homeController?.userDetails?.tournamentsWon ?? "0",
                                                                        radix:
                                                                            10) /
                                                                    int.parse(
                                                                        homeController?.userDetails?.tournamentsPlayed ??
                                                                            "1",
                                                                        radix:
                                                                            10) *
                                                                    100)
                                                                .toStringAsFixed(
                                                                    0) +
                                                            "%",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color:
                                                                Colors.white)),
                                                    Text("winning".tr,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white)),
                                                    Text("percentage".tr,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white)),
                                                  ],
                                                )),
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment(0.8, 0.0),
                                                colors: [
                                                  const Color(0xffdd644f),
                                                  const Color(0xffe18158),
                                                ],
                                                tileMode: TileMode.clamp,
                                              ),
                                              shape: BoxShape.rectangle,
                                              borderRadius:
                                                  BorderRadius.horizontal(
                                                right: Radius.circular(50.0),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )))
                            ],
                          )),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, bottom: 10),
                child: Text("recommended_or_you".tr,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              Container(
                  height: h - h / 4 - appBarHeight - 64,
                  child: GetBuilder<HomeController>(builder: (_) {
                    return homeController.isLoading
                        ? Center(child: CircularProgressIndicator())
                        : homeController.error != ""
                            ? Text("no_data_found".tr)
                            : ListView.builder(
                                itemCount: homeController.lengthOfTournamentList
                                    .toInt(),
                                itemBuilder: (context, index) {
                                  // pr.hide();
                                  return Padding(
                                      padding: EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                          top: 5,
                                          bottom: 5),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: Column(
                                          children: [
                                            ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(15.0),
                                                  topRight:
                                                      Radius.circular(15.0),
                                                ),
                                                child: Image.network(
                                                  homeController
                                                      .tournament
                                                      .data
                                                      .tournaments[index]
                                                      .coverUrl
                                                      .toString(),
                                                  loadingBuilder: (context,
                                                      child, loadingProgress) {
                                                    return loadingProgress !=
                                                            null
                                                        ? CircularProgressIndicator()
                                                        : child;
                                                  },
                                                )),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10,
                                                                top: 10,
                                                                bottom: 5),
                                                        child: Text(
                                                            homeController.tournament.data.tournaments[index].name
                                                                        .toString()
                                                                        .length >
                                                                    20
                                                                ? homeController
                                                                        .tournament
                                                                        .data
                                                                        .tournaments[
                                                                            index]
                                                                        .name
                                                                        .toString()
                                                                        .substring(
                                                                            0, 20) +
                                                                    "..."
                                                                : homeController
                                                                    .tournament
                                                                    .data
                                                                    .tournaments[
                                                                        index]
                                                                    .name
                                                                    .toString(),
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 17))),
                                                    Padding(
                                                        padding: EdgeInsets.only(
                                                            left: 10,
                                                            top: 7,
                                                            bottom: 5),
                                                        child: Text(
                                                            homeController.tournament.data.tournaments[index].gameName.toString().length > 30
                                                                ? homeController
                                                                        .tournament
                                                                        .data
                                                                        .tournaments[
                                                                            index]
                                                                        .gameName
                                                                        .toString()
                                                                        .substring(
                                                                            0, 30) +
                                                                    "..."
                                                                : homeController
                                                                    .tournament
                                                                    .data
                                                                    .tournaments[
                                                                        index]
                                                                    .gameName
                                                                    .toString(),
                                                            softWrap: true,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight.w500,
                                                                fontSize: 15,
                                                                color: Colors.grey[600]))),
                                                  ],
                                                ),
                                                Icon(Icons.arrow_forward_ios)
                                              ],
                                            )
                                          ],
                                        ),
                                      ));
                                });
                  }))
            ],
          )),
        ));
  }
}
