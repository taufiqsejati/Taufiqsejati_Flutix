import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'ticket_event.dart';
part 'ticket_state.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  TicketBloc() : super(TicketInitial());

  @override
  Stream<TicketState> mapEventToState(
    TicketEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
