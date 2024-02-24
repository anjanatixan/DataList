import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_profile/database/helperclass.dart';
import 'package:user_profile/helper/utils.dart';
import 'package:user_profile/provider/loginprovider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  dynamic email = "";
  dynamic token = "";

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0), () async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      email = preferences.getString("email");
      token = preferences.getString("token");
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey.shade100,
          centerTitle: true,
          title: Text(
            "Profile",
            style: GoogleFonts.lato(
                fontSize: 15.sp,
                color: Colors.black,
                fontWeight: FontWeight.w600),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text('Are you sure you want to logout?'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop(); 
                            },
                          ),
                          TextButton(
                            child: Text('Logout'),
                            onPressed: () {
                              getContext().read<LoginProvider>().Logout();
                              DatabaseHelper().clearDatabase();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: Icon(
                  Icons.logout_outlined,
                  color: Colors.black,
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(10.r)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Center(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 30.r,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.account_circle_outlined),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Email ID : ",
                                  style: GoogleFonts.lato(
                                      fontSize: 14.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500)),
                              Text(email.toString(),
                                  style: GoogleFonts.lato(
                                      fontSize: 14.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(token.toString(),
                              style: GoogleFonts.lato(
                                  fontSize: 14.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
