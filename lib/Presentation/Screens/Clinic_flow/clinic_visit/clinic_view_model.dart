import 'package:medix/Data/Model/Clinic/clinic_visit_card.dart';
import 'package:stacked/stacked.dart';

class ClinicViewModel extends BaseViewModel {
  final List<ClinicVisitCardModel> _clinics = [];
  void chooseClinic(ClinicVisitCardModel clinic) {
    _clinics.clear();
    _clinics.add(clinic);
    notifyListeners();
  }

  bool checkIfSelected(ClinicVisitCardModel clinic) {
    return _clinics.contains(clinic);
  }
}
