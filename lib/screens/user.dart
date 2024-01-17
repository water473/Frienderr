class User {
  final int? id;
  final String name;
  final String username;
  final String password;
  final String interests;
  final String imagePath;
  final String age;
  final String school;

  User(
      {this.id,
      required this.name,
      required this.username,
      required this.password,
      required this.interests,
      required this.imagePath,
      required this.age,
      required this.school});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'password': password,
      'interests': interests,
      'imagePath': imagePath,
      'age': age,
      'school': school
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      username: map['username'],
      password: map['password'],
      interests: map['interests'],
      imagePath: map['imagePath'],
      age: map['age'],
      school: map['school'],
    );
  }
}
