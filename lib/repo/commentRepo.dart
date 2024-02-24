import 'dart:convert';
import 'package:user_profile/database/helperclass.dart';
import 'package:user_profile/model/commentModel.dart';
import 'package:http/http.dart' as http;

class CommentRepo {
   final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<List<Comment>> CommentList() async {
       final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));
       if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Comment.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load comments from API');
    }
  }

  Future<void> cacheCommentsLocally(List<Comment> comments) async {
    for (var comment in comments) {
      await _databaseHelper.insertComment(comment);
    }
  }
}
