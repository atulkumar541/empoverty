import 'package:flutter/material.dart';
import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  User? _currentUser;
  bool _isLoggedIn = false;
  bool _isLoading = false;
  String? _errorMessage;

  User? get currentUser => _currentUser;
  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> registerUser(
    String name,
    String email,
    String phone,
    UserType userType, {
    String? address,
    double? latitude,
    double? longitude,
  }) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      _currentUser = User(
        name: name,
        email: email,
        phone: phone,
        userType: userType,
        address: address,
        latitude: latitude,
        longitude: longitude,
      );

      _isLoggedIn = true;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      _currentUser = User(
        name: 'Test User',
        email: email,
        phone: '1234567890',
        userType: UserType.customer,
      );

      _isLoggedIn = true;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateUserLocation(double latitude, double longitude) async {
    if (_currentUser != null) {
      _currentUser = _currentUser!.copyWith(
        latitude: latitude,
        longitude: longitude,
      );
      notifyListeners();
    }
  }

  void logout() {
    _currentUser = null;
    _isLoggedIn = false;
    notifyListeners();
  }
}
