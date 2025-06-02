import 'package:medix/Data/Model/Clinic/clinic_visit_card.dart';
import 'package:medix/Data/Model/Clinic/clinic_visits_card.dart' show ClinicVisitsCardModel;
import 'package:stacked/stacked.dart';

class ClinicViewModel extends BaseViewModel {
  final List<ClinicVisitsCardModel> _clinics = [];
  void chooseClinic(ClinicVisitsCardModel clinic) {
    _clinics.clear();
    _clinics.add(clinic);
    notifyListeners();
  }

  bool checkIfSelected(ClinicVisitsCardModel clinic) {
    return _clinics.contains(clinic);
  }
}
