import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:krita/backend/ngo/models/ngoCreatePostModel.dart';
import 'package:krita/provider/authentication.dart';
import 'package:provider/provider.dart';

class NgoCreatePost {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<NgoPosts>> getPosts(String uid) =>
      _firestore.collection('ngoPosts').snapshots().map((snapshot) {
        print(snapshot);
        print('hm');
        return snapshot.docs.map((doc) {
          print(doc);
          print(doc.data());
          print('abcd0');
          print(ngoPostsFromJson(doc.data()));
          print('not');
          return ngoPostsFromJson(doc.data());
        }).toList();
      });

  Future<void> addPosts(String location, DateTime datetime, String quantity,
      List<String> type, String msg, String uid) {
    return _firestore
        // .collection('users')
        // .doc(uid)
        .collection('ngoPosts')
        .doc()
        .set({
      "location": location,
      "datetime": datetime,
      "quantity": quantity,
      "type": type,
      "msg": msg,
      "userId": uid,
    });
  }
}
