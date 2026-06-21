import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:fly_flex/features/flights/data/models/flight_model.dart';

class TicketModel extends Equatable {
  const TicketModel({
    required this.bookingId,
    required this.flight,
    required this.passengerName,
    required this.seatNumber,
    required this.cabinClass,
    required this.gate,
    required this.boardingTime,
    required this.status,
    required this.qrData,
    required this.issuedAt,
  });

  final String bookingId;
  final FlightModel flight;
  final String passengerName;
  final String seatNumber;
  final CabinClass cabinClass;
  final String gate;
  final DateTime boardingTime;
  final String status; // 'confirmed' | 'checked_in' | 'boarded'
  final String qrData;
  final DateTime issuedAt;

  Map<String, dynamic> toJson() => {
        'booking_id': bookingId,
        'flight': flight.toJson(),
        'passenger_name': passengerName,
        'seat_number': seatNumber,
        'cabin_class': cabinClass.name,
        'gate': gate,
        'boarding_time': boardingTime.toIso8601String(),
        'status': status,
        'qr_data': qrData,
        'issued_at': issuedAt.toIso8601String(),
      };

  factory TicketModel.fromJson(Map<String, dynamic> json) => TicketModel(
        bookingId: json['booking_id'] as String,
        flight: FlightModel.fromJson(json['flight'] as Map<String, dynamic>),
        passengerName: json['passenger_name'] as String,
        seatNumber: json['seat_number'] as String,
        cabinClass: CabinClass.fromString(json['cabin_class'] as String),
        gate: json['gate'] as String,
        boardingTime: DateTime.parse(json['boarding_time'] as String),
        status: json['status'] as String,
        qrData: json['qr_data'] as String,
        issuedAt: DateTime.parse(json['issued_at'] as String),
      );

  String toJsonString() => jsonEncode(toJson());

  factory TicketModel.fromJsonString(String raw) =>
      TicketModel.fromJson(jsonDecode(raw) as Map<String, dynamic>);

  @override
  List<Object?> get props => [bookingId, qrData];
}
