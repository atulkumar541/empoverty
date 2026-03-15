import 'package:flutter/material.dart';
import '../models/service_model.dart';

class ServiceProvider extends ChangeNotifier {
  static const List<ServiceCategory> _services = [
    ServiceCategory(
      id: '1',
      name: 'Electrician',
      description: 'Professional electrical services',
    ),
    ServiceCategory(
      id: '2',
      name: 'Plumber',
      description: 'Plumbing and water treatment',
    ),
    ServiceCategory(
      id: '3',
      name: 'Carpenter',
      description: 'Carpentry and woodwork',
    ),
    ServiceCategory(
      id: '4',
      name: 'Painter',
      description: 'Painting services',
    ),
    ServiceCategory(
      id: '5',
      name: 'Mason',
      description: 'Masonry and construction',
    ),
  ];

  List<ServiceCategory> get services => _services;

  List<ServiceCategory> getServicesByNames(List<String> names) {
    return _services
        .where((service) => names.contains(service.name))
        .toList();
  }

  ServiceCategory? getServiceByName(String name) {
    try {
      return _services.firstWhere((service) => service.name == name);
    } catch (e) {
      return null;
    }
  }
}
