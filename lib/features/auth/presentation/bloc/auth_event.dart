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
final class AuthSignInWithEmailAndPassword extends AuthEvent {
  final String email;
  final String password;

  AuthSignInWithEmailAndPassword({
    required this.email,
    required this.password,
  });
}
final class AuthGetCurrentUser extends AuthEvent {}
