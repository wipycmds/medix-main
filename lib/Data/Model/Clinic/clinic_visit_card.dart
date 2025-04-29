class ClinicVisitCardModel {
  const ClinicVisitCardModel({
    required this.image,
    required this.name,
    required this.time,
    required this.hospitalCount,
    required this.highestCharge,
    required this.lowestCharge,
  });
  final String image, name, time;
  final int hospitalCount;
  final double highestCharge, lowestCharge;
}
