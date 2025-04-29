class VoucherModel {
  const VoucherModel({
    required this.color,
    required this.icon,
    required this.offer,
    required this.expiryData,
  });
  final int color;
  final String icon, offer, expiryData;
}
