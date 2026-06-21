import '../../../flights/data/models/flight_model.dart';
import '../models/flight_details_model.dart';

class FlightDetailsLocalDatasource {
  FlightDetailsModel getDetails(FlightModel flight) {
    final List<String> amenities;
    final String baggageInfo;
    final int onTimeRate;
    final String refundPolicy;

    switch (flight.cabinClass) {
      case CabinClass.first:
        amenities = [
          'Wi-Fi',
          'À La Carte Dining',
          'Lie-Flat Bed',
          'Entertainment',
          'Luxury Kit',
          'Chauffeur Service',
          'Spa Access',
        ];
        baggageInfo = '2 × 32 kg checked + 10 kg cabin';
        onTimeRate = 97;
        refundPolicy = 'Fully Refundable';
      case CabinClass.business:
        amenities = [
          'Wi-Fi',
          'Gourmet Meals',
          'Entertainment',
          'Extra Legroom',
          'USB Charging',
          'Lounge Access',
        ];
        baggageInfo = '1 × 32 kg checked + 7 kg cabin';
        onTimeRate = 94;
        refundPolicy = 'Refundable (fees apply)';
      case CabinClass.economy:
        amenities = [
          'USB Charging',
          'Carry-on Included',
          if (flight.amenities.any((a) => a.toLowerCase().contains('wi')))
            'Wi-Fi',
          if (flight.amenities.any((a) => a.toLowerCase().contains('meal')))
            'Meals',
          'Seat Recline',
        ];
        baggageInfo = '1 × 23 kg checked + 7 kg cabin';
        onTimeRate = 88;
        refundPolicy = 'Non-refundable';
    }

    return FlightDetailsModel(
      flight: flight,
      amenities: amenities,
      baggageInfo: baggageInfo,
      aircraftType: flight.aircraft,
      onTimeRate: onTimeRate,
      departureTerminal: 'T${(flight.id.hashCode.abs() % 5) + 1}',
      arrivalTerminal: 'T${(flight.flightNumber.hashCode.abs() % 4) + 1}',
      boardingTime: flight.departureTime.subtract(const Duration(minutes: 45)),
      refundPolicy: refundPolicy,
    );
  }
}
