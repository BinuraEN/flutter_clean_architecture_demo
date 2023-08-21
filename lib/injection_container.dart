import 'package:clean_articals/core/util/NetworkConnectivity/cubit/network_connectivity_cubit.dart';
import 'package:clean_articals/features/daily_news/data/datasources/local/app_database.dart';
import 'package:clean_articals/features/daily_news/data/datasources/remote/news_api_service.dart';
import 'package:clean_articals/features/daily_news/data/repository/article_repository_impl.dart';
import 'package:clean_articals/features/daily_news/domain/repository/article_repository.dart';
import 'package:clean_articals/features/daily_news/domain/usecases/delete_article.dart';
import 'package:clean_articals/features/daily_news/domain/usecases/get_article.dart';
import 'package:clean_articals/features/daily_news/domain/usecases/get_saved_article.dart';
import 'package:clean_articals/features/daily_news/domain/usecases/save_article.dart';
import 'package:clean_articals/features/daily_news/presentation/bloc/article/remote/report_article_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

final sl = GetIt.instance;

Future<void> initializeDependancies() async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  sl.registerSingleton<AppDatabase>(database);

  //before registering the NewsApiService, we need to register Dio
  //because Dio is used by NewsApiService
  sl.registerSingleton<Dio>(Dio());
  sl.registerSingleton<NewsApiService>(NewsApiService(sl()));
  sl.registerSingleton<ArticleRepository>(ArticleRepositoryImpl(sl(), sl()));
  sl.registerSingleton<GetArticleUseCase>(GetArticleUseCase(sl()));
  sl.registerSingleton<GetSavedArticlesUseCase>(GetSavedArticlesUseCase(sl()));
  sl.registerSingleton<SaveArticleUseCase>(SaveArticleUseCase(sl()));
  sl.registerSingleton<DeleteArticleUseCase>(DeleteArticleUseCase(sl()));

  sl.registerFactory<NetworkConnectivityCubit>(
    () => NetworkConnectivityCubit(),
  );
  sl.registerFactory<RemoteArticlesBloc>(
    () => RemoteArticlesBloc(sl()),
  );
}
