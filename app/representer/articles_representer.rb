# ArticlesRepresenter
class ArticlesRepresenter
  def initialize(articles)
    @articles = articles
  end

  def as_json
    articles.map do |article|
      {
        id: article.id,
        title: article.title,
        description: article.description,
        likes_count: article.likes_count
      }
    end
  end

  private

  attr_reader :articles
end
