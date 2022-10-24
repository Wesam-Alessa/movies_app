part of 'user_bloc.dart';

abstract class UserBlocEvent extends Equatable {
  const UserBlocEvent();
  @override
  List<Object> get props => [];
}

class GetUserEvent extends UserBlocEvent {
  final String email;
  final String password;

  const GetUserEvent(this.email, this.password);
  @override
  List<Object> get props => [email, password];
}

class SignInUserEvent extends UserBlocEvent {
  const SignInUserEvent();
  @override
  List<Object> get props => [];
}

class SignInAnonymousEvent extends UserBlocEvent {

  final String email;
  final String password;
  final String phone;
  final String name;
  const SignInAnonymousEvent(

    this.email,
    this.password,
   this.phone,
    this.name,
  );
  @override
  List<Object> get props => [email,password,phone,name];
}

class LoginEvent extends UserBlocEvent {

  final String email;
  final String password;

  const LoginEvent(
    this.email,
    this.password,
  );
  @override
  List<Object> get props => [email,password];
}