import 'package:movies_app/movies/domain/entities/user.dart';

class UserModel extends User {
  const UserModel(
      {required super.name,
      required super.email,
      required super.id,
      required super.phone,
      required super.picture
      });

  factory UserModel.fromjson(Map<String, dynamic> json) => UserModel(
        name: json['name'],
        email: json['email'],
        id: json['id'],
        phone: json['phone'],
        picture: json['picture'],
      );
  toMap() {
    return {
      'name':name,
      'email':email,
      'id':id,
      'phone':phone,
      'picture':picture
    };
  }
}
