import 'package:dartz/dartz.dart';
import 'package:movies_app/movies/domain/repository/base_user_repository.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../entities/user.dart';

class GetFacebookSigninUsecase extends BaseUseCase<User, NoParameters> {
  final BaseUserRepository baseUserRepository;

  GetFacebookSigninUsecase(this.baseUserRepository);

  @override
  Future<Either<Failure, User>> call(NoParameters parameters) async {
    return await baseUserRepository.facebookSignin();
  }
}
