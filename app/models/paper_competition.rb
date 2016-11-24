class PaperCompetition < ActiveRecord::Base
  has_many :paper_competition_attendances
  has_many :paper_competition_checkpoints

  def joined?(user)
    self.paper_competition_attendances.where(user: user).exists?
  end
end
