part of 'user_bloc.dart';

class UserBlocState extends Equatable {
  final User? userData;
  final RequestState userDataState;
  final String userDataMessage;

  const UserBlocState({
    this.userData,
    this.userDataState = RequestState.loading,
    this.userDataMessage = '',
  });
  
  @override
  List<Object?> get props => [
    userData,
    userDataState,
    userDataMessage,
  ];

  UserBlocState copyWith({
     User? userData,
     RequestState? userDataState,
    String? userDataMessage,

  }) {
    return UserBlocState(
      userData :userData ?? this.userData,
      userDataState : userDataState ?? this.userDataState,
      userDataMessage : userDataMessage ?? this.userDataMessage,
    );
  }
}

