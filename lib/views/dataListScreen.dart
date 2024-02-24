import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:user_profile/helper/utils.dart';
import 'package:user_profile/provider/commenProvider.dart';

class DataListScreen extends StatefulWidget {
  const DataListScreen({super.key});

  @override
  State<DataListScreen> createState() => _DataListScreenState();
}

class _DataListScreenState extends State<DataListScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 0), () async {
      await getContext().read<CommentProvider>().Commentprovider();
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
          "Data List",
          style: GoogleFonts.lato(
              fontSize: 15.sp,
              color: Colors.black,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Consumer<CommentProvider>(
        builder: (context, commentProvider, _) {
          final comments = commentProvider.comments;
          return comments.isEmpty
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    return Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade200)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name : " + comment.name,
                            style: GoogleFonts.lato(
                                fontSize: 13.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Email : " + comment.email,
                            style: GoogleFonts.lato(
                                fontSize: 12.sp,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 4),
                          Text(
                            comment.body,
                            style: GoogleFonts.lato(
                                fontSize: 12.sp,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
