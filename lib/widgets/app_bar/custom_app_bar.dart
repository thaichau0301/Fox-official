import 'package:flutter/material.dart';
import '../../core/app_export.dart'; // ignore: must_be_immutable
import 'package:get/get.dart';
import 'package:fox/widgets/custom_bottom_sheet_confirm_cancel.dart';
import '../../core/utils/size_utils.dart';
import '../../presentation/home_bottom_navigation/controller/home_bottom_navigation_controller.dart';
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
    final home_navigation_controller = Get.put(HomeBottomBarController());
    Color surface = primitives.surface_secondary();
    final showBottomSheet = Get.put(bottomSheetConfirm());
    return SafeArea(
      child:  Container(
        width: double.infinity,
        color: Colors.white12,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){showBottomSheet.confirmCancel();} ,
              child: Container(
                width: 65,
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
              onTap: () {
                home_navigation_controller.changeTab(0);
                print(home_navigation_controller.tabIndex.value);
                Get.toNamed('/home_bottom_navigation');
              },
                child:
                Container(
                  width: 65,
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
}
