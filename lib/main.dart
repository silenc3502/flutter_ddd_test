import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'board/board_module.dart';
import 'home/home_module.dart';
import 'home/presentation/ui/home_page.dart';
import 'kakao_authentication/domain/usecases/fetch_user_info_usecase_impl.dart';
import 'kakao_authentication/domain/usecases/login_usecase_impl.dart';
import 'kakao_authentication/domain/usecases/logout_usecase_impl.dart';
import 'kakao_authentication/domain/usecases/request_user_token_usecase_impl.dart';
import 'kakao_authentication/infrastructure/data_sources/kakao_auth_remote_data_source.dart';
import 'kakao_authentication/infrastructure/repository/kakao_auth_repository.dart';
import 'kakao_authentication/infrastructure/repository/kakao_auth_repository_impl.dart';
import 'kakao_authentication/presentation/providers/kakao_auth_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // .env 파일 로드
  await dotenv.load();

  String kakaoNativeAppKey = dotenv.env['KAKAO_NATIVE_APP_KEY'] ?? '';
  String kakaoJavaScriptAppKey = dotenv.env['KAKAO_JAVASCRIPT_APP_KEY'] ?? '';
  String baseUrl = dotenv.env['BASE_URL'] ?? '';

  KakaoSdk.init(
    nativeAppKey: kakaoNativeAppKey,
    javaScriptAppKey: kakaoJavaScriptAppKey,
  );

  runApp(MyApp(baseUrl: baseUrl));
}

class MyApp extends StatelessWidget {
  final String baseUrl;

  MyApp({required this.baseUrl});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provide KakaoAuthRemoteDataSource with the baseUrl
        Provider<KakaoAuthRemoteDataSource>(
          create: (_) => KakaoAuthRemoteDataSource(baseUrl),
        ),

        // Provide the concrete implementation of KakaoAuthRepository with remoteDataSource
        ProxyProvider<KakaoAuthRemoteDataSource, KakaoAuthRepository>(
          update: (_, remoteDataSource, __) =>
              KakaoAuthRepositoryImpl(remoteDataSource),
        ),

        // Then provide use cases that depend on the repositories
        ProxyProvider<KakaoAuthRepository, LoginUseCaseImpl>(
          update: (_, repository, __) => LoginUseCaseImpl(repository),
        ),
        ProxyProvider<KakaoAuthRepository, LogoutUseCaseImpl>(
          update: (_, repository, __) => LogoutUseCaseImpl(repository),
        ),
        ProxyProvider<KakaoAuthRepository, FetchUserInfoUseCaseImpl>(
          update: (_, repository, __) => FetchUserInfoUseCaseImpl(repository),
        ),
        ProxyProvider<KakaoAuthRepository, RequestUserTokenUseCaseImpl>(
          update: (_, repository, __) =>
              RequestUserTokenUseCaseImpl(repository),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter App',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: HomeModule.provideHomePage(),
      ),
    );
  }
}
