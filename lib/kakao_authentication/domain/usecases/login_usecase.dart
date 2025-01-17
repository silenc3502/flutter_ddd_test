import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

abstract class LoginUseCase {
  Future<OAuthToken> execute(String authorizationCode);
}
