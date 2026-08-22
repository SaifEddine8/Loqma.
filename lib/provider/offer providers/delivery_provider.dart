import 'package:flutter/material.dart';
import 'package:loqma/db/offers_db.dart';
import 'package:loqma/models/offer_model.dart';
import 'package:loqma/models/order_model.dart';
import 'package:loqma/models/notification_model.dart';
import 'package:loqma/services/local_notification_services.dart';

class DeliveryProvider with ChangeNotifier {
  final Map<Offer, int> _deliveryItems = {}; 
  final Map<Offer, String> _itemStatuses = {};
  final Map<Offer, int> _completedDeliveries = {};
  final Map<Offer, DateTime> _reservationDates = {};

  double subTotal = 0.0;
  double tax = 0.0;

  List<Offer> get offers => _deliveryItems.keys.toList();
  List<Offer> get completedOffers => _completedDeliveries.keys.toList();

  int getQuantity(Offer offer) {
    Offer keyOffer = _getExistingKey(offer);
    return _deliveryItems[keyOffer] ?? 1;
  }

  String getStatus(Offer offer) {
    Offer keyOffer = _getExistingKey(offer);
    return _itemStatuses[keyOffer] ?? "In Preparation";
  }

  int getCompletedQuantity(Offer offer) => _completedDeliveries[offer] ?? 0;

  int get totalDeliveredCount {
    return _completedDeliveries.values.fold(0, (sum, quantity) => sum + quantity);
  }

  Offer _getExistingKey(Offer offer) {
    return _deliveryItems.keys.firstWhere(
      (element) => element.id == offer.id,
      orElse: () => offer,
    );
  }

  void fetchUserDeliveryData(String userId) {
    _deliveryItems.clear();
    _itemStatuses.clear();
    _completedDeliveries.clear();
    notifyListeners();
  }

  void clearData() {
    _deliveryItems.clear();
    _itemStatuses.clear();
    _completedDeliveries.clear();
    subTotal = 0.0;
    tax = 0.0;
    notifyListeners();
  }

  Future<void> addToDelivery(Offer offer, {required int volunteerId}) async {
    Offer keyOffer = _getExistingKey(offer);

    if (!_deliveryItems.containsKey(keyOffer)) {
      int remainingInDb = keyOffer.quantity - 1;
      
      Offer updatedOffer = keyOffer.copyWith(
        quantity: remainingInDb < 0 ? 0 : remainingInDb,
        volunteerId: volunteerId,
      );
      
      _deliveryItems[updatedOffer] = 1; 
      _itemStatuses[updatedOffer] = "In Preparation";

      updateOfferQuantityInDB(updatedOffer: updatedOffer);
      _reservationDates[updatedOffer] = DateTime.now();
      notifyListeners();
    }
  }

  Future<bool> removeFromDelivery(Offer offer) async {
    Offer keyOffer = _getExistingKey(offer);

    if (_deliveryItems.containsKey(keyOffer)) {
      DateTime? reservedTime = _reservationDates[keyOffer];

      if (reservedTime != null) {
        final minutesPassed = DateTime.now().difference(reservedTime).inMinutes;

        if (minutesPassed >= 15) {
          return false;
        }
      }

      int myQtyToReturn = _deliveryItems[keyOffer]!;

      int restoredDbQuantity = keyOffer.quantity + myQtyToReturn;
      Offer updatedOffer = keyOffer.copyWith(quantity: restoredDbQuantity);

      _deliveryItems.remove(keyOffer);
      _itemStatuses.remove(keyOffer);
      _reservationDates.remove(keyOffer);

      updateOfferQuantityInDB(updatedOffer: updatedOffer);
      notifyListeners();
      return true;
    }
    return false;
  }

  bool canCancelReservation(Offer offer) {
    Offer keyOffer = _getExistingKey(offer);
    DateTime? reservedTime = _reservationDates[keyOffer];
    
    if (reservedTime == null) return true; 

    return DateTime.now().difference(reservedTime).inMinutes < 15;
  }

  void increament(Offer offer) {
    Offer keyOffer = _getExistingKey(offer);

    if (_deliveryItems.containsKey(keyOffer)) {
      int myCurrentQty = _deliveryItems[keyOffer]!;

      int totalOfferQuantity = keyOffer.quantity + myCurrentQty;
      int maxAllowedQty = (totalOfferQuantity * 0.25).floor(); 
      if (maxAllowedQty < 1) maxAllowedQty = 1;

      if (myCurrentQty < maxAllowedQty && keyOffer.quantity > 0) {
        int newMyQty = myCurrentQty + 1;
        int newDbQty = keyOffer.quantity - 1;

        Offer updatedOffer = keyOffer.copyWith(quantity: newDbQty);
        String currentStatus = _itemStatuses[keyOffer] ?? "In Preparation";

        _deliveryItems.remove(keyOffer);
        _itemStatuses.remove(keyOffer);

        _deliveryItems[updatedOffer] = newMyQty;
        _itemStatuses[updatedOffer] = currentStatus;

        updateOfferQuantityInDB(updatedOffer: updatedOffer);
        notifyListeners();
      }
    }
  }

  void decreament(Offer offer) {
    Offer keyOffer = _getExistingKey(offer);

    if (_deliveryItems.containsKey(keyOffer) && _deliveryItems[keyOffer]! > 1) {
      int newMyQty = _deliveryItems[keyOffer]! - 1;
      int newDbQty = keyOffer.quantity + 1;

      Offer updatedOffer = keyOffer.copyWith(quantity: newDbQty);
      String currentStatus = _itemStatuses[keyOffer] ?? "In Preparation";

      _deliveryItems.remove(keyOffer);
      _itemStatuses.remove(keyOffer);

      _deliveryItems[updatedOffer] = newMyQty;
      _itemStatuses[updatedOffer] = currentStatus;

      updateOfferQuantityInDB(updatedOffer: updatedOffer);
      notifyListeners();
    }
  }

  void moveToNextStatus(Offer offer, {OrderModel? receiptOrder}) {
    Offer keyOffer = _getExistingKey(offer);
    String currentStatus = getStatus(keyOffer);
    int myRequestedQuantity = getQuantity(keyOffer);

    if (currentStatus == "In Preparation") {
      _itemStatuses[keyOffer] = "In Delivery";
      
    } else if (currentStatus == "In Delivery") {
      _completedDeliveries[keyOffer] = (_completedDeliveries[keyOffer] ?? 0) + myRequestedQuantity;
      _deliveryItems.remove(keyOffer);
      _itemStatuses.remove(keyOffer);

      if (receiptOrder != null) {
        LocalNotificationService.createOrderNotifications(order: receiptOrder);
      }
    }

    notifyListeners(); 
  }

  Future<void> checkAndApplyExpiredPenalties(String userId) async {
    List<Offer> expiredOffers = [];

    for (var offer in _deliveryItems.keys) {
      String status = getStatus(offer);

      if (status == "In Preparation" && _isExpired(offer)) {
        expiredOffers.add(offer);
      }
    }

    for (var offer in expiredOffers) {
      int reservedQty = _deliveryItems[offer] ?? 1;

      int restoredDbQuantity = offer.quantity + reservedQty;
      updateOfferQuantityInDB(
        updatedOffer: offer.copyWith(quantity: restoredDbQuantity),
      );

      _deliveryItems.remove(offer);
      _itemStatuses.remove(offer);
      _reservationDates.remove(offer);

      double penalty = 2.0;

      await addPenaltyToUserInDB(
        userId: userId, 
        penaltyAmount: penalty, 
        reason: "Failed to pick up item before expiration: ${offer.title}",
      );

      LocalNotificationService.addPenaltyNotification(
        userId: userId,
        penaltyAmount: penalty,
        offerTitle: offer.title,
      );
    }

    if (expiredOffers.isNotEmpty) {
      notifyListeners();
    }
  }

  Future<void> addPenaltyToUserInDB({
    required String userId, 
    required double penaltyAmount, 
    required String reason,
  }) async {
    print("Penalty registered for $userId: $penaltyAmount JOD");
  }

  bool _isExpired(Offer offer) {
    DateTime? reservedDate = _reservationDates[offer];
    if (reservedDate == null) return false;

    DateTime now = DateTime.now();
    final expirationTime = reservedDate.add(const Duration(hours: 1));

    return now.isAfter(expirationTime);
  }
}