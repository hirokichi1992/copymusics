class CreateOwnerships < ActiveRecord::Migration[5.0]
  def change
    create_table :ownerships do |t|
      t.references :user, foreign_key: true
      t.references :music, foreign_key: true
      t.string :type

      t.timestamps
      
      t.index [:user_id, :music_id, :type], unique: true
    end
  end
end
