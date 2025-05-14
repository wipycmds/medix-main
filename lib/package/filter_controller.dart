import 'package:flutter/material.dart';

class FilterController<T> extends ChangeNotifier {
  final List<T> _selectedFilters = List<T>.empty(growable: true);

  String? selectedValue;



  void setSelected(String value) {
    selectedValue = value;
  }

  ///make it accessible as group of filter
  List<T> get filters => _selectedFilters;

  ///to provide group functionality
  void addAsGroup(T filter) {
    if (_selectedFilters.contains(filter)) {
      _selectedFilters.remove(filter);
      notifyListeners();
    } else {
      _selectedFilters.add(filter);
      notifyListeners();
    }
  }

  T get getSelectedRadio => _selectedFilters.first;

  ///to provide radio type functionality
  void addAsRadio(T filter) {
    _selectedFilters.clear();
    _selectedFilters.add(filter);
    notifyListeners();
  }

  ///to check that particular filter is selected or not
  bool checkIfSelected(T filter) {
    return _selectedFilters.contains(filter);
  }

  bool get checkIfNotSelected => _selectedFilters.isEmpty;

  ///for reset purpose
  void clearTheList() {
    _selectedFilters.clear();
    notifyListeners();
  }
}
