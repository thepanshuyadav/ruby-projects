# TODO: Handle ActiveRecord::RecordNotUnique for duplicate likes
module Api
  module V1
    # LikesController
    class LikesController < ApplicationController
      before_action :authenticate, only: %i[create destroy]

      # list all users who liked the article
      def index
        article_id = params[:article_id]
        likes = Like.where("article_id = '#{article_id}'")
        render json: LikesRepresenter.new(likes).as_json, status: :ok
      end

      # add like to an article for user
      def create
        article = Article.find(params[:article_id])
        _ = User.find(params[:like][:user_id])
        like = Like.new(like_params.merge(article_id: article.id))
        like.save!
        # Better way to do this: add observer and update like count for article?
        # TODO: handle error
        article.increment!(:likes_count, 1)
        render json: { result: 'added user like' }, status: :ok
      end

      # remove like from an article for user
      def destroy
        article = Article.find(params[:article_id])
        user = User.find(params[:like][:user_id])
        like = Like.find_by(article_id: article.id, user_id: user.id)
        if !like.nil? && like.destroy
          article.decrement!(:likes_count, 1)
          render json: { result: 'removed user like' }, status: :ok
        else
          render json: { result: "can't remove like" }, status: :unprocessable_entity
        end
      end

      private

      def like_params
        params.require(:like).permit(:user_id)
      end
    end
  end
end
