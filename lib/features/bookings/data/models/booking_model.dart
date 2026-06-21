import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fly_flex/features/flights/data/models/flight_model.dart';

enum BookingStatus {
  upcoming,
  completed,
  cancelled;

  Color get color => switch (this) {
        BookingStatus.upcoming => const Color(0xFF2ECC71),
        BookingStatus.completed => const Color(0xFF3498DB),
        BookingStatus.cancelled => const Color(0xFFE74C3C),
      };

  String get label => switch (this) {
        BookingStatus.upcoming => 'Upcoming',
        BookingStatus.completed => 'Completed',
        BookingStatus.cancelled => 'Cancelled',
      };
}

class BookingModel extends Equatable {
  const BookingModel({
    required this.id,
    required this.flight,
    required this.passengerName,
    required this.seatNumber,
    required this.status,
    required this.bookedAt,
    required this.totalPaid,
    required this.bookingRef,
  });

  final String id;
  final FlightModel flight;
  final String passengerName;
  final String seatNumber;
  final BookingStatus status;
  final DateTime bookedAt;
  final double totalPaid;
  final String bookingRef;

  @override
  List<Object?> get props => [id, bookingRef];
}
