import 'package:flutter/widgets.dart';
import 'package:krita/backend/ngo/database/ngoCreatePost.dart';
import '../backend/ngo/models/NgoCreatePostModel.dart';
import 'package:krita/provider/authentication.dart';

class NgoCreatePostProvider extends ChangeNotifier {
  final NgoCreatePost _createPost = NgoCreatePost();
  List<NgoPosts> _posts = [];

  List<NgoPosts> get posts => _posts;

  void loadPosts(String uid) {
    _createPost.getPosts(uid).listen((posts) {
      _posts = posts.cast<NgoPosts>();

      notifyListeners();
    });
  }

}