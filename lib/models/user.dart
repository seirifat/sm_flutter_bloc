class User {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  User({this.id, this.email, this.firstName, this.lastName, this.avatar});

  factory User.createUser(Map<String, dynamic> object) {
    return User(
        id: object['id'],
        email: object['email'],
        firstName: object['first_name'],
        lastName: object['last_name'],
        avatar: object['avatar']);
  }
}
