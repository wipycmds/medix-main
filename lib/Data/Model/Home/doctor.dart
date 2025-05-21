// class DoctorModel {
//   const DoctorModel({
//     required this.patient,
//     required this.averageRating,
//     required this.name,
//     required this.image,
//     required this.degree,
//     required this.reviews,
//     required this.experience,
//   });
//   final String name, image, degree;
//   final int reviews, patient;
//   final double experience, averageRating;
// }
class DoctorModel {
  const DoctorModel({
    required this.id,
    required this.patient,
    required this.averageRating,
    required this.name,
    required this.about,
    required this.image,
    required this.degree,
    required this.reviews,
    required this.experience, 
    
  });

  final String name, image, degree, about;
  final int reviews, patient, id;
  final double experience, averageRating;

  // static Future<List<DoctorModel>> fromJson(json) {
    
  // }

  // factory DoctorModel.fromMap(Map<String, dynamic> map) {
  //   final provider = map['provider'] ?? {};
  //   final user = provider['user'] ?? {};

  //   final name = "${user['fname'] ?? ''} ${user['lname'] ?? ''}".trim();

  //   return DoctorModel(
  //     name: name,
  //     image: provider['image_uri'] ?? '',
  //     degree: provider['certification'] ?? 'General',
  //     reviews: map['reviews']?.toInt() ?? 0,
  //     patient: map['patient']?.toInt() ?? 0,
  //     experience: map['experience']?.toDouble() ?? 0.0,
  //     averageRating: map['average_rating']?.toDouble() ?? 0.0,
  //   );
  // }
}
