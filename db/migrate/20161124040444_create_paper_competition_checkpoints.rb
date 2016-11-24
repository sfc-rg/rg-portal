class CreatePaperCompetitionCheckpoints < ActiveRecord::Migration
  def change
    create_table :paper_competition_checkpoints do |t|
      t.references :user, index: true
      t.references :paper_competition, index: true
      t.text :message
      t.integer :num_of_pages
      t.integer :num_of_commits
      t.timestamps null: false
    end
  end
end
