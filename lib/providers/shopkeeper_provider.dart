import 'package:flutter/material.dart';
import '../models/shopkeeper_model.dart';

class ShopkeeperProvider extends ChangeNotifier {
  List<Shopkeeper> _shopkeepers = [];
  Shopkeeper? _selectedShopkeeper;
  bool _isLoading = false;
  String? _errorMessage;

  List<Shopkeeper> get shopkeepers => _shopkeepers;
  Shopkeeper? get selectedShopkeeper => _selectedShopkeeper;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchShopkeepers() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // TODO: Replace with actual API call
      _shopkeepers = [
        Shopkeeper(
          userId: 'user1',
          shopName: 'Ambika Plumbing',
          description: 'Connect for plumbing and water treatment services',
          offeredServices: ['Plumber'],
          address: '123 Main Street',
          latitude: 28.6139,
          longitude: 77.2090,
          rating: 4.5,
          reviewCount: 28,
        ),
        Shopkeeper(
          userId: 'user2',
          shopName: 'Raj Electrical Works',
          description: 'Professional electrical services',
          offeredServices: ['Electrician'],
          address: '456 Park Avenue',
          latitude: 28.6155,
          longitude: 77.2100,
          rating: 4.8,
          reviewCount: 42,
        ),
      ];
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createShopkeeper(Shopkeeper shopkeeper) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      _shopkeepers.add(shopkeeper);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectShopkeeper(Shopkeeper shopkeeper) {
    _selectedShopkeeper = shopkeeper;
    notifyListeners();
  }

  Future<void> filterShopkeepersByService(String service) async {
    try {
      _isLoading = true;
      notifyListeners();

      await Future.delayed(const Duration(milliseconds: 500));

      // Filter logic will be implemented
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
