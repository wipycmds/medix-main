import 'package:medix/Data/Model/Home/doctor.dart';
import 'package:stacked/stacked.dart';

// class ConsultationSelectDoctorViewModel extends BaseViewModel {
//   final List<DoctorModel> _doctors = [];

// DoctorModel? _selectedDoctor;
//   int? _selectedIndex;

//   int? get selectedIndex => _selectedIndex;
//   DoctorModel? get selectedDoctor => _selectedDoctor;

//   void chooseDoctor(DoctorModel doctor, int index) {
//     _selectedDoctor = doctor;
//     _selectedIndex = index;
//     notifyListeners();
//   }
  
//   void chooseClinic(DoctorModel doctor) {
//     _doctors.clear();
//     _doctors.add(doctor);
//     notifyListeners();
//   }

//   bool checkIfSelected(DoctorModel doctor) {
//     return _doctors.contains(doctor);
//   }
  
  
// }
class ConsultationSelectDoctorViewModel extends BaseViewModel {
  DoctorModel? _selectedDoctor;
  int? _selectedIndex;

  int? get selectedIndex => _selectedIndex;
  DoctorModel? get selectedDoctor => _selectedDoctor;

  void chooseDoctor(DoctorModel doctor, int index) {
    _selectedDoctor = doctor;
    _selectedIndex = index;
    notifyListeners();
  }

  bool checkIfSelected(DoctorModel doctor) {
    return _selectedDoctor?.id == doctor.id;
  }
}

