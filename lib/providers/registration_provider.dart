// lib/providers/registration_provider.dart
import 'package:flutter/foundation.dart';
import '../models/registrant_model.dart';

class RegistrationProvider extends ChangeNotifier {
  final List<Registrant> _registrants = [];

  // Getters
  List<Registrant> get registrants => List.unmodifiable(_registrants);
  int get count => _registrants.length;

  // Add registrant
  void addRegistrant(Registrant registrant) {
    _registrants.add(registrant);
    notifyListeners();
  }

  // Remove registrant
  void removeRegistrant(String id) {
    _registrants.removeWhere((r) => r.id == id);
    notifyListeners();
  }

  // Update registrant
  void updateRegistrant(Registrant updated) {
    final index = _registrants.indexWhere((r) => r.id == updated.id);
    if (index != -1) {
      _registrants[index] = updated;
      notifyListeners();
    }
  }

  // Get by ID
  Registrant? getById(String id) {
    try {
      return _registrants.firstWhere((r) => r.id == id);
    } catch (e) {
      return null;
    }
  }

  // Check if email already registered (exclude own id for edit)
  bool isEmailRegistered(String email, {String? excludeId}) {
    return _registrants.any(
      (r) => r.email.toLowerCase() == email.toLowerCase() && r.id != excludeId,
    );
  }
}
