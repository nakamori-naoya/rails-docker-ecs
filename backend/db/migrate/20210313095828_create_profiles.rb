class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :nickName
      t.text :image_data, comment: '画像データの名前'
      t.references :user, forein_key: true
      t.timestamps
    end
  end
end
