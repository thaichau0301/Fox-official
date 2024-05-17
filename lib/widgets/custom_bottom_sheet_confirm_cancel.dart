import 'package:flutter/material.dart';
import 'package:get/get.dart';


class bottomSheetConfirm extends GetxController{
  void confirmCancel() {
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
                      onTap: (){ Get.toNamed('/home_screen');} ,
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
                onTap: (){
                  Get.toNamed('/home_bottom_nav_bar');
                  } ,
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