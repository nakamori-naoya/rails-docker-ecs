class CreatePortfolioCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :portfolio_categories do |t|
      t.references :portfolio, forein_key: true
      t.references :category, forein_key: true
      t.timestamps
    end
  end
end
