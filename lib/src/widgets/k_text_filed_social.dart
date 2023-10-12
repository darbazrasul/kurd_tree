import 'package:flutter/material.dart';
import 'package:kurd_tree/src/constants/assets.dart';
import 'package:kurd_tree/src/helper/spcolor.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class KTextFieldSocial extends StatelessWidget {
  const KTextFieldSocial({
    super.key,
    this.controller,
    this.controllerUrl,
    this.title,
    this.hint,
    this.icon,
    this.isEnable = true,
    this.isPassword = false,
    this.onTap,
    this.dynamicHeight = false,
    this.suffixIcon,
    this.focusNode,
    this.hasLink = true,
    this.socialName = "",
    this.isPhoneNumber = false,
  });

  ///This is the title for the head of textfield
  final String? title;
  final String? hint;
  final String? icon;
  final bool isEnable;
  final bool hasLink;
  final bool isPassword;
  final Function()? onTap;
  final bool dynamicHeight;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final TextEditingController? controllerUrl;
  final String socialName;
  final bool isPhoneNumber;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(right: 16, left: 25, bottom: 0, top: 5),
                  child: Row(
                    children: [
                      Text(
                        title!,
                        style: SPColors.lightStyle(14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          Container(
            margin: EdgeInsets.only(right: 16, left: 16, bottom: 16, top: 5),
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 0, 255, 76).withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 0,
                  offset: Offset(3, 4), // changes position of shadow
                ),
              ],
              color: SPColors.main,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: Column(children: [
                Row(
                  children: [
                    // icon
                    if (icon != null) ...[
                      Image.asset(
                        icon!,
                        width: 18,
                        height: 18,
                        color: isEnable
                            ? Colors.black
                            : Colors.black.withOpacity(0.5),
                      ),
                      const SizedBox(width: 15),
                    ],
                    // textFelid
                    Expanded(
                      child: TextField(
                        inputFormatters: [
                          if (isPhoneNumber)
                            MaskTextInputFormatter(
                                mask: '+964 (7##) ### ## ##',
                                filter: {"#": RegExp(r'[0-9]')},
                                type: MaskAutoCompletionType.lazy)
                        ],
                        obscureText: isPassword,
                        enabled: isEnable,
                        controller: controller,
                        decoration: InputDecoration(
                            suffixIcon: suffixIcon,
                            border: InputBorder.none,
                            hintText: hint),
                        maxLines: dynamicHeight ? null : 1,
                        focusNode: focusNode,
                        keyboardType:
                            isPhoneNumber ? TextInputType.phone : null,
                      ),
                    ),
                  ],
                ),
                // url textfield
                if (hasLink)
                  Row(
                    children: [
                      // icon
                      Image.asset(
                        Assets.resourceIconLink,
                        width: 18,
                        height: 18,
                        color: isEnable
                            ? Colors.black
                            : Colors.black.withOpacity(0.5),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      // textFelid
                      Expanded(
                        child: TextField(
                          controller: controllerUrl,
                          style: SPColors.darkStyle(12),
                          decoration: InputDecoration(
                              suffixIcon: suffixIcon,
                              border: InputBorder.none,
                              hintText: "$socialName link"),
                          keyboardType: TextInputType.url,
                        ),
                      ),
                    ],
                  )
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
