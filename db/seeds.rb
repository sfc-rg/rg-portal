# You can customize the behavior of the seed task to set environment variables below.
#
# SLACK_USER_ID
#   : Provide your slack user ID to this variable in order to log in as a test user.
#
# DELETE_ALL
#   : Set this variable as 'true' if you want to delete all data before creating
#     new data.
#
# USER_NUM
#   : You can specify the number of users the task will make. Default is 50.
#
# MEETING_NUM
#   : You can specify the number of meetings the task will make. Default is 14.

if ENV['DELETE_ALL'] == 'true'
  # groups
  Group.destroy_all
  # users
  User.destroy_all
  # meetings
  Meeting.destroy_all
  # presentation
  Presentation.destroy_all
  # pages
  Page.destroy_all
end

%w(groups users privileges meetings presentations user_judgement pages).each do |path|
  Dir.glob(File.join(Rails.root, 'db', 'seeds', "#{path}.rb")) do |file|
    load(file)
  end
end
