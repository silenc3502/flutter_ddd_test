import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class KakaoAuthRemoteDataSource {
  // 카카오 로그인 메서드 (카카오톡 또는 카카오계정 로그인)
  Future<String> loginWithKakao(String authorizationCode) async {
    try {
      if (await isKakaoTalkInstalled()) {
        // 카카오톡으로 로그인
        await UserApi.instance.loginWithKakaoTalk();
        print('카카오톡으로 로그인 성공');
      } else {
        // 카카오계정으로 로그인
        await UserApi.instance.loginWithKakaoAccount();
        print('카카오계정으로 로그인 성공');
      }

      // 로그인 성공 후 사용자 정보 가져오기
      final user = await UserApi.instance.me();
      print('사용자 정보: ${user.id}, ${user.kakaoAccount?.profile?.nickname}');

      // 사용자 ID 반환
      return user.id.toString();
    } catch (error) {
      print('로그인 실패: $error');
      throw Exception('Failed to login with Kakao');
    }
  }

  // 카카오 로그아웃 메서드
  Future<void> logoutFromKakao(String accessToken) async {
    try {
      // 카카오톡 로그아웃
      await UserApi.instance.logout();
      print('카카오톡에서 로그아웃 성공');
    } catch (error) {
      print('로그아웃 실패: $error');
      throw Exception('Failed to logout from Kakao');
    }
  }
}
