import 'package:flutter/material.dart';
import 'package:loqma/db/offers_db.dart';
import 'package:loqma/models/offer_model.dart';
import 'package:loqma/models/order_model.dart';
import 'package:loqma/models/user_model.dart'; 

class CartProvider with ChangeNotifier {
  final Map<String, Map<Offer, int>> _userCarts = {}; 
  
  String? _currentUserId;
  final List<OrderModel> _allOrders = [];

  double subTotal = 0.0;
  double tax = 0.0;

  Map<Offer, int> get _currentCart {
    final activeId = _currentUserId ?? "guest_user";
    return _userCarts.putIfAbsent(activeId, () => {});
  }

  List<Offer> get cartItems => _currentCart.keys.toList();
  Map<Offer, int> get fullCartMap => Map.from(_currentCart);

  double get total => subTotal + tax;

  int getQuantity(Offer offer) {
    Offer? target = _currentCart.keys.firstWhere((o) => o.id == offer.id, orElse: () => offer);
    return _currentCart[target] ?? 1;
  }

  List<OrderModel> getMyOrders(String userId) {
    return _allOrders.where((order) => order.userId == userId).toList();
  }

  void fetchUserCart(String userId) {
    _currentUserId = userId;
    
    if (!_userCarts.containsKey(userId)) {
      _userCarts[userId] = {};
    }

    sum();
  }

  void clearData() {
    _currentUserId = null;
    subTotal = 0.0;
    tax = 0.0;
    notifyListeners();
  }

  void addToCart(Offer offer) {
    bool isAlreadyInCart = _currentCart.keys.any((o) => o.id == offer.id);
    
    if (!isAlreadyInCart) {
      _currentCart[offer] = 1;
      sum();
    }
    notifyListeners();
  }
  
  void removeFromCart(Offer offer) {
    Offer? target = _currentCart.keys.firstWhere((o) => o.id == offer.id, orElse: () => offer);
    if (_currentCart.containsKey(target)) {
      _currentCart.remove(target);
      sum();
    }
    notifyListeners();
  } 

  void increament(Offer offer) {
    Offer? target = _currentCart.keys.firstWhere((o) => o.id == offer.id, orElse: () => offer);
    
    int maxAvailable = offersNotifier.value.firstWhere((o) => o.id == offer.id).quantity;

    if (_currentCart.containsKey(target)) {
      if (_currentCart[target]! < maxAvailable) {
        _currentCart[target] = _currentCart[target]! + 1;
        sum();
      } else {
        print("عذراً، لقد وصلت للحد الأقصى المتاح من هذه الوجبة في المطعم!");
      }
    }
  }

  void decreament(Offer offer) {
    Offer? target = _currentCart.keys.firstWhere((o) => o.id == offer.id, orElse: () => offer);
    if (_currentCart.containsKey(target) && _currentCart[target]! > 1) {
      _currentCart[target] = _currentCart[target]! - 1;
      sum();
    }
  }

  void sum() {
    subTotal = _currentCart.entries.fold<double>(
      0,
      (sum, item) => item.key.type == OfferType.donation ? sum + 0 : sum + (item.key.price! * item.value),
    );
    tax = subTotal * 0.05;
    notifyListeners();
  }

  OrderModel? processCheckout({
  required UserModel currentUser,
  required List<UserModel> allUsers,
}) {
  if (_currentCart.isEmpty) {
    print(" Checkout failed: Cart is empty.");
    return null;
  }

  String userAddress = currentUser.location?.address.trim().toLowerCase() ?? '';

  List<UserModel> localVolunteers = allUsers.where((user) {
    bool isVolunteer = user.type == UserType.volunteer;
    bool isNotSelf = user.id != currentUser.id;

    String volunteerAddress = user.location?.address.trim().toLowerCase() ?? '';

    bool isSameCity = userAddress.isNotEmpty &&
        volunteerAddress.isNotEmpty &&
        (userAddress.contains(volunteerAddress) || volunteerAddress.contains(userAddress));

    return isVolunteer && isNotSelf && isSameCity;
  }).toList();

  if (localVolunteers.isEmpty) {
    print(" No exact city match for: '$userAddress'. Finding any available volunteer...");
    localVolunteers = allUsers.where((user) => user.type == UserType.volunteer && user.id != currentUser.id).toList();
  }

  if (localVolunteers.isEmpty) {
    print(" No volunteers found in the entire system!");
    return null;
  }

  localVolunteers.shuffle();
  UserModel assignedVolunteer = localVolunteers.first;
  print(" Volunteer Assigned: ${assignedVolunteer.fullName} (ID: ${assignedVolunteer.id})");

  for (var entry in _currentCart.entries) {
    Offer cartOffer = entry.key;
    int requestedQty = entry.value;

    int index = offersNotifier.value.indexWhere((o) => o.id == cartOffer.id);
    if (index != -1) {
      int currentStock = offersNotifier.value[index].quantity;
      int newStock = (currentStock - requestedQty).clamp(0, currentStock);

      offersNotifier.value[index] = offersNotifier.value[index].copyWith(quantity: newStock);
    }
  }

  offersNotifier.value = List.from(offersNotifier.value);

  OrderModel receipt = OrderModel(
    orderId: DateTime.now().millisecondsSinceEpoch.toString().substring(5),
    userId: currentUser.id.toString(),
    orderedItems: Map.from(_currentCart),
    subTotal: subTotal,
    tax: tax,
    totalPrice: total,
    orderDate: DateTime.now(),
    volunteerId: assignedVolunteer.id.toString(),
    volunteerName: assignedVolunteer.fullName,
    volunteerPhone: assignedVolunteer.phone,
  );

  _allOrders.add(receipt);

  _currentCart.clear();
  subTotal = 0.0;
  tax = 0.0;
  notifyListeners();

  return receipt;
}
}