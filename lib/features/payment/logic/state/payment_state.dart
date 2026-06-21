import 'package:equatable/equatable.dart';
import '../../data/models/payment_model.dart';

class PaymentState extends Equatable {
  const PaymentState({
    this.selectedMethod = PaymentMethod.creditCard,
    this.status = PaymentStatus.idle,
    this.payment,
    this.errorMessage,
  });

  final PaymentMethod selectedMethod;
  final PaymentStatus status;
  final PaymentModel? payment;
  final String? errorMessage;

  PaymentState copyWith({
    PaymentMethod? selectedMethod,
    PaymentStatus? status,
    PaymentModel? payment,
    String? errorMessage,
  }) =>
      PaymentState(
        selectedMethod: selectedMethod ?? this.selectedMethod,
        status: status ?? this.status,
        payment: payment ?? this.payment,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object?> get props => [selectedMethod, status, payment, errorMessage];
}
