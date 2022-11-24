part of 'user_bloc.dart';

abstract class UserBlocEvent extends Equatable {
  const UserBlocEvent();
  @override
  List<Object> get props => [];
}

class GetUserEvent extends UserBlocEvent {
  //final String id;
  final BuildContext context;
  const GetUserEvent({required this.context}
      //this.id,
      );
  @override
  List<Object> get props => [];
}

class GoogleSignInUserEvent extends UserBlocEvent {
  final BuildContext context;
  const GoogleSignInUserEvent(this.context);
  @override
  List<Object> get props => [context];
}

class FacebookSignInUserEvent extends UserBlocEvent {
  final BuildContext context;

  const FacebookSignInUserEvent(this.context);
  @override
  List<Object> get props => [context];
}

class AppleSignInUserEvent extends UserBlocEvent {
  final BuildContext context;

  const AppleSignInUserEvent(this.context);
  @override
  List<Object> get props => [];
}

class TwitterSignInUserEvent extends UserBlocEvent {
  final BuildContext context;

  const TwitterSignInUserEvent(this.context);
  @override
  List<Object> get props => [];
}

class SignUpAnonymousEvent extends UserBlocEvent {
  final String email;
  final String password;
  final String phone;
  final String name;
  final BuildContext context;

  const SignUpAnonymousEvent(
      this.email, this.password, this.phone, this.name, this.context);
  @override
  List<Object> get props => [email, password, phone, name, context];
}

class LoginEvent extends UserBlocEvent {
  final String email;
  final String password;
  final BuildContext context;
  const LoginEvent(this.email, this.password, this.context);
  @override
  List<Object> get props => [email, password, context];
}

class SignOutEvent extends UserBlocEvent {
  final BuildContext context;
  const SignOutEvent(this.context);
  @override
  List<Object> get props => [context];
}
