class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String image;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'firstName': String firstName,
        'lastName': String lastName,
        'email': String email,
        'image': String image,
      } =>
        User(
          id: id,
          firstName: firstName,
          lastName: lastName,
          email: email,
          image: image,
        ),
      _ => throw const FormatException('Erro ao obter usuário!'),  
    };
  }
}