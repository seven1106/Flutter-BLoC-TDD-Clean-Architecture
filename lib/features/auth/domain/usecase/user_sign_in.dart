import 'package:flutter_tdd_clean_architecture/core/error/failures.dart';
import 'package:flutter_tdd_clean_architecture/core/usecase/usecase.dart';
import 'package:flutter_tdd_clean_architecture/core/common/entities/user_entity.dart';
import 'package:fpdart/fpdart.dart';

import '../repositories/auth_repository.dart';
class UserSignInUseCase implements UseCase<UserEntity, UserSignInParams> {
  final AuthRepository repository;
  const UserSignInUseCase(this.repository);
  @override
  Future<Either<Failure, UserEntity>> call(UserSignInParams params) async{
    return await repository.signInWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }

}
class UserSignInParams {
  final String email;
  final String password;

  UserSignInParams({
    required this.email,
    required this.password,
  });

}