import 'package:flutter_tdd_clean_architecture/core/error/exceptions.dart';
import 'package:flutter_tdd_clean_architecture/core/error/failures.dart';

import 'package:fpdart/src/either.dart';

import '../../domain/repositoriy/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failures, String>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await remoteDataSource.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(response);
    } on Exception {
      return Left(Failures('An error occurred'));
    }
  }

  @override
  Future<Either<Failures, String>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async{
    try {
      final response = await remoteDataSource.signUpWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
      );
      return Right(response);
    } on ServerException catch (e){
      return Left(Failures('An error occurred'));
    }
  }
}
