class CreateBlogs < ActiveRecord::Migration[5.2]
  def change
    create_table :blogs do |t|
      t.string :title
      t.string :text
      t.text :image_data
      t.references :user, forein_key: true
      t.timestamps
    end
  end
end
