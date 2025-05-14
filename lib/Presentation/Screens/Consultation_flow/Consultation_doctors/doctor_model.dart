class Doctor {
  final int id;
  final String name;
  // final String specialty;
  // final String imageUrl;
  // final String mobileNumber;

  Doctor({
    required this.id,
    required this.name,
    // required this.specialty,
    // required this.imageUrl,
    // required this.mobileNumber,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
  final user = json['user'];
  final name = user != null
      ? '${user['fname'] ?? ''} ${user['lname'] ?? ''}'.trim()
      : 'Unnamed Doctor'; // or 'No User Info'

  return Doctor(
    id: json['id'],
    name: name,
  );
}

}
