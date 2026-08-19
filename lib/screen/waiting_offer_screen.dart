import 'package:flutter/material.dart';
import 'package:loqma/custom_widget/empty_waiting_state.dart';
import 'package:loqma/custom_widget/waiting_offer_card.dart';
import 'package:loqma/db/offers_db.dart';
import 'package:loqma/models/offer_model.dart';
import 'package:loqma/provider/offer%20providers/waiting_offers.dart';
import 'package:provider/provider.dart';

class WaitingOfferScreen extends StatelessWidget {
  const WaitingOfferScreen({Key? key}) : super(key: key);

  void _acceptOffer(BuildContext context, Offer offer) {
    offersNotifier.value = [...offersNotifier.value, offer];
    Provider.of<WaitingOffers>(context, listen: false).remove(offer);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('"${offer.title}" has been approved and published successfully!'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _rejectOffer(BuildContext context, Offer offer) {
    Provider.of<WaitingOffers>(context, listen: false).remove(offer);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Offer "${offer.title}" has been rejected.'),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Pending Offers'),
        centerTitle: true,
      ),
      body: Consumer<WaitingOffers>(
        builder: (context, waitingProvider, child) {
          final waitingList = waitingProvider.offers;

          if (waitingList.isEmpty) {
            return const EmptyWaitingState();
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: waitingList.length,
            itemBuilder: (context, index) {
              final offer = waitingList[index];

              return WaitingOfferCard(
                offer: offer,
                onAccept: () => _acceptOffer(context, offer),
                onReject: () => _rejectOffer(context, offer),
              );
            },
          );
        },
      ),
    );
  }
}