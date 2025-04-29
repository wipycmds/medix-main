import 'package:medix/Data/Model/Clinic/hospital_card_model.dart';
import 'package:stacked/stacked.dart';

class HospitalListViewModel extends BaseViewModel {
  final List<HospitalModel> _hospitals = [];
  void chooseHospital(HospitalModel hospital) {
    _hospitals.clear();
    _hospitals.add(hospital);
    notifyListeners();
  }

  bool checkIfSelected(HospitalModel hospital) {
    return _hospitals.contains(hospital);
  }
}
