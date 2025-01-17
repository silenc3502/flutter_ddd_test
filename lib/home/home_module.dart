import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../kakao_authentication/presentation/providers/kakao_auth_providers.dart';
import '../kakao_authentication/infrastructure/data_sources/kakao_auth_remote_data_source.dart';
import 'presentation/ui/home_page.dart';

class HomeModule {
  static Widget provideHomePage() {
    return MultiProvider(
      providers: [
        Provider<KakaoAuthRemoteDataSource>(
          create: (_) => KakaoAuthRemoteDataSource(),
        ),
        ChangeNotifierProvider<KakaoAuthProvider>(
          create: (context) => KakaoAuthProvider(
            kakaoAuthRemoteDataSource:
                context.read<KakaoAuthRemoteDataSource>(),
          ),
        ),
      ],
      child: HomePage(),
    );
  }
}
