import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final String email;
  final String id;
  final String phone;

  const User({required this.name,required  this.email,required  this.id,required  this.phone});
  
  @override
  List<Object?> get props => [name,email,id,phone];


}
