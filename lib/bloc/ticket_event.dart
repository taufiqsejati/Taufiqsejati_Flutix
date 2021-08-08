part of 'ticket_bloc.dart';

abstract class TicketEvent extends Equatable {
  const TicketEvent();
}

class GetTickets extends TicketEvent {
  final String userID;

  GetTickets(this.userID);

  @override
  // TODO: implement props
  List<Object> get props => [userID];
}

class BuyTicket extends TicketEvent {
  final Ticket ticket;
  final String userID;

  BuyTicket(this.ticket, this.userID);

  @override
  // TODO: implement props
  List<Object> get props => [ticket,userID];
}