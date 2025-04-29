class PaymentCardModel {
  const PaymentCardModel({
    required this.cardNumber,
    required this.cardHolder,
    required this.cardType,
  });
  final String cardNumber, cardHolder, cardType;
}
