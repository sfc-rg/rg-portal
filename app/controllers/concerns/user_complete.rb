module UserComplete
  def set_user_completion
    gon.users = User.select([:nickname, :icon_url]).map { |user| [user.nickname, user.icon_url] }.to_h
  end
end
