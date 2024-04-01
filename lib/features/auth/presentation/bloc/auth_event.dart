part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}
final class AuthSignUpWithEmailAndPassword extends AuthEvent {
  final String email;
  final String password;
  final String name;

  AuthSignUpWithEmailAndPassword({
    required this.email,
    required this.password,
    required this.name,
  });
}
