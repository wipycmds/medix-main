
// List<DoctorModel> doctors = const [
//   DoctorModel(
//       patient: 1000,
//       averageRating: 4.7,
//       name: 'Dr. Leslie Alexander',
//       image: 'assets/Images/Temp/doctor_1.png',
//       degree: 'Cardiologist',
//       reviews: 120,
//       experience: 4),
//   DoctorModel(
//       patient: 1100,
//       averageRating: 4.04,
//       name: 'Dr. Alexander Strange',
//       image: 'assets/Images/Temp/doctor_2.png',
//       degree: 'Dermatologist',
//       reviews: 120,
//       experience: 4),
//   DoctorModel(
//       patient: 1000,
//       averageRating: 4.8,
//       name: 'Dr. Leslie Alexander',
//       image: 'assets/Images/Temp/doctor_1.png',
//       degree: 'Cardiologist',
//       reviews: 120,
//       experience: 4),
//   DoctorModel(
//       patient: 1100,
//       averageRating: 4.04,
//       name: 'Dr. Alexander Strange',
//       image: 'assets/Images/Temp/doctor_2.png',
//       degree: 'Dermatologist',
//       reviews: 120,
//       experience: 4),
// ];
class DoctorModel {
  final int id;
  final String name;
  final String image;
  final String degree;
  final int patient;
  final double averageRating;
  final int reviews;
  final int experience;

  const DoctorModel({
    required this.id,
    required this.name,
    required this.image,
    required this.degree,
    required this.patient,
    required this.averageRating,
    required this.reviews,
    required this.experience,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'] ?? {};

    return DoctorModel(
      id: json['id'],
      name: 'Dr. ${user['fname'] ?? ''} ${user['lname'] ?? ''}'.trim(),
      image: json['image_uri'] ?? 'assets/Images/Temp/default.png',
      degree: json['certification'] ?? 'Unknown',
      patient: 1000, // replace if you have real value
      averageRating: 4.5, // replace if you have real value
      reviews: 100, // replace if available
      experience: 5, // replace if available
    );
  }
}
