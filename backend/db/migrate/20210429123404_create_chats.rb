class CreateChats < ActiveRecord::Migration[6.0]
  def change
    create_table :chats do |t|
      t.text :text,  null: false
      t.references :user, forein_key: true
      t.references :portfolio, forein_key: true
      t.timestamps
    end
  end
end
