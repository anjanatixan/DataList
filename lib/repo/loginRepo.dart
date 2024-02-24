import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_profile/apiServices/urls.dart';
import 'package:user_profile/apiServices/webService.dart';
import 'package:user_profile/helper/utils.dart';
import 'package:user_profile/model/loginModel.dart';
import 'package:user_profile/provider/loginprovider.dart';

class LoginRepo {
  ApiService _service = ApiService();

  Future<String> Login() async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    var body = jsonEncode({
      "email": getContext().read<LoginProvider>().useremail,
      "password": getContext().read<LoginProvider>().password,
    });
    final response = await _service.postResponse(Urls.LOGIN, body, headers);
log(response.statusCode.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      LoginModel model = LoginModel.fromJson(responseBody);
      getContext().read<LoginProvider>().setLoginModel(model);
      log("message" + responseBody.toString());
    } else {
       showToast(getContext(), "user not found", Colors.black, Colors.white);
    }
    return "";
  }
}
