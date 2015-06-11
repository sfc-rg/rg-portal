class InitialSchema < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :nickname
      t.string :email
      t.string :icon_url

      t.timestamps null: false
    end

    create_table :slack_credentials do |t|
      t.references :users, index: true
      t.string :user_id

      t.timestamps null: false
    end

    create_table :pages do |t|
      t.string :path
      t.text :title
      t.text :content
      t.references :users, index: true

      t.timestamps null: false
    end

    create_table :renamed_pages do |t|
      t.string :before_path
      t.string :after_path

      t.timestamps null: false
    end

    create_table :comments do |t|
      t.references :user, index: true
      t.references :page, index: true
      t.text :content

      t.timestamps null: false
    end
  end
end
