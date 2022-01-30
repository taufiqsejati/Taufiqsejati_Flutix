part of 'models.dart';

// class FlutixTransaction extends Equatable {
//   final String userID;
//   final String title;
//   final String subtitle;
//   final int amount;
//   final DateTime time;
//   final String picture;

//   FlutixTransaction(
//       {@required this.userID,
//       @required this.title,
//       @required this.subtitle,
//       this.amount = 0,
//       @required this.time,
//       this.picture});

//   @override
//   // TODO: implement props
//   List<Object> get props => [userID, title, subtitle, amount, time, picture];
// }

class FlutixTransaction extends Equatable {
  final String userID;
  final String title;
  final String subtitle;
  final int amount;
  final DateTime time;
  final String picture;
  // final String id;
  // final String name;
  // final String city;
  // final String imageUrl;
  // final double rating;
  // final int price;

  FlutixTransaction(
      //   {
      //   required this.id,
      //   this.name = '',
      //   this.city = '',
      //   this.imageUrl = '',
      //   this.rating = 0.0,
      //   this.price = 0,
      // });
      {@required this.userID,
      @required this.title,
      @required this.subtitle,
      this.amount = 0,
      @required this.time,
      this.picture});

  factory FlutixTransaction.fromJson(
          String userID, Map<String, dynamic> json) =>
      FlutixTransaction(
          userID: json['userID'],
          title: json['title'],
          subtitle: json['subtitle'],
          time: DateTime.fromMillisecondsSinceEpoch(json['time']),
          amount: json['amount'],
          picture: json['picture']
          // id: id,
          // name: json['name'],
          // city: json['city'],
          // imageUrl: json['imageUrl'],
          // rating: json['rating'].toDouble(),
          // price: json['price'],
          );

  Map<String, dynamic> toJson() => {
        'userID': userID,
        'title': title,
        'subtitle': subtitle,
        'time': time,
        'amount': amount,
        'picture': picture,
        // 'id': id,
        // 'name': name,
        // 'city': city,
        // 'imageUrl': imageUrl,
        // 'rating': rating,
        // 'price': price,
      };

  @override
  List<Object> get props => [userID, title, subtitle, time, amount, picture];
}
