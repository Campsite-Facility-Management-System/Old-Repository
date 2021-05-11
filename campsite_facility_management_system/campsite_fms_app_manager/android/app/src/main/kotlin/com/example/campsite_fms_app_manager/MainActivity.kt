package com.example.campsite_fms_app_manager

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.SplashScreen

class MainActivity: FlutterActivity() {
        override fun provideSplashScreen(): SplashScreen? = SplashView()
}
