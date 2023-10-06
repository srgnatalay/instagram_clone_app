import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String photoUrl;
  final String postId;
  final String postUrl;
  final String username;
  final String profileImg;
  final Timestamp datePublished;
  final likes;

  Post({
    required this.description,
    required this.username,
    required this.uid,
    required this.photoUrl,
    required this.postId,
    required this.datePublished,
    required this.likes,
    required this.postUrl,
    required this.profileImg,
  });

  Map<String, dynamic> toJson() => {
        "postId": postId,
        "uid": uid,
        "username": username,
        "description": description,
        "datePublished": datePublished,
        "postUrl": postUrl,
        "profileImg": profileImg,
        "photoUrl": photoUrl,
        "likes": likes,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      username: snapshot["username"],
      postId: snapshot["postId"],
      uid: snapshot["uid"],
      description: snapshot["description"],
      photoUrl: snapshot["photoUrl"],
      datePublished: snapshot["datePublished"],
      postUrl: snapshot["postUrl"],
      profileImg: snapshot["profileImg"],
      likes: snapshot["likes"],
    );
  }
}
