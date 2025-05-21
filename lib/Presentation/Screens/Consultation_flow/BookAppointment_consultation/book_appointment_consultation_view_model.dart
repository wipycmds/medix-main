// import 'package:medix/Data/Fake_data/Home/doctors.dart';
import 'package:medix/Data/Model/Clinic/clinic_visit_card.dart';
import 'package:medix/Data/Model/Home/doctor.dart';
import 'package:stacked/stacked.dart';


// class ConsulTationAppointmentViewModel extends BaseViewModel {
//   final List<ClinicVisitCardModel> _clinics = [];

//   get tabController => null;
//   void chooseClinic(ClinicVisitCardModel clinic) {
//     print('object $clinic');
//     // _clinics.clear();
//     // _clinics.add(clinic);
//     // notifyListeners();
//   }

//   bool checkIfSelected(ClinicVisitCardModel clinic) {
  
//     return _clinics.contains(clinic);
//   }
// }
// class ConsulTationAppointmentViewModel extends BaseViewModel {
//   ClinicVisitCardModel? _selectedClinic;


//   int? _selectedIndex;
//   int? get selectedIndex => _selectedIndex;

// void chooseClinic(ClinicVisitCardModel clinic, int index) {
//   _selectedClinic = clinic;
//   _selectedIndex = index;
//   notifyListeners();
// }


//   bool checkIfSelected(ClinicVisitCardModel clinic) {
//     return _selectedClinic?.id == clinic.id;
//   }

//   int? get selectedServiceId => _selectedClinic?.id;

//   // int? get selectedIndex => null; // You can manage index separately if needed
// }

class ConsulTationAppointmentViewModel extends BaseViewModel {
  // --- Clinic Selection ---
  ClinicVisitCardModel? _selectedClinic;
  int? _selectedIndex;

  int? get selectedIndex => _selectedIndex;

  void chooseClinic(ClinicVisitCardModel clinic, int index) {
    _selectedClinic = clinic;
    _selectedIndex = index;
    notifyListeners();
  }

  bool checkIfSelected(ClinicVisitCardModel clinic) {
    return _selectedClinic?.id == clinic.id;
  }

  int? get selectedServiceId => _selectedClinic?.id;

  // --- Doctor Selection ---
  DoctorModel? _selectedDoctor;

  DoctorModel? get selectedDoctor => _selectedDoctor;

  void chooseDoctor(DoctorModel doctor) {
    _selectedDoctor = doctor;
    notifyListeners();
  }

  bool checkIfSelectedDoctor(DoctorModel doctor) {
    return _selectedDoctor?.id == doctor.id;
  }
}