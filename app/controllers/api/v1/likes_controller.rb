# TODO: Handle ActiveRecord::RecordNotUnique for duplicate likes
module Api
  module V1
    # LikesController
    class LikesController < ApplicationController
      def create
        # add observer and update like count for article?
        user = User.find(params[:like][:user_id])
        article = Article.find(params[:article_id])
        if !user.nil? && !article.nil?
          like = Like.new(like_params.merge(article_id: article.id))
          if like.save
            # Better way to do this?
            article.increment!(:likes_count, 1)
            render json: {}, status: :ok
          else
            render json: like.errors, status: :unprocessable_entity
          end
        else
          render json: { 'error': 'User/Article missing' }, status: :not_found
        end
      end

      private

      def like_params
        params.require(:like).permit(:user_id)
      end
    end
  end
end
