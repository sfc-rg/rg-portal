user = User.first
user.privileges.create!(model: 'user_judgements', action: 'index')
user.privileges.create!(model: 'meetings', action: 'update')
