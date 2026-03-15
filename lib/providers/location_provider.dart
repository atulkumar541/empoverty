import 'package:flutter/material.dart';

class LocationProvider extends ChangeNotifier {
  double? _latitude;
  double? _longitude;
  String? _address;
  bool _isLoadingLocation = false;
  String? _locationError;

  double? get latitude => _latitude;
  double? get longitude => _longitude;
  String? get address => _address;
  bool get isLoadingLocation => _isLoadingLocation;
  String? get locationError => _locationError;

  Future<void> getCurrentLocation() async {
    try {
      _isLoadingLocation = true;
      _locationError = null;
      notifyListeners();

      // Simulate getting location
      await Future.delayed(const Duration(seconds: 1));

      // Default to Delhi, India coordinates for demo
      _latitude = 28.6139;
      _longitude = 77.2090;
      _address = 'Delhi, India';

      _isLoadingLocation = false;
    } catch (e) {
      _locationError = e.toString();
      _isLoadingLocation = false;
    }
    notifyListeners();
  }

  void setLocation(double latitude, double longitude, String address) {
    _latitude = latitude;
    _longitude = longitude;
    _address = address;
    notifyListeners();
  }

  void clearLocation() {
    _latitude = null;
    _longitude = null;
    _address = null;
    _locationError = null;
    notifyListeners();
  }
}
