import 'package:flutter/material.dart';

class LigneInfo extends StatelessWidget {
  final String label;
  final String text;
  final Color color;
  final Color textColor;
  const LigneInfo(
      {Key? key,
      required this.label,
      required this.text,
      this.color = Colors.black45,
      this.textColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4, left: 20, right: 20),
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
      height: 40,
      width: double.maxFinite,
      /*decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10)
      ),*/
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                label,
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontStyle: FontStyle.italic),
              ),
            ],
          ),
          Text(
            text,
            style: TextStyle(
                fontSize: 20,
                color: textColor,
                //fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
