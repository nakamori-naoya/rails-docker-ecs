class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :nickname,  null: false,  unique: true
      t.text :self_introduction
      t.date :programming_start_date, null: false
      t.string :web_site_url
      t.references :user, forein_key: true
      t.timestamps
    end
  end
end
