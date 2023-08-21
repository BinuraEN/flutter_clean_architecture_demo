import 'package:clean_articals/core/usecase/usecase.dart';
import 'package:clean_articals/features/daily_news/domain/entities/article.dart';
import 'package:clean_articals/features/daily_news/domain/repository/article_repository.dart';

class GetSavedArticlesUseCase implements UseCase<List<ArticleEntity>, void> {
  final ArticleRepository _articleRepository;
  GetSavedArticlesUseCase(this._articleRepository);
  @override
  Future<List<ArticleEntity>> call({void params}) {
    return _articleRepository.getSavedArticles();
  }
}
