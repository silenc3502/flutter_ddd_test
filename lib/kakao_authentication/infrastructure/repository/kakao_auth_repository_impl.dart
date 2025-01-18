import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

import '../data_sources/kakao_auth_remote_data_source.dart';
import 'kakao_auth_repository.dart';

class KakaoAuthRepositoryImpl implements KakaoAuthRepository {
  final KakaoAuthRemoteDataSource remoteDataSource;

  KakaoAuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<String> login() async {
    return await remoteDataSource.loginWithKakao();
  }

  @override
  Future<void> logout() async {
    await remoteDataSource.logoutFromKakao();
  }

  @override
  Future<User> fetchUserInfo() async {
    return await remoteDataSource.fetchUserInfoFromKakao();
  }

  @override
  Future<String> requestUserToken(
      String accessToken, String email, String nickname) async {
    print(
        "Requesting user token with accessToken: $accessToken, email: $email, nickname: $nickname");
    try {
      final userToken = await remoteDataSource.requestUserTokenFromServer(
          accessToken, email, nickname);
      print("User token obtained: $userToken");
      return userToken;
    } catch (e) {
      print("Error during requesting user token: $e");
      throw Exception("Failed to request user token: $e");
    }
  }
}
