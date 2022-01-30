part of 'models.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String name;
  final String profilePicture;
  final List<String> selectedGenres;
  final String selectedLanguage;
  final int balance;

  User(
    this.id,
    this.email, {
    this.name,
    this.profilePicture,
    this.balance,
    this.selectedGenres,
    this.selectedLanguage,
  });

  User copyWith({String name, String profilePicture, int balance}) =>
      User(this.id, this.email,
          name: name ?? this.name,
          profilePicture: profilePicture ?? this.profilePicture,
          balance: balance ?? this.balance,
          selectedGenres: selectedGenres,
          selectedLanguage: selectedLanguage);

  @override
  String toString() {
    return "[$id] - $name, $email";
  }

  factory User.fromJson(String id, Map<String, dynamic> json) => User(
        id,
        json['email'],
        name: json['name'],
        profilePicture: json['profilePicture'],
        balance: json['balance'],
        selectedGenres:
            (json['selectedGenres'] as List).map((e) => e.toString()).toList(),
        selectedLanguage: json['selectedLanguage'],
      );
  // User(
  //   email: json['email'],
  //   balance: json['balance'],
  // profilePicture: json['profilePicture'],
  // selectedGenres: (json['selectedGenres'] as List)
  //   .map((e) => e.toString())
  //   .toList(),
  //   selectedLanguage: json['selectedLanguage'],
  //   name: json['name']
  // );

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'name': name,
        'profilePicture': profilePicture,
        'balance': balance,
        'selectedGenres': selectedGenres,
        'selectedLanguage': selectedLanguage,
      };
  @override
  // TODO: implement props
  List<Object> get props => [
        id,
        email,
        name,
        profilePicture,
        selectedGenres,
        selectedLanguage,
        balance
      ];
}
