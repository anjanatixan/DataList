import 'package:flutter/material.dart';
import 'package:user_profile/database/helperclass.dart';
import 'package:user_profile/model/commentModel.dart';
import 'package:user_profile/repo/commentRepo.dart';

class CommentProvider with ChangeNotifier {
 List<Comment> _comments=[];
  final CommentRepo commentRepo = CommentRepo();

  Commentprovider() {
    _comments = [];
    fetchData();
  }

  List<Comment> get comments => _comments;

  Future<void> fetchData() async {
    try {
      _comments = await commentRepo.CommentList();
      await commentRepo.cacheCommentsLocally(_comments);
    } catch (e) {
      _comments = await DatabaseHelper().getComments();
    }
    notifyListeners();
  }
  
}
