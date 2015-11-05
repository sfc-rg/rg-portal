include PreBuiltPagesHelper

base_day = 6.weeks.ago
base_start_at = Time.zone.local(base_day.year, base_day.month, base_day.day, 14, 45)
base_end_at = Time.zone.local(base_day.year, base_day.month, base_day.day, 18, 00)

meeting_num = (ENV['MEETING_NUM'] || 14).to_i

meeting_num.times do |i|
  Meeting.create!(
    name: "#{term_name}第#{i + 1}回授業",
    start_at: base_start_at + i.weeks,
    end_at: base_end_at + i.weeks,
    content: "第#{i + 1}回目の授業です。"
  )
end

Meeting.all.each do |meeting|
  next if meeting.start_at > Time.zone.now
  User.all.each do |user|
    meeting.meeting_attendances.build(user: user).save! if rand.round == 0
  end
end
