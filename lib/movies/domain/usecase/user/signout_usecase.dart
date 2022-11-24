import 'package:movies_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_app/core/usecase/base_usecase.dart';
import 'package:movies_app/movies/domain/entities/user.dart';
import 'package:movies_app/movies/domain/repository/base_user_repository.dart';

class GetSignOutUseCase extends BaseUseCase<User, NoParameters> {
  final BaseUserRepository baseUserRepository;
  GetSignOutUseCase(this.baseUserRepository);
  @override
  Future<Either<Failure, User>> call(NoParameters parameters) async {
    return await baseUserRepository.signOut();
  }
}
