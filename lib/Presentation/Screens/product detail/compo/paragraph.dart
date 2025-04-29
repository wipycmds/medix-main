import 'package:medix/Presentation/Screens/product%20detail/compo/specialization.dart';

const text =
    'Men\'s Formula with new premium ingredients, all in one delicious serving: Beta Carotene, Vitamin B6, Vitamin K2 & Choline (Packaging May consty).\n';
const text1 =
    'Non-GMO. Free of milk, eggs, peanuts, tree nut allergens, fish allergens, shellfish, soy, gluten and wheat. No synthetic colors or artificial sweeteners/flavors. 3RD PARTY LAB TESTED. No refrigeration required\n';
const text2 = 'For adult men, take six (6) gummies daily with or without food.';
const text3 =
    '17 essential nutrients: vitamin D3 for immune health, vitamin B12 (methylcobalamin) for energy,*\n';

const List paragraph = [text, text1, text2, text3];
const List aboutus = [
  text,
  text1,
  text2,
  text3,
  text2,
  text1,
  text3,
  text1,
  text2
];

List paragraph2 = [
  'Men\'s Formula with new premium ingredients, all in one delicious serving: Beta Carotene, Vitamin B6, Vitamin K2 & Choline (Packaging May consty).\n',
  '17 essential nutrients: vitamin D3 for immune health, vitamin B12 (methylcobalamin) for energy, omega-3 EPA & DHA (from fish oil), CoQ10 for heart health, vitamin K for bones, vitamin E for antioxidant support.*\n',
  '17 essential nutrients: vitamin D3 for immune health, vitamin B12 (methylcobalamin) for energy, omega-3 EPA & DHA (from fish oil), CoQ10 for heart health, vitamin K for bones, vitamin E for antioxidant support.*\n'
];

List<Specialization> specializations = [
  const Specialization(
      time: [],
      icon: 'assets/Icons/Heart.svg',
      text: 'Brand',
      subText: 'Tmrw Pharmacy'),
  const Specialization(
      time: [],
      icon: 'assets/Icons/Time.svg',
      text: 'Age Range',
      subText: 'Adult'),
  const Specialization(
      time: [],
      icon: 'assets/Icons/Search.svg',
      text: 'Primary Supp',
      subText: 'Multi Vitamins'),
  const Specialization(
      time: [],
      icon: 'assets/Icons/Discovery.svg',
      text: 'Item Form',
      subText: 'Gummies'),
];

List<Specialization> order = [
  const Specialization(
      time: [],
      icon: 'assets/Icons/Discovery.svg',
      text: 'Code Order',
      subText: '#21091995'),
  const Specialization(
      time: [],
      icon: 'assets/Icons/Time.svg',
      text: 'Estimated Time',
      subText: '11:45 AM'),
  const Specialization(
      time: [],
      icon: 'assets/Icons/document.svg',
      text: 'An email confirmation will be sent to',
      subText: 'rishabh@fluttertop.com'),
];

List<Specialization> medixpharmacy = [
  const Specialization(
      icon: 'assets/Icons/Discovery.svg',
      text: 'Location',
      time: [],
      subText: '23 Estean, New York City, USA'),
  const Specialization(
      icon: 'assets/Icons/Time.svg',
      text: 'Support Time',
      time: [
        '8:00 - 12:00 AM & 13:00 - 20:00 PM',
        '8:00 - 12:00 AM & 13:00 - 20:00 PM'
      ],
      subText: 'Mon - Fri:'),
  const Specialization(
      icon: 'assets/Icons/call.svg',
      time: [],
      text: 'Hotline',
      subText: '(+84) 345-342-9968'),
];
