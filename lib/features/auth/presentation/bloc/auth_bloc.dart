import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tdd_clean_architecture/core/common/entities/user_entity.dart';

import '../../../../core/common/cubits/app_user/app_user_cubit.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/usecase/current_user.dart';
import '../../domain/usecase/user_sign_in.dart';
import '../../domain/usecase/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUpUseCase _userSignUp;
  final UserSignInUseCase _userSignIn;
  final CurrentUserUseCase _currentUser;
  final AppUserCubit _appUserCubit;
  AuthBloc({
    required UserSignUpUseCase userSignUp,
    required UserSignInUseCase userSignIn,
    required CurrentUserUseCase currentUser,
    required AppUserCubit appUserCubit,
  })  : _userSignUp = userSignUp,
        _userSignIn = userSignIn,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthSignUpWithEmailAndPassword>(
      _onAuthSignUpWithEmailAndPassword,
    );
    on<AuthSignInWithEmailAndPassword>(
      _onAuthSignInWithEmailAndPassword,
    );
    on<AuthGetCurrentUser>(
      _isUserLoggedIn,
    );
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
  }
  void _onAuthSignUpWithEmailAndPassword(
    AuthSignUpWithEmailAndPassword event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _userSignUp(
      UserSignUpParams(
        email: event.email,
        password: event.password,
        name: event.name,
      ),
    );
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) {
        _emitAuthSuccess(user, emit);
      },
    );
  }

  void _onAuthSignInWithEmailAndPassword(
    AuthSignInWithEmailAndPassword event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _userSignIn(
      UserSignInParams(
        email: event.email,
        password: event.password,
      ),
    );
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) {
        _emitAuthSuccess(user, emit);
      },
    );
  }

  void _isUserLoggedIn(
    AuthGetCurrentUser event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await _currentUser(NoParams());
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) {
        _emitAuthSuccess(user, emit);
      },
    );
  }

  void _emitAuthSuccess(UserEntity user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
