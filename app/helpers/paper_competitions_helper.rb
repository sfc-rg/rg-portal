module PaperCompetitionsHelper
  def paper_competition_pages_graph(competition)
    data = competition.paper_competition_attendances.map do |attendance|
      count_set = competition.paper_competition_checkpoints.where(user: attendance.user).pluck(:created_at, :num_of_pages).flatten
      {
        name: attendance.user.nickname,
        data: Hash[*count_set]
      }
    end
    line_chart data, library: { interpolateNulls: true }
  end

  def paper_competition_commits_graph(competition)
    data = competition.paper_competition_attendances.map do |attendance|
      count_set = competition.paper_competition_checkpoints.where(user: attendance.user).pluck(:created_at, :num_of_commits).flatten
      {
        name: attendance.user.nickname,
        data: Hash[*count_set]
      }
    end
    line_chart data, library: { interpolateNulls: true }
  end

  def paper_competitions_pages_ranking(competition)
    competition.paper_competition_attendances.map do |attendance|
      competition.paper_competition_checkpoints.where(user: attendance.user).order('created_at DESC').first
    end.compact.sort_by(&:num_of_pages).reverse
  end

  def paper_competitions_commits_ranking(competition)
    competition.paper_competition_attendances.map do |attendance|
      competition.paper_competition_checkpoints.where(user: attendance.user).order('created_at DESC').first
    end.compact.sort_by(&:num_of_commits).reverse
  end
end
