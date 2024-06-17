import 'package:flutter/material.dart';

class StickerInfo {
  final String asset;
  double left;
  double top;
  bool isChoose;
  StickerInfo({
    required this.asset,
    required this.left,
    required this.top,
    required this.isChoose
  });
}
class StickerModels extends StatelessWidget {
  final StickerInfo stickerInfo;
  const StickerModels({super.key, required this.stickerInfo});
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      stickerInfo.asset,
    );
  }
}
