class CreatePaperCompetitions < ActiveRecord::Migration
  def change
    create_table :paper_competitions do |t|
      t.string :name
      t.string :slack_report_channel
      t.timestamps null: false
    end
  end
end
