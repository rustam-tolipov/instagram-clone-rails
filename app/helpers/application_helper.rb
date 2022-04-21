module ApplicationHelper
  def avatar_url(user)
    user.image_url || 'img/user.png'
  end
end
