import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import '../../infrastructure/data_sources/kakao_auth_remote_data_source.dart';

class KakaoAuthProvider extends ChangeNotifier {
  final KakaoAuthRemoteDataSource kakaoAuthRemoteDataSource;

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  KakaoAuthProvider({required this.kakaoAuthRemoteDataSource});

  // 카카오 로그인 메서드
  Future<void> loginWithKakao() async {
    try {
      final userId = await kakaoAuthRemoteDataSource.loginWithKakao('');
      print('로그인 성공, 사용자 ID: $userId');
      _isLoggedIn = true;
      notifyListeners();
    } catch (error) {
      print('로그인 실패: $error');
      throw Exception('Failed to login with Kakao');
    }
  }

  // 카카오 로그아웃 메서드
  Future<void> logoutFromKakao() async {
    try {
      await kakaoAuthRemoteDataSource.logoutFromKakao('');
      print('로그아웃 성공');
      _isLoggedIn = false;
      notifyListeners();
    } catch (error) {
      print('로그아웃 실패: $error');
      throw Exception('Failed to logout from Kakao');
    }
  }

  // 사용자 정보 가져오기 (예: 사용자 닉네임)
  Future<String> fetchUserInfo() async {
    try {
      final user = await UserApi.instance.me();
      final nickname = user.kakaoAccount?.profile?.nickname ?? 'Unknown';
      print('사용자 정보: $nickname');
      return nickname;
    } catch (error) {
      print('사용자 정보 가져오기 실패: $error');
      throw Exception('Failed to fetch user info');
    }
  }
}
