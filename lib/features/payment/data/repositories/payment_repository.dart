import '../models/payment_model.dart';

abstract interface class PaymentRepository {
  Future<PaymentModel> processPayment({
    required double amount,
    required PaymentMethod method,
  });
}
