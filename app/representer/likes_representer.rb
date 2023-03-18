# Likes representer
class LikesRepresenter
  def initialize(likes)
    @likes = likes
  end

  def as_json
    likes.map do |like|
      {
        id: like.id,
        article_id: like.article_id,
        user_id: like.user_id,
        user_name: like.user.name
      }
    end
  end

  private

  attr_reader :likes
end
