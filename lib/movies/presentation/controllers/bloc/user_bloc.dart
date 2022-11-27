import 'dart:async';
 
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/usecase/base_usecase.dart';
import 'package:movies_app/core/utils/enums.dart';
import 'package:movies_app/main.dart';
import 'package:movies_app/movies/domain/entities/user.dart';
import 'package:movies_app/movies/domain/usecase/user/get_user_usecase.dart';
import 'package:movies_app/movies/domain/usecase/user/login_usecase.dart';
import 'package:movies_app/movies/domain/usecase/user/signin_anonymous_usecase.dart';
import 'package:movies_app/movies/domain/usecase/user/google_signin_usecase.dart';
import 'package:movies_app/movies/domain/usecase/user/signout_usecase.dart';
import 'package:movies_app/movies/presentation/screens/auth/login/login.dart';

import '../../../domain/usecase/user/facebook_signin_usecase.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserBlocEvent, UserBlocState> {
  final GetUserUsecase getUserUsecase;
  final GetGoogleSigninUsecase googleSigninUsecase;
  final GetFacebookSigninUsecase facebookSigninUsecase;
  final GetSignUpAnonymousUsecase signUpAnonymousUsecase;
  final GetLoginUsecase loginUsecase;
  final GetSignOutUseCase signOutUseCase;
  UserBloc(
    this.getUserUsecase,
    this.googleSigninUsecase,
    this.signUpAnonymousUsecase,
    this.loginUsecase,
    this.facebookSigninUsecase,
    this.signOutUseCase,
  ) : super(const UserBlocState()) {
    on<GetUserEvent>(_getUserData);
    on<GoogleSignInUserEvent>(_googleSignin);
    on<FacebookSignInUserEvent>(_facebookSignin);
    on<SignUpAnonymousEvent>(_signUpAnonymous);
    on<LoginEvent>(_login);
    on<SignOutEvent>(_signOut);
  }
  bool loading = false;

  FutureOr<void> _getUserData(
      GetUserEvent event, Emitter<UserBlocState> emit) async {
    if (auth.FirebaseAuth.instance.currentUser != null) {
      String uid = auth.FirebaseAuth.instance.currentUser!.uid;
      final result = await getUserUsecase(
          UserParameters(userId: uid, context: event.context));
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

  FutureOr<void> _googleSignin(
      GoogleSignInUserEvent event, Emitter<UserBlocState> emit) async {
    final result = await googleSigninUsecase(const NoParameters());
    result.fold(
      (l) => emit(
        state.copyWith(
          userDataState: RequestState.error,
          userDataMessage: l.message,
        ),
      ),
      (r) {
        emit(
          state.copyWith(
            userDataState: RequestState.loaded,
            userData: r,
          ),
        );

        if (state.userData != null) {
          Navigator.pushReplacement(
              event.context, MaterialPageRoute(builder: (_) => const MyApp()));
        }
      },
    );
  }

  FutureOr<void> _facebookSignin(
      FacebookSignInUserEvent event, Emitter<UserBlocState> emit) async {
    final result = await facebookSigninUsecase(const NoParameters());
    result.fold(
      (l) => emit(
        state.copyWith(
          userDataState: RequestState.error,
          userDataMessage: l.message,
        ),
      ),
      (r) {
        emit(
          state.copyWith(
            userDataState: RequestState.loaded,
            userData: r,
          ),
        );
        if (state.userData != null) {
          Navigator.pushReplacement(
              event.context, MaterialPageRoute(builder: (_) => const MyApp()));
        }
      },
    );
  }

  FutureOr<void> _signUpAnonymous(
      SignUpAnonymousEvent event, Emitter<UserBlocState> emit) async {
    final result = await signUpAnonymousUsecase(UserParameters(
        email: event.email,
        name: event.name,
        password: event.password,
        phone: event.phone,
        context: event.context));

    result.fold(
      (l) => emit(
        state.copyWith(
          userDataState: RequestState.error,
          userDataMessage: l.message,
        ),
      ),
      (r) {
        emit(
          state.copyWith(
            userDataState: RequestState.loaded,
            userData: r,
          ),
        );
        if (state.userData != null) {
          Navigator.pushReplacement(
              event.context, MaterialPageRoute(builder: (_) => const MyApp()));
        }
      },
    );
  }

  FutureOr<void> _login(LoginEvent event, Emitter<UserBlocState> emit) async {
    emit(
      state.copyWith(
        userDataState: RequestState.loaded,
      ),
    );
    final result = await loginUsecase(UserParameters(
        email: event.email, password: event.password, context: event.context));
    result.fold(
      (l) => emit(
        state.copyWith(
          userDataState: RequestState.error,
          userDataMessage: l.message,
        ),
      ),
      (r) {
        emit(
          state.copyWith(
            userDataState: RequestState.loaded,
            userData: r,
          ),
        );
        if (state.userData != null) {
          Navigator.pushReplacement(
              event.context, MaterialPageRoute(builder: (_) => const MyApp()));
        }
      },
    );
  }

  Future<void> _signOut(SignOutEvent event, Emitter<UserBlocState> emit) async {
    final result = await signOutUseCase(const NoParameters());
    result.fold(
      (l) => emit(
        state.copyWith(
          userDataState: RequestState.error,
          userDataMessage: l.message,
        ),
      ),
      (r) {
        emit(
          state.copyWith(
            userDataState: RequestState.loading,
            userData: null,
          ),
        );
        Navigator.pushReplacement(event.context,
            MaterialPageRoute(builder: (_) => const LoginScreen()));
      },
    );
  }
}
