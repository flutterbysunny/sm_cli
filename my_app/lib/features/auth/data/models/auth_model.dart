class AuthModel {
  final int id;
  final String name;

  const AuthModel({
    required this.id,
    required this.name,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  String toString() => 'AuthModel(id: $id, name: $name)';
}
