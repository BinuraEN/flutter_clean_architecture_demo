import 'package:clean_articals/features/daily_news/presentation/pages/home/daily_news.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const DailyNews());
      default:
        return MaterialPageRoute(builder: (_) => const DailyNews());
    }
  }
}
