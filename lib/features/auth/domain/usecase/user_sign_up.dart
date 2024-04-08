import 'package:flutter_tdd_clean_architecture/core/error/failures.dart';
import 'package:flutter_tdd_clean_architecture/core/usecase/usecase.dart';
import 'package:flutter_tdd_clean_architecture/features/auth/domain/entities/user_entity.dart';
import 'package:fpdart/fpdart.dart';

import '../repositories/auth_repository.dart';

class UserSignUpUseCase implements UseCase<UserEntity, UserSignUpParams> {
  final AuthRepository repository;
  const UserSignUpUseCase(this.repository);
  @override
  Future<Either<Failures, UserEntity>> call(UserSignUpParams params) async{
    return await repository.signUpWithEmailAndPassword(
      email: params.email,
      password: params.password,
      name: params.name,
    );
  }

}
class UserSignUpParams {
  final String email;
  final String password;
  final String name;

  UserSignUpParams({
    required this.email,
    required this.password,
    required this.name,
  });
}