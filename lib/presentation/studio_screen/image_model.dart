import 'package:flutter/material.dart';

class ImageModel {
   String url;
  bool isCheck;
  ImageModel( { required this.url, required this.isCheck});
}

class DisplayImage extends StatelessWidget {
  DisplayImage({super.key, required this.imageModel});
  final ImageModel imageModel;

  @override
  Widget build(BuildContext context) {

    return Image.network(
        imageModel.url,
        fit: BoxFit.cover
    );
  }
}
