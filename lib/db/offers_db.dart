import 'package:flutter/material.dart';
import 'package:loqma/models/offer_model.dart';


final  ValueNotifier<List<Offer>> offersNotifier = ValueNotifier<List<Offer>>([
  Offer(
  ownerId:2 ,
    title: 'وجبة برغر دجاج مضاعفة',
    description: 'وجبة برغر مع بطاطا فائضة عن طلب مطعم، جاهزة للتناول الفوري.',
    quantity: 2,
    productionDate: DateTime.now(),
    expiryDate: DateTime.now().add(const Duration(hours: 6)),
    type: OfferType.sale,
    price: 1.80,
    originalPrice: 4.50,
    category: 'fast food',
    image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrOjwDT1psaP5bz_sw0Le14wmWViiyRytwJY-529Atyg&s=10',
    volunteerId: null,
  ),

  // 2. Vegetables
  Offer(
    ownerId: 2,
    title: 'صندوق خضروات مشكلة طازجة',
    description: 'تشكيلة طماطم، خيار، وبطاطا بحالة ممتازة للتبرع المباشر.',
    quantity: 4,
    productionDate: DateTime.now().subtract(const Duration(days: 1)),
    expiryDate: DateTime.now().add(const Duration(days: 3)),
    type: OfferType.donation,
    category: 'vegetablse',
    image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrOjwDT1psaP5bz_sw0Le14wmWViiyRytwJY-529Atyg&s=10',
    volunteerId: 101,
  ),

  // 3. Fruits
  Offer(
    ownerId:3 ,
    title: 'سلة تفاح وموز طازج',
    description: 'فواكه مشكلة فائضة بحالة ممتازة جداً وصالحة للاستهلاك.',
    quantity: 3,
    productionDate: DateTime.now(),
    expiryDate: DateTime.now().add(const Duration(days: 2)),
    type: OfferType.donation,
    category: 'fruits',
    image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrOjwDT1psaP5bz_sw0Le14wmWViiyRytwJY-529Atyg&s=10',
    volunteerId: 102,
  ),

  // 4. Meat
  Offer(
    ownerId: 3,
    title: 'طبق صدور دجاج متبلة',
    description: 'صدور دجاج طازجة متبلة ومغلفة بسعر مخفض للحد من الهدر.',
    quantity: 2,
    productionDate: DateTime.now(),
    expiryDate: DateTime.now().add(const Duration(days: 1)),
    type: OfferType.sale,
    price: 2.50,
    originalPrice: 5.50,
    category: 'meat',
    image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrOjwDT1psaP5bz_sw0Le14wmWViiyRytwJY-529Atyg&s=10',
    volunteerId: null,
  ),

  // 5. Dairy
  Offer(
    ownerId:4 ,
    title: 'عبوات ألبان وأجبان طازجة',
    description: 'مجموعة ألبان وأجبان مغلقة ومحفوظة بشكل ممتاز بالتلاجة.',
    quantity: 5,
    productionDate: DateTime.now().subtract(const Duration(days: 1)),
    expiryDate: DateTime.now().add(const Duration(days: 4)),
    type: OfferType.donation,
    category: 'dairy',
    image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrOjwDT1psaP5bz_sw0Le14wmWViiyRytwJY-529Atyg&s=10',
    volunteerId: 103,
  ),

  // 6. Bakery
  Offer(
    ownerId: 7,
    title: 'سلة معجنات ومخبوزات مشكلة',
    description: 'تشكيلة خبز ومعجنات طازجة مخبوزة اليوم معروضة بخصم كبير.',
    quantity: 6,
    productionDate: DateTime.now(),
    expiryDate: DateTime.now().add(const Duration(days: 1)),
    type: OfferType.sale,
    price: 1.00,
    originalPrice: 3.50,
    category: 'bakery',
    image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrOjwDT1psaP5bz_sw0Le14wmWViiyRytwJY-529Atyg&s=10',
    volunteerId: null,
  ),

  // 7. Canned
  Offer(
    ownerId: 8,
    title: 'طرد معلبات مشكلة (ذرة وفول)',
    description: 'معلبات غذائية جديدة ومغلقة بالكامل مخصصة للتبرع.',
    quantity: 10,
    productionDate: DateTime.now().subtract(const Duration(days: 30)),
    expiryDate: DateTime.now().add(const Duration(days: 180)),
    type: OfferType.donation,
    category: 'canned',
    image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrOjwDT1psaP5bz_sw0Le14wmWViiyRytwJY-529Atyg&s=10',
    volunteerId: 104,
  ),

  // 8. Dry Food
  Offer(
    ownerId: 15,
    title: 'أكياس أرز ومكرونة مغلفة',
    description: 'مواد غذائية جافة مغلفة ومحفوظة بحالة ممتازة بسعر رمزي.',
    quantity: 4,
    productionDate: DateTime.now().subtract(const Duration(days: 10)),
    expiryDate: DateTime.now().add(const Duration(days: 120)),
    type: OfferType.sale,
    price: 1.20,
    originalPrice: 3.00,
    category: 'dry food',
    image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrOjwDT1psaP5bz_sw0Le14wmWViiyRytwJY-529Atyg&s=10',
    volunteerId: null,
    
  ),

  // 9. Snacks
  Offer(
    ownerId: 50,
    title: 'صندوق سناك ومكسرات مشكلة',
    description: 'وجبات خفيفة ومكسرات مشكلة للتبرع المباشر بحالة ممتازة.',
    quantity: 5,
    productionDate: DateTime.now().subtract(const Duration(days: 2)),
    expiryDate: DateTime.now().add(const Duration(days: 30)),
    type: OfferType.donation,
    category: 'snacks',
    image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrOjwDT1psaP5bz_sw0Le14wmWViiyRytwJY-529Atyg&s=10',
    volunteerId: 105,
  ),

  // 10. Drinks
  Offer(
    ownerId: 3,
    title: 'عبوات عصائر طبيعية طازجة',
    description: 'عصائر برتقال وجزر طازجة ومبردة للبيع بسعر مخفض.',
    quantity: 8,
    productionDate: DateTime.now(),
    expiryDate: DateTime.now().add(const Duration(days: 2)),
    type: OfferType.sale,
    price: 0.75,
    originalPrice: 2.00,
    category: 'drinks',
    image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrOjwDT1psaP5bz_sw0Le14wmWViiyRytwJY-529Atyg&s=10',
    volunteerId: null,
  ),]);


List<Offer> offers = [
  
];





List<String>categories=[
  'All',
  'fast food',
  'vegetablse',
  'fruits',
  'meat',
  'dairy',
  'bakery',
  'canned',
  'dry food',
  'snacks',
  'drinks'  
  ];




  Map<String, int> categoryMaxDays = {
  'fast food': 2,        // يومين كحد أقصى
  'meat': 3,             // 3 أيام
  'bakery': 4,           // 4 أيام
  'dairy': 7,            // أسبوع
  'vegetablse': 10,      // 10 أيام
  'fruits': 14,          // أسبوعين
  'drinks': 30,          // شهر
  'snacks': 180,         // 6 أشهر
  'dry food': 365,       // سنة
  'canned': 730,         // سنتين
};