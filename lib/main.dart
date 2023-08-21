import 'package:clean_articals/config/routes/routes.dart';
import 'package:clean_articals/config/theme/app_themes.dart';
import 'package:clean_articals/core/util/NetworkConnectivity/cubit/network_connectivity_cubit.dart';
import 'package:clean_articals/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:clean_articals/features/daily_news/presentation/bloc/article/remote/report_article_bloc.dart';
import 'package:clean_articals/features/daily_news/presentation/pages/home/daily_news.dart';
import 'package:clean_articals/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependancies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NetworkConnectivityCubit>(
          create: (context) => sl()..checkConnection(),
        ),
        BlocProvider<RemoteArticlesBloc>(
          create: (context) => sl()..add(const GetArticles()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme(),
        onGenerateRoute: AppRoutes.onGenerateRoutes,
        home: const DailyNews(),
      ),
    );
  }
}
