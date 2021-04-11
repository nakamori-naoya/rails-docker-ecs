class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :user, forein_key: true
      t.references :blog, forein_key: true
      t.string :title
      t.text :text
      t.timestamps
    end
  end
end
