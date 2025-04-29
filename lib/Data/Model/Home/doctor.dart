class DoctorModel {
  const DoctorModel({
    required this.patient,
    required this.averageRating,
    required this.name,
    required this.image,
    required this.degree,
    required this.reviews,
    required this.experience,
  });
  final String name, image, degree;
  final int reviews, patient;
  final double experience, averageRating;
}
