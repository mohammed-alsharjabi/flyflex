import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import '../../features/auth/data/models/user_model.dart';
import '../../features/bookings/data/models/booking_model.dart';
import '../../features/flights/data/models/flight_model.dart';
import '../../features/payment/data/models/payment_model.dart';
import '../../features/seat_selection/data/models/seat_model.dart';
import 'l10n_extension.dart';

extension CabinClassL10n on CabinClass {
  String localizedName(BuildContext context) {
    final l = context.l10n;
    return switch (this) {
      CabinClass.economy => l.cabinEconomy,
      CabinClass.business => l.cabinBusiness,
      CabinClass.first => l.cabinFirst,
    };
  }
}

extension PaymentMethodL10n on PaymentMethod {
  String localizedName(BuildContext context) {
    final l = context.l10n;
    return switch (this) {
      PaymentMethod.creditCard => l.paymentCreditCard,
      PaymentMethod.applePay => l.paymentApplePay,
      PaymentMethod.googlePay => l.paymentGooglePay,
      PaymentMethod.bankTransfer => l.paymentBankTransfer,
    };
  }

  String localizedSubtitle(BuildContext context) {
    final l = context.l10n;
    return switch (this) {
      PaymentMethod.creditCard => l.paymentVisaMastercard,
      PaymentMethod.applePay => l.paymentApplePaySub,
      PaymentMethod.googlePay => l.paymentGooglePaySub,
      PaymentMethod.bankTransfer => l.paymentBankTransferSub,
    };
  }
}

extension BookingStatusL10n on BookingStatus {
  String localizedName(BuildContext context) {
    final l = context.l10n;
    return switch (this) {
      BookingStatus.upcoming => l.bookingsStatusUpcoming,
      BookingStatus.completed => l.bookingsStatusCompleted,
      BookingStatus.cancelled => l.bookingsStatusCancelled,
    };
  }
}

extension UserTierL10n on UserTier {
  String localizedName(BuildContext context) {
    final l = context.l10n;
    return switch (this) {
      UserTier.silver => l.profileTierSilver,
      UserTier.gold => l.profileTierGold,
      UserTier.platinum => l.profileTierPlatinum,
    };
  }
}

extension SeatCabinL10n on SeatModel {
  String localizedCabinName(BuildContext context) {
    final l = context.l10n;
    return switch (cabinLabel) {
      'First Class' => l.seatFirstClass,
      'Business Class' => l.seatBusiness,
      _ => l.seatEconomy,
    };
  }
}

String localizedCurrency(BuildContext context, double amount) {
  final l = context.l10n;
  return '${l.flightsCurrency} ${amount.toStringAsFixed(0)}';
}

String localizedAmenity(BuildContext context, String amenity) {
  final l = context.l10n;
  final key = amenity.toLowerCase();
  if (key.contains('snack')) return l.amenitySnacks;
  if (key.contains('usb') || key.contains('charging')) return l.amenityUsbCharging;
  if (key.contains('full meal') || key.contains('meal')) return l.amenityFullMeal;
  if (key.contains('wi-fi') || key.contains('wifi')) return l.amenityWifi;
  if (key.contains('flat bed') || key.contains('flat')) return l.amenityFlatBed;
  if (key.contains('lounge')) return l.amenityLoungeAccess;
  if (key.contains('amenity kit') || key.contains('kit')) return l.amenityAmenityKit;
  if (key.contains('private suite') || key.contains('suite')) return l.amenityPrivateSuite;
  if (key.contains('bar')) return l.amenityBar;
  if (key.contains('priority') || key.contains('boarding')) {
    return l.amenityPriorityBoarding;
  }
  if (key.contains('shower') || key.contains('spa')) return l.amenityShowerSpa;
  if (key.contains('legroom')) return l.amenityExtraLegroom;
  if (key.contains('entertainment')) return l.amenityEntertainment;
  if (key.contains('chauffeur')) return l.amenityChauffeur;
  return amenity;
}

String localizedDate(BuildContext context, DateTime date) {
  final locale = Localizations.localeOf(context).languageCode;
  return intl.DateFormat('d MMM yyyy', locale).format(date);
}
