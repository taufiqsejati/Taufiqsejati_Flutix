part of 'services.dart';

class TicketServices {
  static CollectionReference ticketCollection =
      FirebaseFirestore.instance.collection('tickets');

  static Future<void> saveTicket(String id, Ticket ticket) async {
    await ticketCollection.doc().set({
      'movieID': ticket.movieDetail.id ?? "",
      'userID': id ?? "",
      'theaterName': ticket.theater.name ?? 0,
      'time': ticket.time.millisecondsSinceEpoch ??
          DateTime.now().millisecondsSinceEpoch,
      'bookingCode': ticket.bookingCode,
      'seats': ticket.seatsInString,
      'name': ticket.name,
      'totalPrice': ticket.totalPrice
    });
  }

  static Future<List<Ticket>> getTickets(String userId) async {
    QuerySnapshot snapshot = await ticketCollection.get();
    // var documents =
    //     snapshot.docs.where((document) => document.data()['userID'] == userId);

    var documents = snapshot.docs.where((document) =>
        FlutixTransaction.fromJson(
                document.id, document.data() as Map<String, dynamic>)
            .userID ==
        userId);
    // var tickets = documents;
    List<Ticket> tickets = [];
    for (var document in documents) {
      // MovieDetail movieDetail = await MovieServices.getDetails(null,
      //     movieID: document.data()['movieID']);
      //       return documents.map(
      //   (e) {
      //     return FlutixTransaction.fromJson(
      //         e.id, e.data() as Map<String, dynamic>);
      //   },
      // ).toList();
      MovieDetail movieDetail = await MovieServices.getDetails(null,
          movieID: document.get('movieID'));
      // tickets.add(Ticket.fromJson(
      //     movieDetail, document.data() as Map<String, dynamic>));
      tickets.add(Ticket(
          movieDetail,
          Theater(document.get('theaterName')),
          DateTime.fromMillisecondsSinceEpoch(document.get('time')),
          document.get('bookingCode'),
          document.get('seats').toString().split(','),
          document.get('name'),
          document.get('totalPrice')));
    }

    return tickets;
    // print('userid? ${userId}');
    // return documents.map(
    //   (e) async {
    //     print('isinya apa?${e.get('movieID')}');
    //           MovieDetail movieDetail = await MovieServices.getDetails(null,
    //       movieID:e.get('movieID'));
    //     return e.data();
    //   },
    // ).toList();
  }
}
