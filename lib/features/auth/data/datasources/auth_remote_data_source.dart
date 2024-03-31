import 'package:flutter_tdd_clean_architecture/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  });
  Future<String> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
}
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImpl({required this.supabaseClient});
  @override
  Future<String> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(email:email,  password: password, data: {'name': name});
      if (response.user == null) {
        throw const ServerException('An error occurred');
      }
      return response.user!.id;
    } catch (e) {
      throw const ServerException('An error occurred');
    }
  }

  @override
  Future<String> signInWithEmailAndPassword({required String email, required String password}) {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }

}