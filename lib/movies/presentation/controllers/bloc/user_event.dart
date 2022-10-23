part of 'user_bloc.dart';

abstract class UserBlocEvent extends Equatable {
  const UserBlocEvent();
  @override
  List<Object> get props => [];
}

class GetUserEvent extends UserBlocEvent {
  final String userId;

  const GetUserEvent(this.userId);
  @override
  List<Object> get props => [userId];
}

class SignInUserEvent extends UserBlocEvent {
  const SignInUserEvent();
  @override
  List<Object> get props => [];
}

