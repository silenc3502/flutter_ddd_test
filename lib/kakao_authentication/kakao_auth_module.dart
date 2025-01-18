import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../config/base_url_provider.dart';
import 'presentation/providers/kakao_auth_providers.dart';
import 'presentation/ui/kakao_login_page.dart';
import 'infrastructure/data_sources/kakao_auth_remote_data_source.dart';
import 'infrastructure/repository/kakao_auth_repository_impl.dart';
import 'domain/usecases/login_usecase_impl.dart';
import 'domain/usecases/logout_usecase_impl.dart';
import 'domain/usecases/fetch_user_info_usecase_impl.dart';
import 'domain/usecases/request_user_token_usecase_impl.dart';

class KakaoAuthModule {
  static Widget provideKakaoLoginPage() {
    return MultiProvider(
      providers: [
        // Provide BaseUrlProvider
        ChangeNotifierProvider<BaseUrlProvider>(
          create: (_) => BaseUrlProvider(),
        ),

        // Inject BaseUrlProvider into KakaoAuthRemoteDataSource
        ProxyProvider<BaseUrlProvider, KakaoAuthRemoteDataSource>(
          update: (_, baseUrlProvider, __) =>
              KakaoAuthRemoteDataSource(baseUrlProvider.baseUrl),
        ),

        // Inject the KakaoAuthRemoteDataSource into repository
        ProxyProvider<KakaoAuthRemoteDataSource, KakaoAuthRepositoryImpl>(
          update: (_, remoteDataSource, __) =>
              KakaoAuthRepositoryImpl(remoteDataSource),
        ),

        // Provide UseCases
        ProxyProvider<KakaoAuthRepositoryImpl, LoginUseCaseImpl>(
          update: (_, repository, __) => LoginUseCaseImpl(repository),
        ),
        ProxyProvider<KakaoAuthRepositoryImpl, FetchUserInfoUseCaseImpl>(
          update: (_, repository, __) => FetchUserInfoUseCaseImpl(repository),
        ),
        ProxyProvider<KakaoAuthRepositoryImpl, RequestUserTokenUseCaseImpl>(
          update: (_, repository, __) =>
              RequestUserTokenUseCaseImpl(repository),
        ),

        // Provide the Provider for KakaoAuthProvider
        ChangeNotifierProvider<KakaoAuthProvider>(
          create: (context) => KakaoAuthProvider(
            loginUseCase: context.read<LoginUseCaseImpl>(),
            logoutUseCase: context.read<LogoutUseCaseImpl>(),
            fetchUserInfoUseCase: context.read<FetchUserInfoUseCaseImpl>(),
            requestUserTokenUseCase:
                context.read<RequestUserTokenUseCaseImpl>(),
          ),
        ),
      ],
      child: KakaoLoginPage(),
    );
  }
}
