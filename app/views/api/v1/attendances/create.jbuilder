json.user do
  json.extract! @user, :name, :nickname, :icon_url
end
json.attendance_count attendance_count(@user)
