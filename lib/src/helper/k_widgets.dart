import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kurd_tree/src/constants/assets.dart';
import 'package:kurd_tree/src/helper/spcolor.dart';
import 'package:lottie/lottie.dart';

class KWidget {
  static Widget btnIcon({
    required String image,
    Color? bgColor,
    Color? color,
    Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: SPColors.dark.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 0,
              offset: const Offset(2, 4), // changes position of shadow
            ),
          ],
          color: bgColor ?? SPColors.main,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              image,
              width: 22,
              height: 22,
              color: color ?? SPColors.dark,
            ),
          ],
        ),
      ),
    );
  }

  static Widget btnMedium(
      {String? title,
      String? image,
      Color? bgColor,
      Color? color,
      Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 25),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 0, 255, 76).withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 0,
              offset: const Offset(2, 4), // changes position of shadow
            ),
          ],
          color: bgColor ?? SPColors.main,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 15),
            Text(
              title ?? "",
              style: SPColors.darkStyle(16, color: color),
            ),
            SizedBox(width: 15),
            if (image != null)
              Image.asset(
                image,
                width: 22,
                height: 22,
                color: color ?? SPColors.dark,
              ),
          ],
        ),
      ),
    );
  }

  static Widget btnLarge(
      {String? title,
      String? image,
      Color? bgColor,
      Color? color,
      Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 25),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(1, 3), // changes position of shadow
            ),
          ],
          color: bgColor ?? SPColors.main,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Text(
                title ?? "",
                textAlign: TextAlign.center,
                style: SPColors.lightStyle(20, color: color),
              ),
            ),
            if (image != null)
              Image.asset(
                image,
                width: 28,
                height: 28,
                color: color ?? SPColors.dark,
              ),
          ],
        ),
      ),
    );
  }

  static loadingView(bool isLoading, {String? text}) {
    if (isLoading) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(Assets.resourceIconLottieLoading2, width: 100),
                const SizedBox(
                  height: 20,
                ),
                if (text != null) Text(text)
              ],
            ),
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
