# TODO: Handle ActiveRecord::RecordNotUnique for duplicate likes
module Api
  module V1
    # LikesController
    class LikesController < ApplicationController
      # list all users who liked the article
      def index
        article_id = params[:article_id]
        likes = Like.where("article_id = '#{article_id}'")
        # render json: likes, status: :ok
        render json: LikesRepresenter.new(likes).as_json, status: :ok
      end

      # add like to an article for user
      def create
        # add observer and update like count for article?
        user = User.find(params[:like][:user_id])
        article = Article.find(params[:article_id])
        if !user.nil? && !article.nil?
          like = Like.new(like_params.merge(article_id: article.id))
          if like.save
            # Better way to do this?
            article.increment!(:likes_count, 1)
            render json: { result: "added user's like" }, status: :ok
          else
            render json: like.errors, status: :unprocessable_entity
          end
        else
          render json: { 'error': 'User/Article missing' }, status: :not_found
        end
      end

      # remove like from an article for user
      def destroy
        user = User.find(params[:like][:user_id])
        article = Article.find(params[:article_id])
        if !user.nil? && !article.nil?
          like = Like.find_by(article_id: article.id, user_id: user.id)
          if !like.nil? && like.destroy
            article.decrement!(:likes_count, 1)
            render json: { result: "removed user's like" }, status: :ok
          else
            render json: { result: "can't remove like"}, status: :unprocessable_entity
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
