presentations = Presentation.all
presentations.each do |presentation|
  next unless presentation.juried
  User.all.each do |user|
    presentation.user_judgements.create!(user: user, passed: rand.round == 0) if rand.round == 0
  end
end
