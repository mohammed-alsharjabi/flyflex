import 'package:equatable/equatable.dart';

enum SeatStatus { available, occupied, selected, premium }

class SeatModel extends Equatable {
  const SeatModel({
    required this.id,
    required this.row,
    required this.column,
    required this.status,
    required this.isPremium,
    this.extraCharge = 0.0,
  });

  final String id;
  final int row;
  final String column;
  final SeatStatus status;
  final bool isPremium;
  final double extraCharge;

  bool get isSelectable =>
      status == SeatStatus.available || status == SeatStatus.premium;

  String get label => '$row$column';

  String get cabinLabel {
    if (row <= 4) return 'First Class';
    if (row <= 15) return 'Business Class';
    return 'Economy';
  }

  SeatModel copyWith({SeatStatus? status}) => SeatModel(
        id: id,
        row: row,
        column: column,
        status: status ?? this.status,
        isPremium: isPremium,
        extraCharge: extraCharge,
      );

  @override
  List<Object?> get props => [id, row, column, status, isPremium, extraCharge];
}
