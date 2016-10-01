class FixJudgementTypo < ActiveRecord::Migration
  def change
    rename_table :user_judgments, :user_judgements
  end
end
