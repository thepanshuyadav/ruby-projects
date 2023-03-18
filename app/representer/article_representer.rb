# ArticlesRepresenter
class ArticleRepresenter
  def initialize(article)
    @article = article
  end

  def as_json
    {
      id: article.id,
      title: article.title,
      description: article.description,
      likes_count: article.likes_count
    }
  end

  private

  attr_reader :article
end
