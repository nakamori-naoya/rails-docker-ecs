class CreatePortfolios < ActiveRecord::Migration[6.0]
  def change
    create_table :portfolios do |t|
      t.timestamps
      t.string :name,  null: false,  unique: true
      t.text :background_of_creation 
      t.text :remarkable_point
      t.text :future_issue
      t.text :url,  null: false,  unique: true
      t.references :user, forein_key: true
    end
  end
end
