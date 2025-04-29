class PharmacyModel {
  const PharmacyModel({
    required this.tag,
    required this.distance,
    required this.image,
    required this.name,
    required this.cityName,
    required this.subtitle,
  });
  final String image, name, tag, cityName, subtitle;
  final double distance;
}
