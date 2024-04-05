import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tdd_clean_architecture/features/auth/data/models/user_model.dart';
import 'package:flutter_tdd_clean_architecture/features/auth/domain/entities/user_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/usecase/user_sign_in.dart';
import '../../domain/usecase/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  AuthBloc({
    required UserSignUp userSignUp,
    required UserSignIn userSignIn,
  })  : _userSignUp = userSignUp,
        _userSignIn = userSignIn,
        super(AuthInitial()) {
    on<AuthSignUpWithEmailAndPassword>(
      _onAuthSignUpWithEmailAndPassword,
    );
    on<AuthSignInWithEmailAndPassword>(
      _onAuthSignInWithEmailAndPassword,
    );
  }
  void _onAuthSignUpWithEmailAndPassword(
    AuthSignUpWithEmailAndPassword event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await _userSignUp(
      UserSignUpParams(
        email: event.email,
        password: event.password,
        name: event.name,
      ),
    );
    result.fold(
            (failure) => emit(AuthFailure(failure.message)),
            (user) => emit(AuthSuccess(user)),
    );
  }
  void _onAuthSignInWithEmailAndPassword(
    AuthSignInWithEmailAndPassword event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await _userSignIn(
      UserSignInParams(
        email: event.email,
        password: event.password,
      ),
    );
    result.fold(
            (failure) => emit(AuthFailure(failure.message)),
            (user) => emit(AuthSuccess(user)),
    );
  }
}
