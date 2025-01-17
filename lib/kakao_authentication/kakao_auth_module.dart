import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data_sources/kakao_auth_remote_data_source.dart';
import 'domain/repositories/kakao_auth_repository.dart';
import 'domain/usecases/login_usecase.dart';
import 'domain/usecases/logout_usecase.dart';
import 'domain/usecases/fetch_user_info_usecase.dart';
import 'infrastructure/data_sources/kakao_auth_remote_data_source.dart';
import 'presentation/providers/kakao_auth_provider.dart';
import 'presentation/ui/kakao_login_page.dart';

class KakaoAuthModule {
  static Widget provideKakaoLoginPage() {
    return MultiProvider(
      providers: [
        Provider<KakaoAuthRemoteDataSource>(
          create: (_) => KakaoAuthRemoteDataSource(),
        ),
        ProxyProvider<KakaoAuthRemoteDataSource, KakaoAuthRepository>(
          update: (_, remoteDataSource, __) =>
              KakaoAuthRepository(remoteDataSource),
        ),
        ProxyProvider<KakaoAuthRepository, LoginUseCase>(
          update: (_, repository, __) => LoginUseCase(repository),
        ),
        ProxyProvider<KakaoAuthRepository, LogoutUseCase>(
          update: (_, repository, __) => LogoutUseCase(repository),
        ),
        ProxyProvider<KakaoAuthRepository, FetchUserInfoUseCase>(
          update: (_, repository, __) => FetchUserInfoUseCase(repository),
        ),
        ChangeNotifierProvider<KakaoAuthProvider>(
          create: (context) => KakaoAuthProvider(
            loginUseCase: context.read<LoginUseCase>(),
            logoutUseCase: context.read<LogoutUseCase>(),
            fetchUserInfoUseCase: context.read<FetchUserInfoUseCase>(),
          ),
        ),
      ],
      child: KakaoLoginPage(),
    );
  }
}
