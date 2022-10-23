import 'package:equatable/equatable.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_app/core/usecase/base_usecase.dart';
import 'package:movies_app/movies/domain/entities/user.dart';
import 'package:movies_app/movies/domain/repository/base_user_repository.dart';

class GetUserUsecase extends BaseUseCase<User, UserParameters> {
  final BaseUserRepository baseUserRepository;

  GetUserUsecase(this.baseUserRepository);

  @override
  Future<Either<Failure, User>> call(UserParameters parameters)async {
    return await baseUserRepository.getUser(parameters);
  }
  
}


class UserParameters extends Equatable {
  final String userId;

  const UserParameters(this.userId);
  
  @override
  List<Object?> get props => [userId];
}