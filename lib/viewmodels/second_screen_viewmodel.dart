import 'package:flutter/material.dart';

class SecondScreenViewmodel extends ChangeNotifier {

  String? selectedUserName;

  void setSelectedUser(String? name) {
    selectedUserName = name;
    notifyListeners();
  }

}