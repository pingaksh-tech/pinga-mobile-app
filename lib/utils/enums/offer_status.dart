enum OfferStatus {
  none(id: -1),
  pending(id: 0),
  accepted(id: 1),
  rejected(id: 2),
  notAvailable(id: 3),
  closed(id: 4);

  final int id;
  const OfferStatus({required this.id});

  static OfferStatus formId(int id) {
    switch (id) {
      case 0:
        return OfferStatus.pending;
      case 1:
        return OfferStatus.accepted;
      case 2:
        return OfferStatus.rejected;
      case 3:
        return OfferStatus.notAvailable;
      case 4:
        return OfferStatus.closed;
      default:
        return OfferStatus.none;
    }
  }

  static OfferType offerType(OfferStatus status) {
    switch (status) {
      case OfferStatus.pending:
        return OfferType.replayOffer;
      case OfferStatus.accepted:
        return OfferType.acceptOffer;
      case OfferStatus.rejected:
        return OfferType.rejectOfferDone;
      case OfferStatus.notAvailable:
        return OfferType.notAvailableDone;
      default:
        return OfferType.none;
    }
  }
}

enum OfferType {
  none,
  replayOffer,

  acceptOffer,

  sendNewOffer,
  sendNewOfferDone,

  rejectOffer,
  rejectOfferDone,

  notAvailable,
  notAvailableDone,
}

// 0=> pending,
// 1=>accepted,
// 2=>rejected,
// 3=>not_available
// 4=>closed
