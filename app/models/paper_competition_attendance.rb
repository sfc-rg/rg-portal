class PaperCompetitionAttendance < ActiveRecord::Base
  belongs_to :user
  belongs_to :paper_competition
end
