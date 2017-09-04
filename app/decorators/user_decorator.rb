class UserDecorator < ApplicationDecorator
  delegate :id, :first_name, :last_name, :email, :persisted?

  def posts_count
    object.posts.count
  end

  def full_name
    "#{object.first_name} #{object.last_name}"
  end
end