import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/payment_model.dart';
import '../../data/repositories/payment_repository.dart';
import '../state/payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this._repository) : super(const PaymentState());

  final PaymentRepository _repository;

  void selectMethod(PaymentMethod method) {
    emit(state.copyWith(selectedMethod: method));
  }

  Future<void> processPayment(double amount) async {
    emit(state.copyWith(status: PaymentStatus.pending));
    try {
      final payment = await _repository.processPayment(
        amount: amount,
        method: state.selectedMethod,
      );
      emit(state.copyWith(
        status: PaymentStatus.completed,
        payment: payment,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: PaymentStatus.failed,
        errorMessage: e.toString(),
      ));
    }
  }

  void clearError() {
    if (state.status == PaymentStatus.failed) {
      emit(state.copyWith(status: PaymentStatus.idle, errorMessage: null));
    }
  }

  void reset() {
    emit(const PaymentState());
  }
}
