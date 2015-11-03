def login_as_user(user = FactoryGirl.create(:user))
  session[:user_id] = user.id
end
