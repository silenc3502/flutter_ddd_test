import 'package:flutter/foundation.dart';

import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

import '../../domain/usecases/login_usecase.dart';

class KakaoAuthProvider extends ChangeNotifier {
  final LoginUseCase loginUseCase;
  // final LogoutUseCase logoutUseCase;
  // final FetchUserInfoUseCase fetchUserInfoUseCase;

  bool _isLoggedIn = false;
  User? _user;

  bool get isLoggedIn => _isLoggedIn;
  User? get user => _user;

  KakaoAuthProvider({
    required this.loginUseCase,
    // required this.logoutUseCase,
    // required this.fetchUserInfoUseCase,
  });

  Future<void> login() async {
    try {
      await loginUseCase.execute();
      _isLoggedIn = true;
      // _user = await fetchUserInfoUseCase.execute();
      notifyListeners();
    } catch (e) {
      _isLoggedIn = false;
      _user = null;
      throw Exception("Login failed: $e");
    }
  }

  // Future<void> logout() async {
  //   try {
  //     await logoutUseCase.execute();
  //     _isLoggedIn = false;
  //     _user = null;
  //     notifyListeners();
  //   } catch (e) {
  //     throw Exception("Logout failed: $e");
  //   }
  // }
}
