import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_app/models/post.dart';
import 'package:instagram_clone_app/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String profileImg,
  ) async {
    String res = "Bazı sorunlar oluştu";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage("posts", file, true);

      String postId = const Uuid().v1();

      Post post = Post(
        username: username,
        description: description,
        uid: uid,
        photoUrl: photoUrl,
        postId: postId,
        datePublished: Timestamp.fromDate(DateTime.now()),
        postUrl: photoUrl,
        profileImg: profileImg,
        likes: [],
      );

      _firestore.collection("posts").doc(postId).set(post.toJson());
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> likePost(
    String postId,
    String uid,
    List likes,
  ) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection("posts").doc(postId).update({
          "likes": FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection("posts").doc(postId).update({
          "likes": FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      debugPrint(
        e.toString(),
      );
    }
  }

  Future<void> postComment(
    String postId,
    String text,
    String uid,
    String username,
    String profilePic,
  ) async {
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        await _firestore
            .collection("posts")
            .doc(postId)
            .collection("comments")
            .doc(commentId)
            .set({
          "profilePic": profilePic,
          "text": text,
          "username": username,
          "uid": uid,
          "comentId": commentId,
          "datePublished": DateTime.now(),
        });
      } else {
        debugPrint("Yorum boş");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> postDelete(String postId) async {
    try {
      await _firestore.collection("posts").doc(postId).delete();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
