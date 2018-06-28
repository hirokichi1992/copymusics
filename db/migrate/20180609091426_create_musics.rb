class CreateMusics < ActiveRecord::Migration[5.0]
  def change
    create_table :musics do |t|
      t.string :name
      t.string :recording_id
      t.string :artist_id
      t.string :album_id
      
      t.timestamps
    end
  end
end
