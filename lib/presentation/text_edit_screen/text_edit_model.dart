import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class TextInfo {
   String text;
   double left;
   double top;
   Color color;
   FontWeight fontWeight;
   FontStyle fontStyle ;
   double fontSize ;
   TextAlign textAlign;
   String fontFamily;
 TextDecoration textDecoration;
 bool isChoose;


  TextInfo(
      {
    required this.text,
    required  this.textDecoration,
    required this.left,
    required this.top,
    required this.color,
    required this.fontWeight,
    required this.fontStyle,
    required this.fontSize,
    required this.textAlign,
    required this.fontFamily,
    required this.isChoose,
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
      softWrap: true,
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