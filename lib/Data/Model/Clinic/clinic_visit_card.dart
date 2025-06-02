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
// class ClinicVisitCardModel {
//   const ClinicVisitCardModel({
//     required this.id,
//     required this.name,
//     required this.tag,
//     required this.count,

//     // this.deletedAt,
//     // this.parentId,
//   });

//   final int id;
//   final String name;
//   final int count;
//   final dynamic tag;
//   // final DateTime? deletedAt;
//   // final int? parentId;

//   factory ClinicVisitCardModel.fromMap(Map<String, dynamic> map) {
//     // print(map);
//     return ClinicVisitCardModel(

//       id: map['id'] as int,
//       name: (map['name'] as String?)?.isNotEmpty == true ? map['name'] as String : '',
//       tag: (map['tag'] as String?)?.isNotEmpty == true ? map['tag'] as String : '',
//       count: (map['count'] as int?) ?? 0,
//       // name: map['name'] !as String,
//       // deletedAt: map['deleted_at'] != null ? DateTime.tryParse(map['deleted_at']) : null,
//       // parentId: map['parent_id'],
//     );
//   }

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is ClinicVisitCardModel &&
//           runtimeType == other.runtimeType &&
//           id == other.id;

//   @override
//   int get hashCode => id.hashCode;

// }

