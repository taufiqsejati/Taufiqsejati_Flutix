part of 'ticket_bloc.dart';

class TicketState extends Equatable {
  final List<Ticket> tickets;

  const TicketState(this.tickets);

  @override
  // TODO: implement props
  List<Object> get props => [tickets];
}
