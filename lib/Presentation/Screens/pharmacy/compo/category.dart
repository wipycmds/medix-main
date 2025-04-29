class Category {
  final String image, text;

  const Category({required this.text, required this.image});
}

List<Category> categories = [
  const Category(text: 'Prescription Drugs', image: 'assets/Icons/drugs.svg'),
  const Category(text: 'Functional Foods', image: 'assets/Icons/foods.svg'),
  const Category(text: 'Personal Care', image: 'assets/Icons/personalcare.svg'),
];

List<Category> categories3 = [
  const Category(text: 'Personal Care', image: 'assets/Icons/personalcare.svg'),
  const Category(text: 'Functional', image: 'assets/Icons/foods.svg'),
  const Category(text: 'Analgesic', image: 'assets/Icons/drug2.svg'),
  const Category(text: 'Gender', image: 'assets/Icons/drugs.svg'),
];

List<Category> categories2 = [
  const Category(
      text: 'Medical Instruments', image: 'assets/Icons/instrument.svg'),
  const Category(text: 'General health', image: 'assets/Icons/health.svg'),
  const Category(text: 'Covid-19', image: 'assets/Icons/covid.svg'),
];
