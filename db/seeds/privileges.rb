user = User.first
user.privileges.create!(model: 'user_judgments', action: 'index')
user.privileges.create!(model: 'meetings', action: 'update')
