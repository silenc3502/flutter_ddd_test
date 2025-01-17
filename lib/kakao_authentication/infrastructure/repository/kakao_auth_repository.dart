abstract class KakaoAuthRepository {
  Future<String> login(String authorizationCode);
  // Future<void> logout();
  // Future<User> fetchUserInfo();
}
