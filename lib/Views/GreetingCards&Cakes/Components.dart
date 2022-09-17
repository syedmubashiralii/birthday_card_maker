// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class filledchip extends StatelessWidget {
  VoidCallback ontap;
  String text;
  Color tcolor;
  String img;
  filledchip(
      {Key? key,
      required this.ontap,
      required this.text,
      required this.img,
      required this.tcolor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 40,
        width: MediaQuery.of(context).size.width * 0.41,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(img), fit: BoxFit.fill)),
        child: Center(
          child: Text(
            textAlign: TextAlign.center,
            text,
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: tcolor,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis)),
          ),
        ),
      ),
    );
  }
}

class outlinedchip extends StatelessWidget {
  VoidCallback ontap;
  String text;
  Color color;
  Color bcolor;
  Color tcolor;
  outlinedchip(
      {Key? key,
      required this.ontap,
      required this.text,
      required this.color,
      required this.tcolor,
      required this.bcolor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 36,
        width: MediaQuery.of(context).size.width * 0.36,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(34),
            border: Border.all(color: bcolor, width: 1.5)),
        child: Center(
          child: Text(
            textAlign: TextAlign.center,
            text,
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: tcolor,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis)),
          ),
        ),
      ),
    );
  }
}
