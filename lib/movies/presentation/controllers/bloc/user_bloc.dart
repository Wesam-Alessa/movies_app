import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/usecase/base_usecase.dart';
import 'package:movies_app/core/utils/enums.dart';
import 'package:movies_app/movies/domain/entities/user.dart';
import 'package:movies_app/movies/domain/usecase/user/get_user_usecase.dart';
import 'package:movies_app/movies/domain/usecase/user/social_signin_usecase.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserBlocEvent, UserBlocState> {
  final GetUserUsecase getUserUsecase;
  final GetSocialSigninUsecase socialSigninUsecase;

  UserBloc(this.getUserUsecase,this.socialSigninUsecase) : super(const UserBlocState()) {
    on<GetUserEvent>(_getUserData);
    on<SignInUserEvent>(_socialSignin);
  }

  FutureOr<void> _getUserData(
      GetUserEvent event, Emitter<UserBlocState> emit) async {
    final result = await getUserUsecase(UserParameters(event.userId));
    result.fold(
      (l) => emit(
        state.copyWith(
          userDataState: RequestState.error,
          userDataMessage: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          userDataState: RequestState.loaded,
          userData: r,
        ),
      ),
    );
  }

  FutureOr<void> _socialSignin(
      SignInUserEvent event, Emitter<UserBlocState> emit) async {
    final result = await socialSigninUsecase(const NoParameters());
    result.fold(
      (l) => emit(
        state.copyWith(
          userDataState: RequestState.error,
          userDataMessage: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          userDataState: RequestState.loaded,
          userData: r,
        ),
      ),
    );
  }
}
