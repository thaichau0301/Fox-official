import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../core/app_export.dart'; // ignore: must_be_immutable
import 'package:get/get.dart';

import '../../core/utils/size_utils.dart';
import '../../theme/primitives.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar(
      {Key? key,
        this.height,
        this.leadingWidth,
        this.leading,
        this.title,
        this.centerTitle,
        this.actions})
      : super(
    key: key,
  );

  final double? height;

  final double? leadingWidth;

  final Widget? leading;

  final Widget? title;

  final bool? centerTitle;

  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    Primitives primitives = Get.put(Primitives());
    Color surface = primitives.surface_secondary();
    return SafeArea(
      child:  Container(
        width: double.infinity,
        color: surface,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){bottomSheetConfirmCancel();} ,
              child: Container(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                decoration: ShapeDecoration(
                  color: Color(0xFF8E8E92),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.73),
                  ),
                ),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.75,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {Get.toNamed('home_bottom_nav_bar');},
              child: Container(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                decoration: ShapeDecoration(
                  color: Color(0xFFFBBC05),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.73),
                  ),
                ),
                child: Text(
                  'Save',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.75,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(
    SizeUtils.width,
    height ?? 56.v,
  ); // important
  void bottomSheetConfirmCancel() {
    final double paddingVertical = 12;
    Get.bottomSheet(
        backgroundColor: Colors.transparent,
        Container(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                decoration: ShapeDecoration(
                  color: Color(0xFF2C2C2D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding:  EdgeInsets.symmetric(vertical: paddingVertical),
                      decoration: BoxDecoration(),
                      child: Text(
                        'Are you sure you want to discard all changes?',
                        style: TextStyle(
                          color: Color(0xFFA1A1A1),
                          fontSize: 12,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){ Get.toNamed('/home_bottom_nav_bar');} ,
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding:  EdgeInsets.symmetric(vertical: paddingVertical*2),
                        child: Text(
                          'Discard Changes',
                          style: TextStyle(
                            color: Color(0xFFDF5243),
                            fontSize: 20,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: (){ Get.back();} ,
                child: Container(
                  width: double.infinity,
                  padding:  EdgeInsets.symmetric(vertical: paddingVertical*2-2),
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    color: Color(0xFF3E3E3E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Color(0xFF5A91F7),
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}
