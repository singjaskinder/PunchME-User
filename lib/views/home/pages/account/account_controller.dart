import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:punchme/apis/auth.dart';
import 'package:punchme/common/buttons.dart';
import 'package:punchme/common/image_picker.dart';
import 'package:punchme/common/sizedbox.dart';
import 'package:punchme/common/text.dart';
import 'package:punchme/overlays/dialog.dart';
import 'package:punchme/overlays/progress_dialog.dart';
import 'package:punchme/overlays/snackbar.dart';
import 'package:punchme/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../pager_controller.dart';

class AccountController extends GetxController {
  final AuthRepo authRepo = AuthApis();
  final nameCtrl = TextEditingController();
  final PagerController pageController = Get.find();

  final List<Menu> menus = [
    // Menu(name: 'History', icon: Icons.history, routeName: Routes.history),
    Menu(name: 'Punches', icon: Icons.ac_unit, routeName: Routes.punches),
    Menu(
        name: 'Collected Points',
        icon: Icons.history,
        routeName: Routes.collectedPoints),
    Menu(
        name: 'Help & Support',
        icon: Icons.help_outline,
        routeName: Routes.helpSupport),
    Menu(name: 'About', icon: Icons.change_history, routeName: Routes.about),
    Menu(name: 'FAQ', icon: Icons.subject_outlined, routeName: Routes.faq),
  ];

  final imageBase = ''.obs;
  final imageFile = <dynamic>[].obs;
  final imageEmpty = false.obs;

  void showEditProfileModal(BuildContext context) async {
    nameCtrl.text = pageController.name.value;
    if (pageController.image.value.isNotEmpty) {
      imageBase.value = pageController.image.value;
    }
    showModalBottomSheet(
        context: context,
        enableDrag: false,
        builder: (_) {
          return SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: JxText('Edit Details'),
              ),
              Obx(
                () => JxImagePicker(
                  isEmpty: imageEmpty.value,
                  imageData: imageBase.value,
                  onSelected: () => showPicker(context),
                  onRemoved: () => removeImage(),
                ),
              ),
              JxSizedBox(
                height: 3,
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                    controller: nameCtrl,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        labelText: 'Enter your full name',
                        prefixIcon: Icon(Icons.person)),
                    validator: (val) =>
                        val.isNotEmpty ? null : 'Your full name'),
              ),
              JxSizedBox(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextIconBTN(
                  enabled: true,
                  onPressed: () => updetails(),
                  label: 'Update',
                  icondata: Icons.navigate_next,
                ),
              ),
            ]),
          );
        });
  }

  void showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text('Camera'),
                      onTap: () {
                        pickImage(0);
                        Get.back();
                      }),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('Gallery'),
                    onTap: () {
                      pickImage(1);
                      Get.back();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> pickImage(int type) async {
    ImageSource source;
    source = type == 0 ? ImageSource.camera : ImageSource.gallery;
    File image = await ImagePicker.pickImage(source: source, imageQuality: 40);
    imageFile.add(image);
    final bytes = await image.readAsBytes();
    imageBase.value = base64Encode(bytes);
    imageEmpty.value = false;
  }

  void removeImage() async {
    isLoading(true);
    if (imageBase.value.contains('http')) {
      try {
        await authRepo.removeImage(imageBase.value);
      } catch (e) {}
      isLoading(false);
    } else {
      imageBase.value = '';
      imageFile.clear();
      isLoading(false);
    }
  }

  void updetails() async {
    if (nameCtrl.text.isNotEmpty && imageBase.value.isNotEmpty) {
      if (nameCtrl.text == pageController.name.value) {
        print('ewwfw');
        return;
      }
      try {
        isLoading(true);
        final data = {'name': nameCtrl.text};
        await authRepo.updateUserDetails(data, false);
        isLoading(false);
        JxSnackBarStatus('Confirmation', 'Details updated');
      } catch (e) {
        print(e);
        isLoading(false);
        JxSnackBarStatus(null, null);
      }
    }
    if (nameCtrl.text.isEmpty) {
      JxSnackBarStatus(null, 'Please enter name');
      return;
    }
    if (imageBase.value.isEmpty) {
      JxSnackBarStatus(null, 'Please select your profile image');
      return;
    }
  }

  void logout() async {
    final onPos = () async {
      await FirebaseAuth.instance.signOut();
      final prefs = await SharedPreferences.getInstance();
      prefs.clear();
      Get.offAllNamed(Routes.register);
    };
    JxDialog('Confirmation', 'You sure you want to logout?', null, 'cancel',
        onPos, null);
  }

  void toView(String routeName) {
    Get.toNamed(routeName);
  }
}

class Menu {
  Menu({this.name, this.icon, this.routeName});
  final String name;
  final IconData icon;
  final String routeName;
}
