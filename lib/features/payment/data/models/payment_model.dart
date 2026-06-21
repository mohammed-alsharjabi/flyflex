import 'package:equatable/equatable.dart';

enum PaymentMethod {
  creditCard,
  applePay,
  googlePay,
  bankTransfer;

  String get label {
    switch (this) {
      case PaymentMethod.creditCard:
        return 'Credit Card';
      case PaymentMethod.applePay:
        return 'Apple Pay';
      case PaymentMethod.googlePay:
        return 'Google Pay';
      case PaymentMethod.bankTransfer:
        return 'Bank Transfer';
    }
  }

  String get subtitle {
    switch (this) {
      case PaymentMethod.creditCard:
        return 'Visa, Mastercard, Amex';
      case PaymentMethod.applePay:
        return 'Pay with Face ID / Touch ID';
      case PaymentMethod.googlePay:
        return 'Pay with Google account';
      case PaymentMethod.bankTransfer:
        return 'Direct bank transfer';
    }
  }
}

enum PaymentStatus { idle, pending, completed, failed }

class PaymentModel extends Equatable {
  const PaymentModel({
    required this.id,
    required this.method,
    required this.amount,
    required this.currency,
    required this.status,
    required this.transactionId,
    required this.processedAt,
    required this.flightId,
    this.cardLastFour,
  });

  final String id;
  final PaymentMethod method;
  final double amount;
  final String currency;
  final PaymentStatus status;
  final String transactionId;
  final DateTime processedAt;
  final String flightId;
  final String? cardLastFour;

  @override
  List<Object?> get props => [id, transactionId];
}
