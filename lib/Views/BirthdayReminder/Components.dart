import 'package:birthday_app_new/Controller/Constants.dart';
import 'package:flutter/material.dart';

class MyInputField extends StatefulWidget {
  TextEditingController controller;
  String hint;
  VoidCallback? onchanged;
  MyInputField({
    Key? key,
    required this.controller,
    required this.hint,
    this.onchanged,
  }) : super(key: key);

  @override
  State<MyInputField> createState() => _MyInputFieldState();
}

class _MyInputFieldState extends State<MyInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        color: colors.secondarycolor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: widget.controller,
        cursorColor: colors.reminderappbarcolor,
        decoration: InputDecoration(
            prefixIcon: IconTheme(
                data: IconThemeData(color: Color(0xff5A5A5B)),
                child: Icon(
                  Icons.title_rounded,
                )),
            border: InputBorder.none,
            hintText: widget.hint,
            hintStyle:
                TextStyle(color: Color(0xff5A5A5B), fontFamily: "Roboto")),
      ),
    );
  }
}

class Button extends StatelessWidget {
  VoidCallback ontap;
  Button({Key? key, required this.ontap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            color: colors.secondarycolor,
            borderRadius: BorderRadius.circular(12)),
        child: Icon(
          Icons.done,
          color: Color(0xff5A5A5B),
        ),
      ),
    );
  }
}

class Picker extends StatelessWidget {
  String text;
  IconData icon;
  VoidCallback ontap;
  Picker(
      {Key? key, required this.ontap, required this.text, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
          alignment: Alignment.center,
          width: Constants.screenWidth(context),
          decoration: BoxDecoration(
            color: colors.secondarycolor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Icon(
                icon,
                color: Color(0xff5A5A5B),
              ),
              SizedBox(
                width: 13,
              ),
              Text(
                text,
                style:
                    TextStyle(color: Color(0xff5A5A5B), fontFamily: "Roboto"),
              ),
            ],
          )),
    );
  }
}
