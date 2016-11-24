class CreatePaperCompetitionAttendances < ActiveRecord::Migration
  def change
    create_table :paper_competition_attendances do |t|
      t.references :user, index: true
      t.references :paper_competition, index: true
      t.text :target_repository
      t.string :target_branch
      t.string :target_path
      t.text :private_key
      t.text :public_key
      t.string :callback_token
      t.timestamps null: false
    end
  end
end
