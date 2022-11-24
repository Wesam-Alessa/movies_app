import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_app/core/usecase/base_usecase.dart';
import 'package:movies_app/movies/domain/entities/user.dart';
import 'package:movies_app/movies/domain/repository/base_user_repository.dart';

class GetUserUsecase extends BaseUseCase<User, UserParameters> {
  final BaseUserRepository baseUserRepository;

  GetUserUsecase(this.baseUserRepository);

  @override
  Future<Either<Failure, User>> call(UserParameters parameters) async {
    return await baseUserRepository.getUser(parameters);
  }
}

// ignore: must_be_immutable
class UserParameters extends Equatable {
  String userId;

  String get getUserId => userId;

  set setUserId(String userId) {
    userId = userId;
  }

  final String name;
  final String phone;
  final String email;
  final String password;
  final BuildContext context;
  UserParameters({
    this.userId = '',
    this.name = '',
    this.phone = '',
    this.email = '',
    this.password = '',
    required this.context,
  });

  @override
  List<Object?> get props => [userId, name, phone, password, email,context];
}
