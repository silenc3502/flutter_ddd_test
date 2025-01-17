import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import '../data_sources/kakao_auth_remote_data_source.dart';
import 'kakao_auth_repository.dart';

class KakaoAuthRepositoryImpl implements KakaoAuthRepository {
  final KakaoAuthRemoteDataSource remoteDataSource;

  KakaoAuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<String> login(String authorizationCode) async {
    return await remoteDataSource.loginWithKakao(authorizationCode);
  }
}
