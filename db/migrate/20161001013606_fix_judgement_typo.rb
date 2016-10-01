class FixJudgementTypo < ActiveRecord::Migration
  def change
    rename_table :judgments, :judgements
  end
end
