// class MyDialog {
//   static void show(String title, String text, String btn1Label,
//       String btn2Label, Function onPos, Function onNeg) {
//     Get.dialog(
//         Scaffold(
//           backgroundColor: AppColors.transparent,
//           body: Center(
//             child: Container(
//               width: SizeConfig.width * 80,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     padding: EdgeInsets.all(15),
//                     margin: EdgeInsets.symmetric(vertical: 10),
//                     height: SizeConfig.width * 45,
//                     decoration: BoxDecoration(
//                         color: AppColors.white,
//                         borderRadius: BorderRadius.all(Radius.circular(15))),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(title,
//                             textAlign: TextAlign.center,
//                             style: AppStyles.idleTxt.copyWith(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: AppColors.orange)),
//                         SizedBox(height: 10),
//                         Text(text,
//                             textAlign: TextAlign.center,
//                             style: AppStyles.idleTxt.copyWith(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: AppColors.black)),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 18),
//                   Container(
//                     child: PrimaryButton(
//                       label: btn1Label ?? 'Okay',
//                       onPressed: onPos ?? dismiss,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Visibility(
//                     visible: !(btn2Label == null),
//                     child: Container(
//                       child: PrimaryButton(
//                         label: btn2Label ?? 'Cancel',
//                         onPressed: onNeg ?? dismiss,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         barrierDismissible: false);
//   }

//   static void dismiss() => Get.back();
// }
