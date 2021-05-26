class CreatePortfolios < ActiveRecord::Migration[6.0]
  def change
    create_table :portfolios do |t|
      t.timestamps
      t.string :title,  null: false,  unique: true
      t.text :description
      t.text :site_url,  null: false,  unique: true
      t.text :github_url
      t.references :user, forein_key: true
      t.references
    end
  end
end
