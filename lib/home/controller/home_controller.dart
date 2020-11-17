import 'dart:convert';

import 'package:app_developer_assignment/home/model/tournament_details.dart';
import 'package:app_developer_assignment/home/model/user_details_model.dart';
import 'package:app_developer_assignment/home/ui/home.dart';
import 'package:app_developer_assignment/login/controller/login_controller.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  var tournament = TournamentDetails();
  var userDetails = UserDetails();
  var lengthOfTournamentList = 0;
  var isLoading = true;
  var error = "";
  var language = Language.English;
  LoginController loginContr = Get.find();
  SharedPreferences prefs;

  @override
  void onInit() {
    _userDetails();
    _fetchData();

    selectLanguage();
    super.onInit();
  }

  selectLanguage() async {
    prefs = await SharedPreferences.getInstance();

    if (prefs.getString("lang") == "en")
      language = Language.English;
    else if (prefs.getString("lang") == "ja")
      language = Language.Japanese;
    else
      language = Language.English;
  }

  _userDetails() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      rootBundle.loadString("assets/user_details.json").then((jsonStr) {
        userDetails = UserDetails.fromJson(json.decode(jsonStr));
      });
    } else {
      error = "connectivity_issue".tr;
    }
    update();
  }

  _fetchData() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Response response;
      try {
        response = await Dio().get(
            "http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2?limit=10&status=all");

        tournament = TournamentDetails.fromJson(response.data);
        lengthOfTournamentList = tournament.data.tournaments.length;
        if (response != null) isLoading = false;
      } catch (e) {
        isLoading = false;
        error = e.toString();
        print("Exception==>" + e.toString());
      }
    } else {
      error = "connectivity_issue".tr;
    }
    update();
  }

  selectedLanguage(val) async {
    language = val;

    prefs = await SharedPreferences.getInstance();
    prefs.setString("lang", language == Language.English ? "en" : "ja");
    update();
  }
}
