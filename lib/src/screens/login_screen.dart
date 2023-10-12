import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kurd_tree/src/constants/assets.dart';
import 'package:kurd_tree/src/helper/k_helper.dart';
import 'package:kurd_tree/src/helper/k_widgets.dart';
import 'package:kurd_tree/src/helper/spcolor.dart';
import 'package:kurd_tree/src/providers/auth_provider.dart';
import 'package:kurd_tree/src/screens/edit_profile_screen.dart';
import 'package:kurd_tree/src/screens/profile_screen.dart';
import 'package:kurd_tree/src/widgets/k_text_filed.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailETC = TextEditingController();
  var passwordETC = TextEditingController();

  bool isLoading = false;
  bool showSplash = true;

  var isContainCapital = false;
  var isContainSmall = false;
  var isContainNumber = false;
  var isContainSymbols = false;
  var isContainMoreThan8 = false;

  checkUser() async {
    await 2.delay();
    var isLogged = await Provider.of<AuthProvider>(context, listen: false)
        .checkUserIsLoggedIn();
    if (isLogged) {
      Get.offAll(() => const ProfileScreen());
    } else {
      setState(() {
        showSplash = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SPColors.dark,
      body: Stack(
        children: [
          SizedBox(
            height: Get.height,
          ),
          body,
          KWidget.loadingView(isLoading),
          AnimatedPositioned(
            duration: 1.seconds,
            curve: Curves.easeInOut,
            left: 0,
            right: 0,
            top: 0,
            bottom: showSplash ? 0 : Get.height,
            child: Container(
              height: Get.height,
              color: SPColors.light,
              child: Center(
                child: Lottie.asset(
                  Assets.resourceIconLotiteSocial,
                  width: Get.width / 2,
                  height: Get.width / 2,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget get body => SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 100, left: 40, right: 40),
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: SPColors.main,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color:
                        const Color.fromARGB(255, 0, 255, 76).withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 0,
                    offset: Offset(4, 6), // changes position of shadow
                  )
                ],
              ),
              child: Center(
                child: Text(
                  "Kurd Tree",
                  style: SPColors.lightStyle(50,
                      weight: FontWeight.bold, color: SPColors.dark),
                ),
              ),
            ),
            const SizedBox(height: 50),
            KTextField(
              controller: emailETC,
              icon: Assets.resourceIconMail,
              title: "Email",
            ),
            KTextField(
              controller: passwordETC,
              icon: Assets.resourceIconPassword,
              title: "Password",
              // isPassword: true,
              onChanged: (value) {
                isContainCapital = value.contains(RegExp(r'[A-Z]'));
                isContainSmall = value.contains(RegExp(r'[a-z]'));
                isContainNumber = value.contains(RegExp(r'[0-9]'));
                isContainSymbols = value.contains(RegExp(r'\W'));
                isContainMoreThan8 = value.length >= 8;
                setState(() {});
              },
            ),
            Row(
              children: [
                const SizedBox(width: 25),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    passwordInfo(isContainCapital, "isContainCapital"),
                    passwordInfo(isContainSmall, "isContainSmall"),
                    passwordInfo(isContainNumber, "isContainNumber"),
                    passwordInfo(isContainSymbols, "isContainSymbols"),
                    passwordInfo(isContainMoreThan8, "isContainMoreThan8"),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                KWidget.btnMedium(
                  title: "Login",
                  onTap: () {
                    login();
                  },
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      register();
                    },
                    child: Text(
                      "Register now",
                      style: SPColors.lightStyle(12),
                    ))
              ],
            )
          ],
        ),
      );

  void register() async {
    // validation
    var email = emailETC.text.trim();
    if (!email.isEmail) {
      KHelper.showSnackBar("Please enter a valid email");
      return;
    }

    if (!isContainCapital ||
        !isContainSmall ||
        !isContainNumber ||
        !isContainSymbols ||
        !isContainMoreThan8) {
      KHelper.showSnackBar("Password is not valid please try again");
      return;
    }

    var password = passwordETC.text;

    setState(() {
      isLoading = true;
    });

    var isRegistered = await Provider.of<AuthProvider>(context, listen: false)
        .registerWithEmailPassword(email: email, password: password);

    if (isRegistered) {
      Get.offAll(() => const EditProfileScreen());
    }

    setState(() {
      isLoading = false;
    });
  }

  void login() async {
    var email = emailETC.text.trim();
    if (!email.isEmail) {
      KHelper.showSnackBar("Please enter a valid email");
      return;
    }

    var password = passwordETC.text;

    setState(() {
      isLoading = true;
    });

    var isRegistered = await Provider.of<AuthProvider>(context, listen: false)
        .loginWithEmailPassword(email: email, password: password);

    if (isRegistered) {
      setState(() {
        showSplash = true;
      });

      await 1.delay();

      Get.offAll(() => const ProfileScreen());
    }

    setState(() {
      isLoading = false;
    });
  }

  passwordInfo(bool isTrue, String s) {
    return RichText(
        text: TextSpan(text: s, style: SPColors.lightStyle(12), children: [
      TextSpan(
          text: ": ",
          style: SPColors.lightStyle(12,
              color: isTrue ? SPColors.main : Color.fromARGB(255, 9, 85, 28))),
      TextSpan(
          text: isTrue ? "true" : "false",
          style: SPColors.lightStyle(12,
              color: isTrue ? SPColors.main : Color.fromARGB(255, 9, 85, 28)))
    ]));
  }
}