import 'package:movies_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_app/core/usecase/base_usecase.dart';
import 'package:movies_app/movies/domain/entities/user.dart';
import 'package:movies_app/movies/domain/repository/base_user_repository.dart';
import 'package:movies_app/movies/domain/usecase/user/get_user_usecase.dart';

class GetSignInAnonymousUsecase extends BaseUseCase<User, UserParameters> {
  final BaseUserRepository baseUserRepository;

  GetSignInAnonymousUsecase(this.baseUserRepository);

  @override
  Future<Either<Failure, User>> call(UserParameters parameters) async {
    return await baseUserRepository.signInAnonymous(parameters);
  }
}
