import '../datasources/payment_local_datasource.dart';
import '../models/payment_model.dart';
import 'payment_repository.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  PaymentRepositoryImpl(this._datasource);

  final PaymentLocalDatasource _datasource;

  @override
  Future<PaymentModel> processPayment({
    required double amount,
    required PaymentMethod method,
  }) =>
      _datasource.processPayment(amount: amount, method: method);
}
