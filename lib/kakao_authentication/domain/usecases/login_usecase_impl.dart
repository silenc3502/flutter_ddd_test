import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

import '../../infrastructure/repository/kakao_auth_repository.dart';
import 'login_usecase.dart';

class LoginUseCaseImpl implements LoginUseCase {
  final KakaoAuthRepository repository;

  LoginUseCaseImpl(this.repository);

  @override
  Future<OAuthToken> execute(String authorizationCode) async {
    final accessToken = await repository.login(authorizationCode);

    // accessToken을 이용해 OAuthToken을 생성하는 예시
    final oauthToken = OAuthToken(
      accessToken,
      DateTime.now().add(Duration(hours: 1)), // 예시로 1시간 후 만료
      '', // refreshToken이 없을 경우 빈 문자열 또는 null
      null, // refreshTokenExpiresAt이 없을 경우 null
      ['scope1', 'scope2'], // 예시 스코프 리스트
    );

    return oauthToken;
  }
}
