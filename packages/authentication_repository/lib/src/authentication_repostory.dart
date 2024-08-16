import 'dart:async';

import 'package:authentication_repository/src/local_db/local_db.dart';

import 'models/models.dart';
import 'services/authentication_service.dart';

enum AuthenticationStatus {
  initial,
  authenticated,
  unauthenticated,
  error,
  loading;
}

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  final _authController = StreamController<Auth>();
  final AuthenticationService _authenticationService;

  AuthenticationRepository({
    required AuthenticationService authenticationService,
  }) : _authenticationService = authenticationService;

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    // api 'dan ma'lumot kelishi kerak
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Stream<Auth> get auth async* {
    yield* _authController.stream;
  }

  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    final auth = await _authenticationService.login(email, password);
    _authController.add(auth);
    _controller.add(AuthenticationStatus.authenticated);
    LocalDb.saveToken(auth.idToken);
  }

  Future<Auth> register({
    required String email,
    required String password,
  }) async {
    final auth = await _authenticationService.register(email, password);
    _authController.add(auth);
    _controller.add(AuthenticationStatus.authenticated);

    LocalDb.saveToken(auth.idToken);
    return auth;
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
    LocalDb.deleteToken();
  }

  Future<Auth?> getAuthUser() async {
    final response = await _authenticationService.getUserInfo();
    if (response != null) {
      return Auth.fromList(response["users"], await LocalDb.getIdToken());
    }
    return null;
  }

  void dispose() => _controller.close();
}
