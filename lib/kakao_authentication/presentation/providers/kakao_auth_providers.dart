import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../domain/usecases/fetch_user_info_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/request_user_token_usecase.dart';

class KakaoAuthProvider with ChangeNotifier {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final FetchUserInfoUseCase fetchUserInfoUseCase;
  final RequestUserTokenUseCase requestUserTokenUseCase;

  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  String? _accessToken;
  String? _userToken;
  bool _isLoggedIn = false;
  bool _isLoading = false;
  String _message = '';

  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;
  String get message => _message;

  KakaoAuthProvider({
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.fetchUserInfoUseCase,
    required this.requestUserTokenUseCase,
  });

  Future<void> login() async {
    _isLoading = true;
    _message = '';
    notifyListeners();

    try {
      // UseCase를 호출하여 로그인 처리
      print("Calling loginUseCase.execute()");
      _accessToken = await loginUseCase.execute();
      print("AccessToken obtained: $_accessToken");

      // 카카오 accessToken을 사용해 사용자 정보를 요청
      print("Calling fetchUserInfoUseCase.execute()");
      final userInfo = await fetchUserInfoUseCase.execute();
      print("User Info fetched: $userInfo");

      final email = userInfo.kakaoAccount?.email;
      final nickname = userInfo.kakaoAccount?.profile?.nickname;

      print("User email: $email, User nickname: $nickname");

      _userToken = await requestUserTokenUseCase.execute(
          _accessToken!, email!, nickname!);

      print("User Token obtained: $_userToken");

      await _secureStorage.write(key: 'userToken', value: _userToken);

      _isLoggedIn = true;
      _message = '로그인 성공';
      print("Login successful");
    } catch (e) {
      _isLoggedIn = false;
      _message = '로그인 실패: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> logoutFromKakao() async {
    _isLoading = true;
    _message = '';
    notifyListeners();

    try {
      await logoutUseCase.execute();

      await _secureStorage.delete(key: 'userToken');

      _isLoggedIn = false;
      _accessToken = null;
      _userToken = null;
      _message = '로그아웃 성공';
    } catch (e) {
      _message = '로그아웃 실패: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> checkUserToken() async {
    // 앱 시작 시 Secure Storage에서 User Token 불러오기
    _userToken = await _secureStorage.read(key: 'userToken');

    if (_userToken != null) {
      _isLoggedIn = true;
      _message = 'User is already logged in';
      notifyListeners();
    }
  }

  Future<String> _authenticateWithServer(String accessToken) async {
    // Django 서버에 AccessToken 전달 후 User Token 반환
    return Future.delayed(
      Duration(seconds: 1),
      () => 'dummy_user_token_based_on_$accessToken',
    );
  }
}
