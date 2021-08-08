part of 'ticket_bloc.dart';

abstract class TicketState extends Equatable {
  const TicketState();
}

class TicketInitial extends TicketState {
  @override
  List<Object> get props => [];
}
