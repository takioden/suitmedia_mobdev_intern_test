import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';

class ThirdScreenViewmodel extends ChangeNotifier {
  List<UserModel> _users = [];
  bool _isLoading = false;
  int _currentPage = 1;
  bool _hasMore = true;

  List<UserModel> get users => _users;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  Future<void> fetchUsers({bool refresh = false}) async {
    if (_isLoading) return;

    if (refresh) {
      _currentPage = 1;
      _users.clear();
      _hasMore = true;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final fetched = await ApiService.fetchUsers(_currentPage);
      if (fetched.isEmpty) {
        _hasMore = false;
      } else {
        _users.addAll(fetched);
        _currentPage++;
      }
    } catch (e) {
      _hasMore = false;
    }  
    
    {
      _isLoading = false;
      notifyListeners();
    }
    
  }

  
}