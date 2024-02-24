import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_profile/helper/navigation.dart';
import 'package:user_profile/helper/utils.dart';
import 'package:user_profile/model/loginModel.dart';
import 'package:user_profile/repo/loginRepo.dart';
import 'package:user_profile/views/bottomNavBar.dart';
import 'package:user_profile/views/loginScreen.dart';

class LoginProvider with ChangeNotifier {
  LoginModel? loginModel;
  LoginRepo loginRepo = LoginRepo();
  String? useremail;
  String? password;

  setUserEmail(String text) {
    this.useremail = text;
  }

  setPassword(String text) {
    this.password = text;
  }

  login() async {
    showLoading(getContext());
    await loginRepo.Login();
    NavigationUtils.goBack(getContext());
  }

  Logout()async{
   SharedPreferences preferences = await SharedPreferences.getInstance();
   NavigationUtils.goNextFinishAll(getContext(), LoginScreen());
   preferences.clear();
  }


  setLoginModel(LoginModel model)async {
    this.loginModel = model;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("token", this.loginModel!.token.toString());
    preferences.setString("email", useremail.toString());
    NavigationUtils.goNextFinishAll(getContext(), BottomNavBar());
    notifyListeners();
  }
}
