class User{
  late final int id;
  late final String username;
  late final  email;

  User({required this.id , required this.username , required this.email});

  factory User.fromJson(Map<String,dynamic> json)
  {
    return User(id: json['id'], username: json['username'], email: json['email']);
  }
}