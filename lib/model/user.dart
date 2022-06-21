class User {
  final String email;
  final String uid;
  final String username;


  User(
      {required this.email,
      required this.uid,
      required this.username,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'email': email,
      };
}
