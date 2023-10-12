// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:kurd_tree/src/models/kt_social_model.dart';

class KTUser {
  String? uid;
  String? fullName;
  String? bio;
  String? profilePictureUrl;
  String? coverPictureUrl;
  String? email;

  List<KTSocialModel>? socials;

  Timestamp? createdAt;
  Timestamp? updatedAt;

  KTUser({
    this.uid,
    this.fullName,
    this.bio,
    this.profilePictureUrl,
    this.coverPictureUrl,
    this.email,
    this.socials,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'fullName': fullName,
      'bio': bio,
      'profilePictureUrl': profilePictureUrl,
      'coverPictureUrl': coverPictureUrl,
      'email': email,
      'socials': socials?.map((e) => e.toMap()),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory KTUser.fromMap(Map<String, dynamic> map) {
    return KTUser(
      uid: map['uid'],
      fullName: map['fullName'],
      bio: map['bio'],
      profilePictureUrl: map['profilePictureUrl'],
      coverPictureUrl: map['coverPictureUrl'],
      email: map['email'],
      socials: (map['socials'] as List<dynamic>)
          .map((e) => KTSocialModel.fromFirebaseData(e as Map<String, dynamic>))
          .toList(),
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  Future<void> save() async {
    createdAt = Timestamp.now();
    updatedAt = Timestamp.now();
    return FirebaseFirestore.instance.collection('users').doc(uid).set(toMap());
  }

  Future<void> update() async {
    updatedAt = Timestamp.now();
    return FirebaseFirestore.instance.collection('users').doc(uid).set(toMap());
  }

  static Future<KTUser> getUser({required String userUID}) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userUID)
        .get()
        .then((value) => KTUser.fromMap(value.data()!));
  }



}
