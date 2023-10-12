import 'package:flutter/material.dart';
import 'package:kurd_tree/src/helper/spcolor.dart';

class KTextField extends StatelessWidget {
  const KTextField({
    super.key,
    this.controller,
    this.title,
    this.hint,
    this.icon,
    this.isEnable = true,
    this.isPassword = false,
    this.onTap,
    this.dynamicHeight = false,
    this.suffixIcon,
    this.focusNode,
    this.onChanged,
  });

  final TextEditingController? controller;

  ///This is the title for the head of textfield
  final String? title;
  final String? hint;
  final String? icon;
  final bool isEnable;
  final bool isPassword;
  final Function()? onTap;
  final Function(String)? onChanged;
  final bool dynamicHeight;
  final Widget? suffixIcon;
  final FocusNode? focusNode;

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
              child: Row(
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

                      // Only for learning Decimal, Hexa, Octa , Binary
                      // EEFE459E
                      //0,1..8,9 =? 10, 11 ,, 18, 19
                      // 0,1,2 .. 8,9,A,B,C,D,E,F  => 10 ... 18,19,1A,1B,1C,1D,1E, 1F / 20... 2F
                      // 0, 1,
                      // 10, 11
                      //100 // 101/ 110 / 111
                      // 0,1..6,7 10 17 20 27
                    ),
                    SizedBox(
                      width: 15,
                    ),
                  ],
                  // textFelid
                  if (onTap == null)
                    Expanded(
                      child: TextField(
                        onChanged: onChanged,
                        obscureText: isPassword,
                        enabled: isEnable,
                        controller: controller,
                        decoration: InputDecoration(
                            suffixIcon: suffixIcon,
                            border: InputBorder.none,
                            hintText: hint),
                        maxLines: dynamicHeight ? null : 1,
                        focusNode: focusNode,
                      ),
                    ),
                  if (onTap != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        controller?.text != null && controller!.text.isNotEmpty
                            ? (controller?.text ?? "")
                            : (hint ?? ""),
                        style: TextStyle(
                          color: controller?.text != null &&
                                  controller!.text.isNotEmpty
                              ? Colors.black
                              : Colors.black45,
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
