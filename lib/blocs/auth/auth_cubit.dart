import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthCubit() : super(AuthInitial()) {
    _checkUser();
  }

  void _checkUser() {
    final user = _auth.currentUser;
    if (user != null) {
      emit(Authenticated(user.uid, user.email ?? ''));
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final userCred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      emit(Authenticated(userCred.user!.uid, userCred.user!.email ?? ''));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> register(String email, String password) async {
    emit(AuthLoading());
    try {
      final userCred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      emit(Authenticated(userCred.user!.uid, userCred.user!.email ?? ''));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    emit(Unauthenticated());
  }
}
