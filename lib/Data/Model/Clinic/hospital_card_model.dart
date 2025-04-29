class HospitalModel {
  const HospitalModel({
    required this.charge,
    required this.image,
    required this.name,
    required this.city,
    required this.reviewCount,
    required this.averageReview,
  });
  final String image, name, city;
  final int reviewCount;
  final double averageReview, charge;
}
