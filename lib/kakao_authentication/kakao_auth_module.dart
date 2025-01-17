import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'presentation/ui/kakao_login_page.dart';
import 'infrastructure/data_sources/kakao_auth_remote_data_source.dart';
import 'presentation/providers/kakao_auth_providers.dart';

class KakaoAuthModule {
  static Widget provideKakaoLoginPage() {
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
      child: KakaoLoginPage(),
    );
  }
}
