import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:kurd_tree/src/constants/assets.dart';
import 'package:kurd_tree/src/helper/k_helper.dart';
import 'package:kurd_tree/src/helper/k_widgets.dart';
import 'package:kurd_tree/src/helper/spcolor.dart';
import 'package:kurd_tree/src/models/kt_social_model.dart';
import 'package:kurd_tree/src/models/kt_user_model.dart';
import 'package:kurd_tree/src/providers/auth_provider.dart';
import 'package:kurd_tree/src/screens/profile_screen.dart';
import 'package:kurd_tree/src/widgets/k_text_filed.dart';
import 'package:kurd_tree/src/widgets/k_text_filed_social.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late AuthProvider authProvider;

  KTUser? get cUser => authProvider.user;

  setUserData() {
    authProvider = Provider.of(Get.context!);
    fullNameTEC.text = cUser?.fullName ?? "";
    bioTEC.text = cUser?.bio ?? "";
    emailTEC.text = cUser?.email ?? "";

    for (KTSocialModel social in cUser?.socials ?? []) {
      switch (social.type) {
        case KTSocialType.instagram:
          instagramTEC.text = social.name ?? "";
          instagramUrlTEC.text = social.url ?? "";
          break;
        case KTSocialType.youtube:
          youtubeTEC.text = social.name ?? "";
          youtubeUrlTEC.text = social.url ?? "";
          break;
        case KTSocialType.whatsapp:
          whatsappTEC.text = social.name ?? "";
          break;
        // case KTSocialType.telegram:
        //   break;
        // case KTSocialType.viber:
        //   break;
        // case KTSocialType.paypal:
        //   break;
        case KTSocialType.facebook:
          break;
      }
    }
  }

  var fullNameTEC = TextEditingController();
  var bioTEC = TextEditingController();
  var emailTEC = TextEditingController();

  var instagramTEC = TextEditingController();
  var instagramUrlTEC = TextEditingController();
  var youtubeTEC = TextEditingController();
  var youtubeUrlTEC = TextEditingController();
  var whatsappTEC = TextEditingController();

  File? coverImgFile;
  File? profileImgFile;

  String? coverImgURL;
  String? profileImgURL;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    setUserData();
  }

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          KWidget.btnIcon(
              image: Assets.resourceIconUpload,
              onTap: () {
                onSave();
              }),
        ],
      ),
      backgroundColor: SPColors.dark,
      body: Stack(
        children: [body, KWidget.loadingView(isLoading)],
      ),
    );
  }

  Widget get body {
    return SingleChildScrollView(
      child: Column(children: [
        Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: (Get.width / (16 / 9) - 32) +
                  70 +
                  (MediaQuery.of(context).padding.top),
            ),
            coverPictureWidget(),
            Positioned(
              right: 20,
              bottom: 80,
              child: GestureDetector(
                onTap: () {
                  pickCoverImage();
                },
                child: SafeArea(
                  child: Container(
                    decoration: BoxDecoration(
                      color: SPColors.main.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                      Assets.resourceIconAddImage,
                      color: Colors.white,
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
              ),
            ),
            profilePictureWidget(),
            Positioned(
              right: 30,
              left: 140,
              bottom: 20,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    fullNameTEC.text.trim(),
                    style: SPColors.lightStyle(
                      30,
                      weight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Image.asset(
                    Assets.resourceIconVerified,
                    width: 25,
                    height: 25,
                  )
                ],
              ),
            ),
            Positioned(
              left: 100,
              bottom: 0,
              child: GestureDetector(
                onTap: () {
                  pickProfileImage();
                },
                child: SafeArea(
                  child: Container(
                    decoration: BoxDecoration(
                      color: SPColors.main.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                      Assets.resourceIconAddImage,
                      color: Colors.white,
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            children: [
              Text(
                "User Info",
                style: SPColors.lightStyle(22),
              ),
            ],
          ),
        ),
        KTextField(
          controller: bioTEC,
          dynamicHeight: true,
          hint: "Bio",
        ),
        KTextField(
          controller: fullNameTEC,
          onChanged: (_) {
            setState(() {});
          },
          hint: "Full name",
          icon: Assets.resourceIconUser,
        ),
        KTextField(
          controller: emailTEC,
          hint: "Email",
          icon: Assets.resourceIconMail,
          isEnable: false,
        ),
        KTextField(
          controller: TextEditingController(),
          hint: "Password",
          icon: Assets.resourceIconPassword,
          isPassword: true,
          isEnable: false,
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            children: [
              Text("Social Media", style: SPColors.lightStyle(22)),
            ],
          ),
        ),
        KTextFieldSocial(
          controller: instagramTEC,
          controllerUrl: instagramUrlTEC,
          hint: "@Salar_Pro",
          icon: Assets.resourceIconInstagram,
          socialName: "Instagram",
        ),
        KTextFieldSocial(
          controller: youtubeTEC,
          controllerUrl: youtubeUrlTEC,
          hint: "@SalarPro",
          icon: Assets.resourceIconYoutube,
          socialName: "Youtube",
        ),
        KTextFieldSocial(
          controller: whatsappTEC,
          hasLink: false,
          hint: "+964 (0)750 350 5440",
          icon: Assets.resourceIconWhatsapp,
          socialName: "Whatsapp",
          isPhoneNumber: true,
        ),
        KTextFieldSocial(
          hasLink: false,
          controller: TextEditingController(),
          hint: "+964 (0)750 350 5440",
          icon: Assets.resourceIconTelegram,
        ),
        KTextFieldSocial(
          hasLink: false,
          controller: TextEditingController(),
          hint: "+964 (0)750 350 5440",
          icon: Assets.resourceIconViber,
        ),
        KTextFieldSocial(
          controller: TextEditingController(),
          hint: "PayPal",
          icon: Assets.resourceIconPaypal,
        ),
        KTextFieldSocial(
          controller: TextEditingController(),
          hint: "Salar Khalid",
          icon: Assets.resourceIconFacebook,
        ),
        const SizedBox(height: 50),
        KWidget.btnMedium(
            title: "Save",
            image: Assets.resourceIconUpload,
            onTap: () {
              onSave();
            }),
        const SizedBox(height: 100),
        KWidget.btnMedium(
            title: "SingOut",
            image: Assets.resourceIconUser,
            onTap: () {
              showSignOutAlert();
            }),
        const SizedBox(height: 100),
      ]),
    );
  }

  Positioned coverPictureWidget() {
    Widget coverImage;

    if (coverImgFile != null) {
      coverImage = Image.file(
        coverImgFile!,
        fit: BoxFit.cover,
      );
    } else if (cUser?.coverPictureUrl != null) {
      coverImage = CachedNetworkImage(
        imageUrl: cUser!.coverPictureUrl!,
        fit: BoxFit.cover,
      );
    } else {
      coverImage = Image.asset(
        Assets.resourceIconUser,
        fit: BoxFit.cover,
      );
    }

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height:
            Get.width / (16 / 9) - 32 + (MediaQuery.of(context).padding.top),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          child: coverImage,
        ),
      ),
    );
  }

  Positioned profilePictureWidget() {
    Widget profileImage;

    if (profileImgFile != null) {
      profileImage = Image.file(
        profileImgFile!,
        fit: BoxFit.cover,
      );
    } else if (cUser?.profilePictureUrl != null) {
      profileImage = CachedNetworkImage(
        imageUrl: cUser!.profilePictureUrl!,
        fit: BoxFit.cover,
      );
    } else {
      profileImage = Image.asset(
        Assets.resourceIconUser,
        fit: BoxFit.cover,
      );
    }
    return Positioned(
      left: 30,
      bottom: 0,
      child: SizedBox(
        width: 100,
        height: 100,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: profileImage,
        ),
      ),
    );
  }

  void pickCoverImage() async {
    coverImgFile = await KHelper.pickImageFromGallery(cropTheImage: false);
    setState(() {});
  }

  void pickProfileImage() async {
    profileImgFile = await KHelper.pickImageFromGallery(cropTheImage: false);
    setState(() {});
  }

  onSave() async {
    //Check inputs
    if (fullNameTEC.text.trim().isEmpty) {
      KHelper.showSnackBar("Please enter your full name");
      return;
    }

    if (!emailTEC.text.isEmail) {
      KHelper.showSnackBar("Please enter your email");
      return;
    }

    List<KTSocialModel> socials = [];

    if (instagramTEC.text.trim().isNotEmpty) {
      print(instagramUrlTEC.text);
      if (instagramUrlTEC.text.isURL) {
        socials.add(KTSocialModel(
          name: instagramTEC.text.trim(),
          url: instagramUrlTEC.text.trim(),
          type: KTSocialType.instagram,
        ));
      } else {
        KHelper.showSnackBar("Please enter a valid instagram url");
        return;
      }
    }

    if (youtubeTEC.text.trim().isNotEmpty) {
      print(youtubeUrlTEC.text);
      if (youtubeUrlTEC.text.isURL) {
        socials.add(KTSocialModel(
          name: youtubeTEC.text.trim(),
          url: youtubeUrlTEC.text.trim(),
          type: KTSocialType.youtube,
        ));
      } else {
        KHelper.showSnackBar("Please enter a valid Youtube url");
        return;
      }
    }

    if (whatsappTEC.text.trim().isNotEmpty) {
      var phone = whatsappTEC.text
          .trim()
          .replaceAll(" ", "")
          .replaceAll(")", "")
          .replaceAll("(", "");
      if (phone.length == 14) {
        socials.add(KTSocialModel(
          name: whatsappTEC.text.trim(),
          url: "https://wa.me/$phone",
          type: KTSocialType.whatsapp,
        ));
      } else {
        KHelper.showSnackBar(
            "Please enter a valid Phone number ex: +964 7## ### ####");
        return;
      }
    }

    //Viber
    /* if (whatsappTEC.text.trim().isNotEmpty) {
      var phone = whatsappTEC.text
          .trim()
          .replaceAll(" ", "")
          .replaceAll("+", "")
          .replaceAll(")", "")
          .replaceAll("(", "");
      if (phone.length == 13) {
        socials.add(KTSocialModel(
          name: youtubeTEC.text.trim(),
          url: "viber://chat?number=$phone", //viber://chat?number=964750350540
          type: KTSocialType.youtube,
        ));
      } else {
        KHelper.showSnackBar(
            "Please enter a valid Phone number ex: +964 7## ### ####");
        return;
      }
    } */

    setState(() {
      isLoading = true;
    });

    cUser!.socials = socials;

    // upload data
    if (coverImgFile != null) {
      coverImgURL = await uploadMedia(coverImgFile!);
      cUser!.coverPictureUrl = coverImgURL;
    }
    if (profileImgFile != null) {
      profileImgURL = await uploadMedia(profileImgFile!);
      cUser!.profilePictureUrl = profileImgURL;
    }

    // prepare data
    cUser!.fullName = fullNameTEC.text.trim();
    cUser!.bio = bioTEC.text.trim();
    // cUser!.email = emailTEC.text.trim();

    // update user data
    await cUser!.update();
    if (Navigator.of(context).canPop()) {
      Get.back();
    } else {
      Get.offAll(() => const ProfileScreen());
    }
  }

  Future<String?> uploadMedia(File myImageFile) async {
    var ref = FirebaseStorage.instance.ref().child("user_media");

    var uploadFileName = "${Uuid().v4()}.png";
    ref = ref.child(uploadFileName);

    try {
      await ref.putFile(myImageFile);
    } on FirebaseException catch (e) {
      print(e.message.toString());
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error while uploading the image")));

      return null;
    }

    var downloadUrl = await ref.getDownloadURL();

    return downloadUrl;
  }

  void showSignOutAlert() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog.adaptive(
            title: Text("Are you sure you want to sign out?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  authProvider.signOut();
                  Navigator.of(context).pop();
                },
                child: Text("Sign out"),
              ),
            ],
          );
        });
  }
}
