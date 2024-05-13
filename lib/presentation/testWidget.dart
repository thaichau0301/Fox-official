//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class LabelAndFunction {
//   String label;
//   Function function;
//   LabelAndFunction({required this.label, required this.function});
// }
// List<LabelAndFunction> btnLbelsAndFunctions = [
//   LabelAndFunction(
//       label: "Filter : Age",
//       function: () {
//         // your function for filtering by age
//       }),
//   LabelAndFunction(
//       label: "Filter: Gender",
//       function: () {
//         // your function for filtering by gender
//       }),
//   LabelAndFunction(
//       label: "Filter: Location",
//       function: () {
//         // your function for filtering by location
//       }),
// ];
// var activeBtnIndex = 0;
//
// class test extends StatefulWidget {
//   const test({super.key});
//
//   @override
//   State<test> createState() => _testState();
// }
//
// class _testState extends State<test> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         itemCount: btnLbelsAndFunctions.length,
//         itemBuilder: (context, index) {
//           return OutlinedButton(
//               onPressed: () {
//                 setState(() {
//                   activeBtnIndex = index;
//                   print(index);
//                 });
//                 btnLbelsAndFunctions.elementAt(index).function();
//               },
//               style: OutlinedButton.styleFrom(
//                 foregroundColor: activeBtnIndex == index
//                     ? Colors.amber
//                     : Colors.white, side: BorderSide(
//                   color: activeBtnIndex == index
//                       ? Colors.amber
//                       : Colors.white,
//                 ),
//               ),
//               child: Text(btnLbelsAndFunctions.elementAt(index).label,
//                   style: TextStyle(color: Colors.brown[900])));
//         });
//   }
// }


// / import 'package:flutter/cupertino.dart';
//
// old visual adjust - i want to modify look like this file
// / Expanded _visualAdjustment() {
//
//     return Expanded(
//           child: Container(
//             padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
//             clipBehavior: Clip.antiAlias,
//             decoration: BoxDecoration(),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child: Column(
//                     children: [
//                       Material(
//                           type: MaterialType.transparency,
//                           //Makes it usable on any background color, thanks @IanSmith
//                           child: Obx(
//                             () => Ink(
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: controller.roundColor[1], width: 1.0),
//                                 color: Colors.transparent,
//                                 shape: BoxShape.circle,
//                               ),
//                               child: InkWell(
//                                 borderRadius: BorderRadius.circular(1000.0),
//                                 splashColor: Colors.transparent,
//                                 onTap: () {
//                                   controller.tapToChange(1);
//                                 },
//                                 child: Padding(
//                                     padding: EdgeInsets.all(paddingIcon),
//                                     child: Obx(() => Icon(
//                                           _listIcon[0],
//                                           size: sizeIcon,
//                                           color: controller.roundColor[1],
//                                         ))),
//                               ),
//                             ),
//                           )),
//                       // Obx(() => dotMarkChoose(controllerSlider.valueBrightness))
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: Material(
//                       type: MaterialType.transparency,
//                       //Makes it usable on any background color, thanks @IanSmith
//                       child: Obx(
//                         () => Ink(
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                                 color: controller.roundColor[2], width: 1.0),
//                             color: Colors.transparent,
//                             shape: BoxShape.circle,
//                           ),
//                           child: InkWell(
//                             borderRadius: BorderRadius.circular(1000.0),
//                             splashColor: Colors.transparent,
//                             onTap: () {
//                               controller.tapToChange(2);
//                             },
//                             child: Padding(
//                                 padding: EdgeInsets.all(paddingIcon),
//                                 child: Obx(() => Icon(
//                                       _listIcon[1],
//                                       size: sizeIcon,
//                                       color: controller.roundColor[2],
//                                     ))),
//                           ),
//                         ),
//                       )),
//
//                 ),
//                 Expanded(
//                   child: Material(
//                       type: MaterialType.transparency,
//                       //Makes it usable on any background color, thanks @IanSmith
//                       child: Obx(
//                         () => Ink(
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                                 color: controller.roundColor[3], width: 1.0),
//                             color: Colors.transparent,
//                             shape: BoxShape.circle,
//                           ),
//                           child: InkWell(
//                             borderRadius: BorderRadius.circular(1000.0),
//                             splashColor: Colors.transparent,
//                             onTap: () {
//                               ;
//                               controller.tapToChange(3);
//                             },
//                             child: Padding(
//                                 padding: EdgeInsets.all(paddingIcon),
//                                 child: Obx(() => Icon(
//                                       _listIcon[2],
//                                       size: sizeIcon,
//                                       color: controller.roundColor[3],
//                                     ))),
//                           ),
//                         ),
//                       )),
//                 ),
//                 Expanded(
//                   child: Material(
//                       type: MaterialType.transparency,
//                       //Makes it usable on any background color, thanks @IanSmith
//                       child: Obx(
//                         () => Ink(
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                                 color: controller.roundColor[4], width: 1.0),
//                             color: Colors.transparent,
//                             shape: BoxShape.circle,
//                           ),
//                           child: InkWell(
//                             borderRadius: BorderRadius.circular(1000.0),
//                             splashColor: Colors.transparent,
//                             onTap: () {
//                               controller.tapToChange(4);
//                             },
//                             child: Padding(
//                                 padding: EdgeInsets.all(paddingIcon),
//                                 child: Obx(() => Icon(
//                                       _listIcon[3],
//                                       size: sizeIcon,
//                                       color: controller.roundColor[4],
//                                     ))),
//                           ),
//                         ),
//                       )),
//                 ),
//                 Expanded(
//                   child: Material(
//                       type: MaterialType.transparency,
//                       //Makes it usable on any background color, thanks @IanSmith
//                       child: Obx(
//                             () => Ink(
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                                 color: controller.roundColor[5], width: 1.0),
//                             color: Colors.transparent,
//                             shape: BoxShape.circle,
//                           ),
//                           child: InkWell(
//                             borderRadius: BorderRadius.circular(1000.0),
//                             splashColor: Colors.transparent,
//                             onTap: () {
//                               controller.tapToChange(5);
//                             },
//                             child: Padding(
//                                 padding: EdgeInsets.all(paddingIcon),
//                                 child: Obx(() => Icon(
//                                   _listIcon[4],
//                                   size: sizeIcon,
//                                   color: controller.roundColor[5],
//                                 ))),
//                           ),
//                         ),
//                       )),
//                 ),
//           ],
//             ),
//           ),
//         );
//   }