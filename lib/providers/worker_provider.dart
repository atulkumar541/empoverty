import 'package:flutter/material.dart';
import '../models/worker_model.dart';

class WorkerProvider extends ChangeNotifier {
  List<Worker> _workers = [];
  Worker? _selectedWorker;
  bool _isLoading = false;
  String? _errorMessage;

  List<Worker> get workers => _workers;
  Worker? get selectedWorker => _selectedWorker;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchWorkers() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      await Future.delayed(const Duration(seconds: 1));

      // TODO: Replace with actual API call
      _workers = [
        Worker(
          userId: 'worker1',
          name: 'Ramesh Kumar',
          phone: '9876543210',
          category: 'Plumber',
          bio: 'Experienced plumber with 10+ years',
          skills: ['Pipe Fixing', 'Water Treatment', 'Installation'],
          address: '789 Worker Lane',
          latitude: 28.6145,
          longitude: 77.2095,
          rating: 4.6,
          reviewCount: 35,
          isVerified: true,
        ),
        Worker(
          userId: 'worker2',
          name: 'Priya Singh',
          phone: '9123456780',
          category: 'Electrician',
          bio: 'Licensed electrician',
          skills: ['Wiring', 'Panel Installation', 'Maintenance'],
          address: '321 Service Road',
          latitude: 28.6160,
          longitude: 77.2105,
          rating: 4.7,
          reviewCount: 42,
          isVerified: true,
        ),
      ];
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createWorker(Worker worker) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      await Future.delayed(const Duration(seconds: 1));

      _workers.add(worker);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectWorker(Worker worker) {
    _selectedWorker = worker;
    notifyListeners();
  }

  Future<void> filterWorkersByCategory(String category) async {
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
