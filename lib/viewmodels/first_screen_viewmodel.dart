import 'package:flutter/material.dart';

class FirstScreenViewmodel extends ChangeNotifier {

  String name = '';
  String palindrome = '';
  // String? selectedUserName;
  void setName(String value) {
    name = value;
    notifyListeners();
  }

  void setPalindrome(String value) {
    palindrome = value;
    notifyListeners();
  }

  bool isPalindrome(String value) {
    final cleanInput = value.replaceAll(RegExp(r'\s+'), '').toLowerCase();
    final reversedInput = cleanInput.split('').reversed.join('');
    return cleanInput == reversedInput;
  }

  // void setSelectedUser(String? name) {
  //   selectedUserName = name;
  //   notifyListeners();
  // }

}