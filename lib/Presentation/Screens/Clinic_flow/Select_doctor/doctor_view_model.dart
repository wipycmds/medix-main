import 'package:medix/Data/Model/Home/doctor.dart';
import 'package:stacked/stacked.dart';

class SelectDoctorViewModel extends BaseViewModel {
  final List<DoctorModel> _doctors = [];
  void chooseClinic(DoctorModel doctor) {
    _doctors.clear();
    _doctors.add(doctor);
    notifyListeners();
  }

  bool checkIfSelected(DoctorModel doctor) {
    return _doctors.contains(doctor);
  }
}
