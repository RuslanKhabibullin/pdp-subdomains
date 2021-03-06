class PostDecorator < ApplicationDecorator
  decorates_association :user

  delegate :id, :title, :content, :average_rating
  delegate :full_name, to: :user, prefix: true

  def content_preview
    h.truncate(object.content, length: 400, separator: " ")
  end

  def formatted_creation_date
    object.created_at.strftime("%d-%m-%Y")
  end

  def rated_by?(user)
    object.ratings.exists?(user_id: user.id)
  end
end
