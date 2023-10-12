import 'package:kurd_tree/src/constants/assets.dart';

class KTSocialModel {
  String? uid;
  String? type;
  String? url;
  String? name;

  KTSocialModel({
    this.uid,
    this.type,
    this.url,
    this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "type": type,
      "url": url,
      "name": name,
    };
  }

  factory KTSocialModel.fromFirebaseData(Map<String, dynamic> map) {
    return KTSocialModel(
      uid: map['uid'],
      type: map['type'],
      url: map['url'],
      name: map['name'],
    );
  }

  String get icon {
    switch (type) {
      case KTSocialType.facebook:
        return Assets.resourceIconFacebook;
      case KTSocialType.instagram:
        return Assets.resourceIconInstagram;
      case KTSocialType.youtube:
        return Assets.resourceIconYoutube;
      case KTSocialType.whatsapp:
        return Assets.resourceIconWhatsapp;
      default:
        return Assets.resourceIconLink;
    }
  }
}

class KTSocialType {
  static const String facebook = "facebook";
  static const String instagram = "instagram";
  static const String youtube = "youtube";
  static const String whatsapp = "whatsapp";
  //TODO add all socials
}
