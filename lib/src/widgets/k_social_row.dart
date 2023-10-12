import 'package:flutter/material.dart';
import 'package:kurd_tree/src/helper/spcolor.dart';

class KSocialRow extends StatelessWidget {
  const KSocialRow({
    super.key,
    this.name,
    this.icon,
    this.onTap,
  });

  ///This is the title for the head of textfield
  final String? name;
  final String? icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                  width: 20,
                  height: 20,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 15,
                ),
              ],
              // textFelid
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    name ?? "",
                    style: SPColors.darkStyle(16, weight: FontWeight.w900),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
