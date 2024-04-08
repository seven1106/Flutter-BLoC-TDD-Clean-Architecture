import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class CurrentUserUseCase implements UseCase<UserEntity, NoParams> {
  final AuthRepository repository;
  const CurrentUserUseCase(this.repository);
  @override
  Future<Either<Failures, UserEntity>> call(NoParams params) async{
    return await repository.getCurrentUser();
  }
}