import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/payment_model.dart';

class PaymentLocalDatasource {
  static const _paymentPrefix = 'payment_';

  Future<PaymentModel> processPayment({
    required double amount,
    required PaymentMethod method,
    String flightId = '',
  }) async {
    await Future.delayed(const Duration(seconds: 2));

    final now = DateTime.now();
    final payment = PaymentModel(
      id: 'PAY-${now.millisecondsSinceEpoch}',
      amount: amount,
      currency: 'SAR',
      method: method,
      status: PaymentStatus.completed,
      transactionId: 'TXN-${now.millisecondsSinceEpoch}',
      processedAt: now,
      flightId: flightId,
      cardLastFour: method == PaymentMethod.creditCard ? '4242' : null,
    );

    await savePayment(payment);
    return payment;
  }

  Future<void> savePayment(PaymentModel payment) async {
    final prefs = await SharedPreferences.getInstance();
    final data = {
      'id': payment.id,
      'amount': payment.amount,
      'currency': payment.currency,
      'method': payment.method.name,
      'status': payment.status.name,
      'processed_at': payment.processedAt.toIso8601String(),
      'card_last_four': payment.cardLastFour,
      'transaction_id': payment.transactionId,
      'flight_id': payment.flightId,
    };
    await prefs.setString(
      '$_paymentPrefix${payment.id}',
      jsonEncode(data),
    );
  }

  Future<PaymentModel?> getPayment(String paymentId) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('$_paymentPrefix$paymentId');
    if (raw == null) return null;

    final data = jsonDecode(raw) as Map<String, dynamic>;
    return PaymentModel(
      id: data['id'] as String,
      amount: (data['amount'] as num).toDouble(),
      currency: data['currency'] as String,
      method: PaymentMethod.values.firstWhere(
        (m) => m.name == data['method'],
        orElse: () => PaymentMethod.creditCard,
      ),
      status: PaymentStatus.values.firstWhere(
        (s) => s.name == data['status'],
        orElse: () => PaymentStatus.pending,
      ),
      processedAt: DateTime.parse(data['processed_at'] as String),
      cardLastFour: data['card_last_four'] as String?,
      transactionId: data['transaction_id'] as String,
      flightId: data['flight_id'] as String? ?? '',
    );
  }
}
