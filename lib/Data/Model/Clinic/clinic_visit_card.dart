// class ClinicVisitCardModel {
//   const ClinicVisitCardModel({
//     // required this.image,
//     required this.name,
//     // required this.image,
//     // required this.id,
//     // required this.deleted_at,
//     // required this.parent_id,
//     // required this.time,
//     // required this.highestCharge,
//     // required this.lowestCharge
//     // required this.hospita

//   });
//   final String name;
//   // final int id;
//   // final int parent_id;
//   // // final String deleted_at;
//   // final double highestCharge, lowestCharge;
// }
class ClinicVisitCardModel {
  const ClinicVisitCardModel({
    required this.id,
    required this.name,
    // this.deletedAt,
    // this.parentId,
  });

  final int id;
  final String name;
  // final DateTime? deletedAt;
  // final int? parentId;

  factory ClinicVisitCardModel.fromMap(Map<String, dynamic> map) {
    return ClinicVisitCardModel(
      id: map['id'] as int,
      name: map['name'] as String,
      // deletedAt: map['deleted_at'] != null ? DateTime.tryParse(map['deleted_at']) : null,
      // parentId: map['parent_id'],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClinicVisitCardModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

}

