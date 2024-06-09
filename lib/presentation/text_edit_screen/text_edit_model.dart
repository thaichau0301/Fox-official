import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class TextInfo {
  String text;
  double left = 100.0;
  double top = 100.0;
  Color color = Colors.white;
  FontWeight fontWeight = FontWeight.normal;
  FontStyle fontStyle = FontStyle.normal;
  double fontSize = 30;
  TextAlign textAlign = TextAlign.center;
  String fontFamily = 'Roboto';
  TextDecoration? textDecoration = TextDecoration.none;


  TextInfo({
    required this.text,
  });
}

class ImageText extends StatelessWidget {
  final TextInfo textInfo;
  const ImageText({
    Key? key,
    required this.textInfo,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Text(
      textInfo.text,
      textAlign: textInfo.textAlign,
      style: GoogleFonts.getFont(
        textInfo.fontFamily, // font from package, pass string
        fontSize: textInfo.fontSize,
        fontWeight: textInfo.fontWeight,
        fontStyle: textInfo.fontStyle,
        color: textInfo.color,
        decoration: textInfo.textDecoration,
        decorationColor: textInfo.color,
      ),
    );
  }
}