class PatientModel {
  const PatientModel({
    required this.name,
    required this.image,
    required this.date,
    required this.relation,
  });
  final String name, image, date;
  final Relation relation;
}

enum Relation {
  brother,
  sister,
  uncle,
  father,
  mother,
  wife,
  grandfather,
  nephew,
  son,
  self
}
