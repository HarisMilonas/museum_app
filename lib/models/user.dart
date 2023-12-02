



class User {
  int? id;
  String email;
  String password;
  String username;
  String name;

  User({
    this.id,
    required this.email,
    required this.password,
    required this.username,
    required this.name,
  });
  // Convert Exhibit object to a map
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'username': username,
      'name': name,
    };
  }

  // Create an Exhibit object from a map
  factory User.fromMap(Map<String, dynamic> map) => User(
        id: map['id'],
        email: map['email'],
        password: map['password'],
        username: map['username'],
        name: map['name'],
      );
}
