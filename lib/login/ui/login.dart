import 'package:app_developer_assignment/home/ui/home.dart';
import 'package:app_developer_assignment/login/controller/login_controller.dart';
import 'package:app_developer_assignment/utils/globals.dart';
import 'package:app_developer_assignment/utils/reusable_widgets.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Login extends StatelessWidget {
  GlobalKey<FormState> _login = new GlobalKey<FormState>();

  SharedPreferences sharedPreferences;
  TextEditingController userController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  ProgressDialog pr;
  final controller = Get.put(LoginController());

  Map<String, String> userInfo1 = {"user": "9898989898", "pass": "password12"};
  Map<String, String> userInfo2 = {"user": "1234567890", "pass": "password12"};

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    // double w = MediaQuery.of(context).size.width;
    Future<bool> _onWillPop() {
      return showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('alert'.tr),
              content: new Text('sure_alert'.tr),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: new Text('no_button'.tr,
                      style: TextStyle(color: themeColor)),
                ),
                new FlatButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: new Text('yes_button'.tr,
                      style: TextStyle(color: themeColor)),
                ),
              ],
            ),
          ) ??
          false;
    }

    _loginAction(userName, password) async {
      if (userName == "") {
        ReusableWidgets.showDialogBox(context, Text("username_empty_error".tr));
      } else if (userName.toString().length < 3) {
        ReusableWidgets.showDialogBox(
            context, Text("username_3_length_error".tr));
      } else if (userName.toString().length > 10) {
        ReusableWidgets.showDialogBox(
            context, Text("username_10_length_error".tr));
      } else if (password == "") {
        ReusableWidgets.showDialogBox(context, Text("password_empty_error".tr));
      } else if (password.toString().length < 3) {
        ReusableWidgets.showDialogBox(
            context, Text("password_3_length_error".tr));
      } else if (password.toString().length > 10) {
        ReusableWidgets.showDialogBox(
            context, Text("password_10_length_error".tr));
      } else {
        try {
          pr = ProgressDialog(context,
              type: ProgressDialogType.Normal,
              isDismissible: false,
              showLogs: false);
          pr.style(message: "sign_in_message".tr);
          pr.show();
          Future.delayed(Duration(seconds: 1)).then((value) {
            pr.hide().whenComplete(() {
              if ((userInfo1["user"] == userName &&
                      userInfo1["pass"] == password) ||
                  (userInfo2["user"] == userName &&
                      userInfo2["pass"] == password)) {
                controller.isLoggedInCheck(true);
                Get.to(HomePage());
              } else
                ReusableWidgets.showDialogBox(context, Text("invalid_data".tr));
            });
          });
        } catch (e) {
          print(e);
        }
      }
    }

    final logo = Container(
        width: 150.0,
        height: 160.0,
        decoration: new BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            image: new DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/logo.png"))));

    final userTextField = Padding(
        padding: EdgeInsets.all(15),
        child: Container(
            child: TextFormField(
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.account_box),
              border: OutlineInputBorder(),
              labelText: "username_label".tr,
              hintText: "username_hint".tr,
              counterText: ""),
          // maxLength: 10,
          autofocus: false,
          controller: userController,
        )));

    final passwordTextField = GetBuilder<LoginController>(
        builder: (_) => Padding(
            padding: EdgeInsets.all(15),
            child: Container(
                child: TextFormField(
              // maxLength: 10,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)),
                labelText: "password_label".tr,
                hintText: "password_hint".tr,
                prefixIcon: Icon(Icons.lock),
                counterText: "",
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.passwordVisible
                        ? (Icons.visibility_off)
                        : (Icons.visibility),
                  ),
                  onPressed: () => controller.visiblePassword(),
                ),
              ),
              controller: passwordController,
              autofocus: false,
              obscureText: controller.passwordVisible,
            ))));

    final loginButton = Container(
        margin: EdgeInsets.only(top: h / 70),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              "sign_in_button".tr,
              style: TextStyle(
                  color: Color(0xff62347a),
                  fontSize: 24,
                  fontWeight: FontWeight.w500),
            ),
            Container(
              height: h / 12,
              width: h / 12,
              child: RaisedButton(
                color: themeColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                elevation: 3,
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 35,
                ),
                onPressed: () async {
                  var connectivityResult =
                      await (Connectivity().checkConnectivity());
                  if (connectivityResult == ConnectivityResult.mobile ||
                      connectivityResult == ConnectivityResult.wifi) {
                    _loginAction(userController.text.trim(),
                        passwordController.text.trim());
                  } else {
                    ReusableWidgets.showDialogBox(
                        context, Text("connectivity_issue".tr));
                  }
                },
              ),
            ),
          ],
        ));

    return new WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            body: SafeArea(
                child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: SingleChildScrollView(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: h / 5,
                        ),
                        logo,
                        Form(
                          key: _login,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(20.0),
                              ),
                              userTextField,
                              passwordTextField,
                              loginButton,
                              Padding(
                                padding: EdgeInsets.all(10.0),
                              ),
                            ],
                          ),
                        )
                      ],
                    ))))));
  }
}
