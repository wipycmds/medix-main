import 'package:medix/Data/Model/Add_patient/patient_model.dart';
import 'package:stacked/stacked.dart';

class SelectPatientViewModel extends BaseViewModel {
  final List<PatientModel> _patients = [];
  void choosePatient(PatientModel patient) {
    _patients.clear();
    _patients.add(patient);
    notifyListeners();
  }

  bool checkIfSelected(PatientModel patient) {
    return _patients.contains(patient);
  }
}
