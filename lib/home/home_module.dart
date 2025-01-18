import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/base_url_provider.dart';
import '../kakao_authentication/domain/usecases/fetch_user_info_usecase_impl.dart';
import '../kakao_authentication/domain/usecases/login_usecase_impl.dart';
import '../kakao_authentication/domain/usecases/logout_usecase_impl.dart';
import '../kakao_authentication/domain/usecases/request_user_token_usecase_impl.dart';
import '../kakao_authentication/infrastructure/repository/kakao_auth_repository.dart';
import '../kakao_authentication/infrastructure/repository/kakao_auth_repository_impl.dart';
import '../kakao_authentication/presentation/providers/kakao_auth_providers.dart';
import '../kakao_authentication/infrastructure/data_sources/kakao_auth_remote_data_source.dart';
import 'presentation/ui/home_page.dart';

class HomeModule {
  static Widget provideHomePage() {
    return MultiProvider(
      providers: [
        // Provide the repository
        Provider<KakaoAuthRepository>(
          create: (_) => KakaoAuthRepositoryImpl(
              KakaoAuthRemoteDataSource('your_base_url_here')),
        ),

        // Provide the use cases with their required repository dependencies
        Provider<LoginUseCaseImpl>(
          create: (context) =>
              LoginUseCaseImpl(context.read<KakaoAuthRepository>()),
        ),
        Provider<LogoutUseCaseImpl>(
          create: (context) =>
              LogoutUseCaseImpl(context.read<KakaoAuthRepository>()),
        ),
        Provider<FetchUserInfoUseCaseImpl>(
          create: (context) =>
              FetchUserInfoUseCaseImpl(context.read<KakaoAuthRepository>()),
        ),
        Provider<RequestUserTokenUseCaseImpl>(
          create: (context) =>
              RequestUserTokenUseCaseImpl(context.read<KakaoAuthRepository>()),
        ),

        // Provide the KakaoAuthRemoteDataSource
        Provider<KakaoAuthRemoteDataSource>(
          create: (_) => KakaoAuthRemoteDataSource('your_base_url_here'),
        ),

        // Finally, provide KakaoAuthProvider
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
      child: HomePage(),
    );
  }
}
