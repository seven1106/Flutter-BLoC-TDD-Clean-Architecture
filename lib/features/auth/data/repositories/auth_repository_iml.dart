import 'package:flutter_tdd_clean_architecture/core/error/exceptions.dart';
import 'package:flutter_tdd_clean_architecture/core/error/failures.dart';
import 'package:flutter_tdd_clean_architecture/features/auth/domain/entities/user_entity.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failures, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
      final response = await remoteDataSource.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _getUser(() async => response);
  }

  @override
  Future<Either<Failures, UserEntity>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async{
      final response = await remoteDataSource.signUpWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
      );
      return _getUser(() async => response);

  }
  Future<Either<Failures, UserEntity>> _getUser(
      Future<UserEntity> Function() fn,
      ) async {
    try {
      final response = await fn();
      return Right(response);
    } on ServerException catch (e) {
      return Left(Failures(e.message));
    } on supabase.AuthException catch (e) {
      return Left(Failures(e.message));
    }
  }

  @override
  Future<Either<Failures, UserEntity>> getCurrentUser() async{
    try {
      final response = await remoteDataSource.getCurrentUser();
      if (response != null) {
        return Right(response);
      } else {
        return Left(Failures('User not found'));
      }
    } on ServerException catch (e) {
      return Left(Failures(e.message));
    } on supabase.AuthException catch (e) {
      return Left(Failures(e.message));
    }
  }
}

