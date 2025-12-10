import 'package:bitka/services/users_service.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  final UserService _userService = UserService();
  
  bool _isLoading = false;
  String? _errorMessage;
  Map<String, dynamic>? _currentUser;
  Map<String, dynamic>? _viewedUser;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Map<String, dynamic>? get currentUser => _currentUser;
  Map<String, dynamic>? get viewedUser => _viewedUser;

  // Fetch current user profile
  Future<bool> fetchMyProfile() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _userService.getMyProfile();
    
    _isLoading = false;
    
    if (result['success']) {
      _currentUser = result['data'];
      _errorMessage = null;
      notifyListeners();
      return true;
    } else {
      _errorMessage = result['message'];
      notifyListeners();
      return false;
    }
  }

  // Update current user profile
  Future<bool> updateMyProfile(Map<String, dynamic> profileData) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _userService.updateMyProfile(profileData);
    
    _isLoading = false;
    
    if (result['success']) {
      _currentUser = result['data'];
      _errorMessage = null;
      notifyListeners();
      return true;
    } else {
      _errorMessage = result['message'];
      notifyListeners();
      return false;
    }
  }

  // Fetch user by ID
  Future<bool> fetchUserById(String userId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _userService.getUserById(userId);
    
    _isLoading = false;
    
    if (result['success']) {
      _viewedUser = result['data'];
      _errorMessage = null;
      notifyListeners();
      return true;
    } else {
      _errorMessage = result['message'];
      notifyListeners();
      return false;
    }
  }

  // Update user by ID
  Future<bool> updateUserById(
    String userId,
    Map<String, dynamic> profileData,
  ) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _userService.updateUserById(userId, profileData);
    
    _isLoading = false;
    
    if (result['success']) {
      _viewedUser = result['data'];
      _errorMessage = null;
      notifyListeners();
      return true;
    } else {
      _errorMessage = result['message'];
      notifyListeners();
      return false;
    }
  }

  // Change password
  Future<bool> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _userService.changePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
    
    _isLoading = false;
    
    if (result['success']) {
      _errorMessage = null;
      notifyListeners();
      return true;
    } else {
      _errorMessage = result['message'];
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void clearViewedUser() {
    _viewedUser = null;
    notifyListeners();
  }

  void clearCurrentUser() {
    _currentUser = null;
    notifyListeners();
  }
}