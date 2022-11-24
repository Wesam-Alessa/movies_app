import 'package:movies_app/core/error/exceptions.dart';
import 'package:movies_app/movies/data/datasource/user_remote_data_source.dart';
import 'package:movies_app/movies/domain/entities/user.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_app/movies/domain/repository/base_user_repository.dart';
import 'package:movies_app/movies/domain/usecase/user/get_user_usecase.dart';

class UserRepository extends BaseUserRepository {
  final BaseUserRemoteDataSource baseUserRemoteDataSource;

  UserRepository(this.baseUserRemoteDataSource);

  @override
  Future<Either<Failure, User>> getUser(UserParameters parameters) async {
    final result = await baseUserRemoteDataSource.getUser(parameters);
    try {
      return Right(result!);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, User>> googleSignin() async {
    final result = await baseUserRemoteDataSource.signInWithGoogle();
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, User>> facebookSignin() async {
    final result = await baseUserRemoteDataSource.signInWithFacebook();
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, User>> signUpAnonymous(
      UserParameters parameters) async {
    final result = await baseUserRemoteDataSource.signUpAnonymous(parameters);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, User>> login(UserParameters parameters) async {
    try {
       final result = await baseUserRemoteDataSource.logIn(parameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
  
  @override
  Future<Either<Failure, User>> signOut()async {
    final result = await baseUserRemoteDataSource.signOut();
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}
