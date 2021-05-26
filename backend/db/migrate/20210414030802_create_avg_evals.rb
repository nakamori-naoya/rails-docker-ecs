class CreateAvgEvals < ActiveRecord::Migration[6.0]
  def change
    create_table :avg_evals do |t|
      t.float :sociality, null: false
      t.float :usability, null: false
      t.float :business_oriented, null: false
      t.float :creativity, null: false
      t.float :skill, null: false
      t.float :comprehensive_evaluation, null: false
      t.references :portfolio, forein_key: true
      t.timestamps
    end
  end
end
