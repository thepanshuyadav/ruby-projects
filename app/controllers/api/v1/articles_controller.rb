module Api
  module V1
    # ArticlesController
    class ArticlesController < ApplicationController
      MAX_PAGINATION_LIMIT = 10

      before_action :authenticate, only: %i[create]

      def index
        articles = Article.limit(limit).offset(params[:offset])
        render json: ArticlesRepresenter.new(articles).as_json, status: :ok
      end

      def create
        user = User.find(params[:article][:user_id])
        article = Article.new(article_params.merge(user_id: user.id, likes_count: 0))
        article.save!
        render json: ArticleRepresenter.new(article).as_json, status: :created
      end

      def show
        article = Article.find(params[:id])
        render json: ArticleRepresenter.new(article).as_json, status: :created
      end

      private

      def article_params
        params.require(:article).permit(:title, :description, :user_id)
      end

      def limit
        [params.fetch(:limit, MAX_PAGINATION_LIMIT).to_i, MAX_PAGINATION_LIMIT].min
      end
    end
  end
end
