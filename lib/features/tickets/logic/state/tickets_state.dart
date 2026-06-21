import 'package:equatable/equatable.dart';
import '../../data/models/ticket_model.dart';

sealed class TicketsState extends Equatable {
  const TicketsState();
}

final class TicketsInitial extends TicketsState {
  const TicketsInitial();

  @override
  List<Object?> get props => [];
}

final class TicketsLoading extends TicketsState {
  const TicketsLoading();

  @override
  List<Object?> get props => [];
}

final class TicketsLoaded extends TicketsState {
  const TicketsLoaded(this.ticket);

  final TicketModel ticket;

  @override
  List<Object?> get props => [ticket];
}

final class TicketsError extends TicketsState {
  const TicketsError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
