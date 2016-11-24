class PaperCompetition < ActiveRecord::Base
  has_many :paper_competition_attendances
  has_many :paper_competition_checkpoints
end
