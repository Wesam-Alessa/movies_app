import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/movies/domain/entities/user.dart';
import 'package:movies_app/movies/domain/usecase/user/get_user_usecase.dart';

abstract class BaseUserRepository {

  Future<Either<Failure, User>> getUser(UserParameters parameters);
  Future<Either<Failure, User>> login(UserParameters parameters);
  Future<Either<Failure, User>> signInAnonymous(UserParameters parameters);
  Future<Either<Failure, User>> socialSignin();

}