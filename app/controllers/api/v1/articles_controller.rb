module Api
  module V1
    # ArticlesController
    class ArticlesController < ApplicationController
      MAX_PAGINATION_LIMIT = 10
      def index
        articles = Article.limit(limit).offset(params[:offset])
        render json: ArticlesRepresenter.new(articles).as_json, status: :ok
      end

      def create
        user = User.find_by(id: params[:article][:user_id])
        # how to handle param parsing error?
        if user.nil?
          render json: { 'error': 'User with given ID not found' }, status: :not_found
        else
          article = Article.new(article_params.merge(user_id: user.id, likes_count: 0))
          if article.save
            render json: ArticleRepresenter.new(article).as_json, status: :created
          else
            render json: article.errors, status: :unprocessable_entity
          end
        end
      end

      def show
        p params
        article = Article.find(params[:id])
        if article.nil?
          render json: { 'error': 'Article with given ID not present' }, status: :not_found
        else
          render json: ArticleRepresenter.new(article).as_json, status: :created
        end
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
