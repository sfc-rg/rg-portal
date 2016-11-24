module PaperCompetitionsHelper
  def paper_competition_pages_graph(competition)
    data = competition.paper_competition_attendances.map do |attendance|
      count_set = competition.paper_competition_checkpoints.where(user: attendance.user).pluck(:created_at, :num_of_pages).flatten
      {
        name: attendance.user.nickname,
        data: Hash[*count_set]
      }
    end
    line_chart data
  end

  def paper_competition_commits_graph(competition)
    data = competition.paper_competition_attendances.map do |attendance|
      count_set = competition.paper_competition_checkpoints.where(user: attendance.user).pluck(:created_at, :num_of_commits).flatten
      {
        name: attendance.user.nickname,
        data: Hash[*count_set]
      }
    end
    line_chart data
  end

  def paper_competitions_pages_ranking(competition)
    @competition.paper_competition_checkpoints.group(:user_id).order(:num_of_pages)
  end

  def paper_competitions_commits_ranking(competition)
    @competition.paper_competition_checkpoints.group(:user_id).order(:num_of_commits)
  end
end
