class User {
  final String? userId;
  final String? name;
  final int? age;
  final String? sport;

  User({
    required this.userId,
    required this.name,
    required this.age,
    required this.sport,
  });

  factory User.fromJson(Map<String, dynamic> data) {
    return User(
      userId: data['id'],
      name: data['name'],
      age: int.parse(data['age']),
      sport: data['sport'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': userId,
      'name': name,
      'age': age,
      'sport': sport,
    };
  }
}
