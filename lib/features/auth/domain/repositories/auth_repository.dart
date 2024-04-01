import 'package:flutter_tdd_clean_architecture/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

 abstract interface class AuthRepository {
  Future<Either<Failures, String>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  });
  Future<Either<Failures, String>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
}
