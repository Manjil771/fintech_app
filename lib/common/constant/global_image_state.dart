import 'package:flutter/material.dart';
import 'package:ismart/common/shared_pref/shared_pref.dart';

class GlobalImageState {
  static final ValueNotifier<int> imageState = ValueNotifier(0);

  static Future<void> loadFromPrefs() async {
    final state = await SharedPref.getProfileImageState();
    imageState.value = state;
  }

  static Future<void> updateImageState(int newState) async {
    await SharedPref.setProfileImageState(newState);
    imageState.value = newState;
  }
}
